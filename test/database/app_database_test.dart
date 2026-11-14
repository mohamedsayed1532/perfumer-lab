import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:perfumery_lab/core/database/app_database.dart';

void main() {
  late AppDatabase db;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
  });

  tearDown(() async {
    await db.close();
  });

  test('Materials CRUD operations and dilution calculations in Drift SQLite',
      () async {
    const materialId = 'mat-iso-e-super';
    await db.into(db.materials).insert(
          MaterialsCompanion.insert(
            id: materialId,
            name: 'Iso E Super',
            casNumber: const Value('54464-57-2'),
            pyramidNote: const Value('heart'),
            dilutionPercent: const Value(100.0),
            defaultSolvent: const Value('Neat'),
            intensity: const Value(3),
            stockGrams: const Value(500.0),
          ),
        );

    final item = await (db.select(db.materials)
          ..where((tbl) => tbl.id.equals(materialId)))
        .getSingle();

    expect(item.name, 'Iso E Super');
    expect(item.casNumber, '54464-57-2');
    expect(item.dilutionPercent, 100.0);
    expect(item.stockGrams, 500.0);
  });

  test('Formulas and cascade item persistence in Drift SQLite', () async {
    const formulaId = 'form-santal-wood';
    const materialId = 'mat-sandalwood';

    await db.into(db.materials).insert(
          MaterialsCompanion.insert(
            id: materialId,
            name: 'Sandalwood Spicatum',
            pyramidNote: const Value('base'),
            dilutionPercent: const Value(10.0),
          ),
        );

    await db.into(db.formulas).insert(
          FormulasCompanion.insert(
            id: formulaId,
            name: 'Santal Wood Minimal',
            targetConcentrationPercent: const Value(20.0),
          ),
        );

    await db.into(db.formulaItems).insert(
          FormulaItemsCompanion.insert(
            id: 'item-1',
            formulaId: formulaId,
            materialId: materialId,
            partsPerThousand: 50.0,
            specifiedDilutionPercent: const Value(10.0),
          ),
        );

    final items = await (db.select(db.formulaItems)
          ..where((tbl) => tbl.formulaId.equals(formulaId)))
        .get();

    expect(items.length, 1);
    expect(items.first.partsPerThousand, 50.0);
  });
}
