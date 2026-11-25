import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:perfumery_lab/core/database/app_database.dart';
import 'package:perfumery_lab/features/materials/data/materials_repository.dart';

final formulasRepositoryProvider = Provider<FormulasRepository>((ref) {
  final db = ref.watch(databaseProvider);
  return FormulasRepository(db);
});

final formulasStreamProvider = StreamProvider<List<Formula>>((ref) {
  final repo = ref.watch(formulasRepositoryProvider);
  return repo.watchAllFormulas();
});

final formulasWithItemsStreamProvider =
    StreamProvider<List<FormulaWithMaterials>>((ref) {
  final repo = ref.watch(formulasRepositoryProvider);
  return repo.watchAllFormulasWithItems();
});

class FormulaWithMaterials {
  final Formula formula;
  final List<FormulaItemWithMaterial> items;
  FormulaWithMaterials({required this.formula, required this.items});

  double get totalPpt =>
      items.fold(0.0, (sum, i) => sum + i.item.partsPerThousand);
}

class FormulaItemWithMaterial {
  final FormulaItem item;
  final Material material;
  FormulaItemWithMaterial({required this.item, required this.material});
}

class CompoundedBatchItemResult {
  final String materialId;
  final String materialName;
  final double weighedGrams;
  final double previousStockGrams;
  final double remainingStockGrams;

  CompoundedBatchItemResult({
    required this.materialId,
    required this.materialName,
    required this.weighedGrams,
    required this.previousStockGrams,
    required this.remainingStockGrams,
  });
}

class CompoundingExecutionResult {
  final String batchId;
  final String batchNumber;
  final double totalWeighedGrams;
  final List<CompoundedBatchItemResult> itemResults;

  CompoundingExecutionResult({
    required this.batchId,
    required this.batchNumber,
    required this.totalWeighedGrams,
    required this.itemResults,
  });
}

class FormulasRepository {
  final AppDatabase _db;
  FormulasRepository(this._db);

  Stream<List<Formula>> watchAllFormulas() {
    return (_db.select(_db.formulas)
          ..orderBy([
            (t) => OrderingTerm(expression: t.updatedAt, mode: OrderingMode.desc)
          ]))
        .watch();
  }

  Stream<List<FormulaWithMaterials>> watchAllFormulasWithItems() {
    return watchAllFormulas().asyncMap((formulas) async {
      if (formulas.isEmpty) return <FormulaWithMaterials>[];

      final rows = await _db.select(_db.formulaItems).join([
        innerJoin(_db.materials,
            _db.materials.id.equalsExp(_db.formulaItems.materialId))
      ]).get();

      final grouped = <String, List<FormulaItemWithMaterial>>{};
      for (final row in rows) {
        final item = row.readTable(_db.formulaItems);
        final mat = row.readTable(_db.materials);
        grouped.putIfAbsent(item.formulaId, () => []).add(
              FormulaItemWithMaterial(item: item, material: mat),
            );
      }

      return formulas
          .map((f) => FormulaWithMaterials(
                formula: f,
                items: grouped[f.id] ?? const [],
              ))
          .toList();
    });
  }

  Stream<FormulaWithMaterials?> watchFormulaWithItems(String formulaId) {
    final formulaQuery = _db.select(_db.formulas)
      ..where((t) => t.id.equals(formulaId));

    return formulaQuery.watchSingleOrNull().asyncMap((formula) async {
      if (formula == null) return null;

      final query = _db.select(_db.formulaItems).join([
        innerJoin(
            _db.materials, _db.materials.id.equalsExp(_db.formulaItems.materialId))
      ])..where(_db.formulaItems.formulaId.equals(formulaId));

      final rows = await query.get();
      final items = rows.map((row) {
        return FormulaItemWithMaterial(
          item: row.readTable(_db.formulaItems),
          material: row.readTable(_db.materials),
        );
      }).toList();

      return FormulaWithMaterials(formula: formula, items: items);
    });
  }

  Future<void> createFormula(FormulasCompanion formula) {
    return _db.into(_db.formulas).insertOnConflictUpdate(formula);
  }

  Future<void> updateFormula(FormulasCompanion formula) {
    return _db.update(_db.formulas).replace(formula);
  }

  Future<int> deleteFormula(String formulaId) {
    return (_db.delete(_db.formulas)..where((t) => t.id.equals(formulaId))).go();
  }

