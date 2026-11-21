import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:perfumery_lab/core/database/app_database.dart';
import 'package:perfumery_lab/features/formulas/data/formulas_repository.dart';

void main() {
  late AppDatabase db;
  late FormulasRepository repo;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    repo = FormulasRepository(db);
  });

  tearDown(() async {
    await db.close();
  });

  test('duplicateFormulaAsMod duplicates formula header and all items', () async {
    const originalFormulaId = 'formula-orig';
    const mat1Id = 'mat-1';
    const mat2Id = 'mat-2';

    await db.into(db.materials).insert(
          MaterialsCompanion.insert(
            id: mat1Id,
            name: 'Hedione',
            stockGrams: const Value(100.0),
          ),
        );
    await db.into(db.materials).insert(
          MaterialsCompanion.insert(
            id: mat2Id,
            name: 'Ambroxan',
            stockGrams: const Value(50.0),
          ),
        );

    await repo.createFormula(
      FormulasCompanion.insert(
        id: originalFormulaId,
        name: 'Ocean Accord',
        version: const Value('1.0'),
        targetConcentrationPercent: const Value(20.0),
      ),
    );

    await repo.addOrUpdateItem(
      FormulaItemsCompanion.insert(
        id: 'item-1',
        formulaId: originalFormulaId,
        materialId: mat1Id,
        partsPerThousand: 800.0,
      ),
    );

    await repo.addOrUpdateItem(
      FormulaItemsCompanion.insert(
        id: 'item-2',
        formulaId: originalFormulaId,
        materialId: mat2Id,
        partsPerThousand: 200.0,
      ),
    );

    final newFormulaId = await repo.duplicateFormulaAsMod(
      sourceFormulaId: originalFormulaId,
      newName: 'Ocean Accord Mod 2',
      newVersion: '2.0',
    );

    expect(newFormulaId.isNotEmpty, isTrue);
    expect(newFormulaId, isNot(equals(originalFormulaId)));

    final newFormula = await (db.select(db.formulas)
          ..where((t) => t.id.equals(newFormulaId)))
        .getSingle();
    expect(newFormula.name, 'Ocean Accord Mod 2');
    expect(newFormula.version, '2.0');

    final newItems = await (db.select(db.formulaItems)
          ..where((t) => t.formulaId.equals(newFormulaId)))
        .get();
    expect(newItems.length, 2);
    expect(newItems.map((i) => i.materialId).toSet(), containsAll([mat1Id, mat2Id]));
  });

  test('compoundBatchAndDeductStock atomically deducts stock and writes inventory logs',
      () async {
    const matId = 'mat-iso-e';
    await db.into(db.materials).insert(
          MaterialsCompanion.insert(
            id: matId,
            name: 'Iso E Super',
            stockGrams: const Value(100.0),
          ),
        );

    const formulaId = 'formula-woody';
    await repo.createFormula(
      FormulasCompanion.insert(
        id: formulaId,
        name: 'Woody Base',
      ),
    );

    final result = await repo.compoundBatchAndDeductStock(
      formulaId: formulaId,
      formulaName: 'Woody Base',
      batchNumber: 'MAT-2026-TEST',
      targetBatchGrams: 50.0,
      weighedGramsByMaterialId: {
        matId: 25.5,
      },
    );

    expect(result.batchNumber, 'MAT-2026-TEST');
    expect(result.totalWeighedGrams, 25.5);
    expect(result.itemResults.length, 1);
    expect(result.itemResults.first.previousStockGrams, 100.0);
    expect(result.itemResults.first.remainingStockGrams, closeTo(74.5, 0.001));

    // Check material stock updated in database
    final material = await (db.select(db.materials)..where((t) => t.id.equals(matId)))
        .getSingle();
    expect(material.stockGrams, closeTo(74.5, 0.001));

    // Check aging batch created
    final batch = await (db.select(db.agingBatches)
          ..where((t) => t.id.equals(result.batchId)))
        .getSingle();
    expect(batch.batchNumber, 'MAT-2026-TEST');
    expect(batch.stage, 'maturation');

    // Check inventory logs written
    final logs = await (db.select(db.inventoryLogs)
          ..where((t) => t.referenceBatchId.equals(result.batchId)))
        .get();
    expect(logs.length, 1);
    expect(logs.first.materialId, matId);
    expect(logs.first.deltaGrams, -25.5);
    expect(logs.first.remainingStockGrams, closeTo(74.5, 0.001));
    expect(logs.first.reason, 'compounding');
  });
}
