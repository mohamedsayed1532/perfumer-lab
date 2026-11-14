import 'package:drift/drift.dart';
import 'materials_table.dart';

/// Fragrance Formula header.
class Formulas extends Table {
  TextColumn get id => text()(); // UUID
  TextColumn get name => text()();
  TextColumn get version => text().withDefault(const Constant('1.0'))();
  TextColumn get description => text().nullable()();
  RealColumn get targetConcentrationPercent =>
      real().withDefault(const Constant(20.0))(); // Default 20% EdP
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

/// Line items in a fragrance formula.
class FormulaItems extends Table {
  TextColumn get id => text()();
  TextColumn get formulaId => text().references(Formulas, #id,
      onDelete: KeyAction.cascade)();
  TextColumn get materialId => text().references(Materials, #id)();

  // Concentration in formula (Parts per Thousand, e.g. 10.5 ppt)
  RealColumn get partsPerThousand => real()();

  // Formula-specified dilution (e.g. 10.0 for 10% in DPG or 100 for neat)
  RealColumn get specifiedDilutionPercent =>
      real().withDefault(const Constant(100.0))();

  TextColumn get notes => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