  Future<void> addOrUpdateItem(FormulaItemsCompanion item) {
    return _db.into(_db.formulaItems).insertOnConflictUpdate(item);
  }

  Future<int> deleteItem(String itemId) {
    return (_db.delete(_db.formulaItems)..where((t) => t.id.equals(itemId))).go();
  }

  /// Duplicates a formula as an iterative variation ("Mod"), copying all line items.
  Future<String> duplicateFormulaAsMod({
    required String sourceFormulaId,
    required String newName,
    String? newVersion,
  }) async {
    final newFormulaId = const Uuid().v4();
    final sourceFormula = await (_db.select(_db.formulas)
          ..where((t) => t.id.equals(sourceFormulaId)))
        .getSingle();

    final sourceItems = await (_db.select(_db.formulaItems)
          ..where((t) => t.formulaId.equals(sourceFormulaId)))
        .get();

    await _db.transaction(() async {
      await _db.into(_db.formulas).insert(
            FormulasCompanion.insert(
              id: newFormulaId,
              name: newName,
              version: Value(newVersion ?? 'Mod 2'),
              description: Value(sourceFormula.description),
              targetConcentrationPercent:
                  Value(sourceFormula.targetConcentrationPercent),
            ),
          );

      for (final item in sourceItems) {
        await _db.into(_db.formulaItems).insert(
              FormulaItemsCompanion.insert(
                id: const Uuid().v4(),
                formulaId: newFormulaId,
                materialId: item.materialId,
                partsPerThousand: item.partsPerThousand,
                specifiedDilutionPercent:
                    Value(item.specifiedDilutionPercent),
                notes: Value(item.notes),
              ),
            );
      }
    });

    return newFormulaId;
  }

  /// Atomically finishes compounding: records an aging batch, updates bottle stock in-place,
  /// and writes an immutable audit log entry in [InventoryLogs].
  Future<CompoundingExecutionResult> compoundBatchAndDeductStock({
    required String formulaId,
    required String formulaName,
    required String batchNumber,
    required double targetBatchGrams,
    required Map<String, double> weighedGramsByMaterialId,
    int targetAgingDays = 14,
  }) async {
    final batchId = const Uuid().v4();
    final itemResults = <CompoundedBatchItemResult>[];
    double totalWeighed = 0.0;

    await _db.transaction(() async {
      // 1. Create Aging Batches record
      await _db.into(_db.agingBatches).insert(
            AgingBatchesCompanion.insert(
              id: batchId,
              batchNumber: batchNumber,
              name: '$formulaName Concentrate',
              sourceType: 'formula',
              sourceId: formulaId,
              stage: 'maturation',
              totalWeightGrams: targetBatchGrams,
              concentrationPercent: 100.0, // Concentrate
              startDate: DateTime.now(),
              targetAgingDays: Value(targetAgingDays),
            ),
          );

      // 2. Process stock deduction for each weighed material
      for (final entry in weighedGramsByMaterialId.entries) {
        final matId = entry.key;
        final weighedGrams = entry.value;
        if (weighedGrams <= 0) continue;

        totalWeighed += weighedGrams;

        final material = await (_db.select(_db.materials)
              ..where((t) => t.id.equals(matId)))
            .getSingleOrNull();

        if (material != null) {
          final prevStock = material.stockGrams;
          final remainingStock = prevStock - weighedGrams;

          // Update material stock
          await (_db.update(_db.materials)..where((t) => t.id.equals(matId))).write(
            MaterialsCompanion(
              stockGrams: Value(remainingStock),
            ),
          );

          // Write audit log in InventoryLogs
          await _db.into(_db.inventoryLogs).insert(
                InventoryLogsCompanion.insert(
                  id: const Uuid().v4(),
                  materialId: matId,
                  deltaGrams: -weighedGrams,
                  remainingStockGrams: remainingStock,
                  reason: 'compounding',
                  referenceBatchId: Value(batchId),
                ),
              );

          itemResults.add(
            CompoundedBatchItemResult(
              materialId: matId,
              materialName: material.name,
              weighedGrams: weighedGrams,
              previousStockGrams: prevStock,
              remainingStockGrams: remainingStock,
            ),
          );
        }
      }
    });

    return CompoundingExecutionResult(
      batchId: batchId,
      batchNumber: batchNumber,
      totalWeighedGrams: totalWeighed,
      itemResults: itemResults,
    );
  }
}

