import 'package:drift/drift.dart';

/// Compounded Batches & Aging Sessions (Maturation & Maceration).
class AgingBatches extends Table {
  TextColumn get id => text()(); // UUID
  TextColumn get batchNumber => text()(); // e.g. "B-2026-001"
  TextColumn get name => text()();

  // 'formula' or 'ready_oil'
  TextColumn get sourceType => text()();
  TextColumn get sourceId => text()();

  // 'maturation' (concentrate oil) or 'maceration' (perfume with ethanol)
  TextColumn get stage => text()();

  RealColumn get totalWeightGrams => real()();
  RealColumn get concentrationPercent => real()(); // e.g. 20.0%
  TextColumn get alcoholType => text().nullable()(); // '96% Perfumers Alcohol'
  RealColumn get waterPercent => real().withDefault(const Constant(0.0))();

  DateTimeColumn get startDate => dateTime()();
  IntColumn get targetAgingDays => integer().withDefault(const Constant(30))();

  // 'active', 'completed', 'filtered', 'discarded'
  TextColumn get status => text().withDefault(const Constant('active'))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

/// Sensory evaluation logbook per check-in milestone.
class AgingEvaluations extends Table {
  TextColumn get id => text()();
  TextColumn get batchId => text().references(AgingBatches, #id,
      onDelete: KeyAction.cascade)();

  DateTimeColumn get evaluationDate => dateTime()();
  IntColumn get dayNumber => integer()(); // e.g. Day 14

  // Visual clarity: 'crystal_clear', 'slightly_hazy', 'hazy', 'sediment'
  TextColumn get clarity => text()();

  // Color observation: e.g. 'Pale Straw', 'Darkened Amber'
  TextColumn get colorDescription => text()();

  // Sensory scores (1-5 scale)
  IntColumn get alcoholSoftness => integer()(); // 1 = harsh, 5 = smooth/dissipated
  IntColumn get harmonyScore => integer()(); // 1 = raw/unblended, 5 = harmonized

  TextColumn get perfumerNotes => text().nullable()();
  BoolColumn get isChillFiltered => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}
