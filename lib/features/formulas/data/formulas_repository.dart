import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
}
