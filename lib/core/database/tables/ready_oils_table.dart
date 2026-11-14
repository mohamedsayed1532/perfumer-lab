import 'package:drift/drift.dart';

/// Pre-blended commercial Fragrance Oils (FO).
class ReadyOils extends Table {
  TextColumn get id => text()(); // UUID
  TextColumn get name => text()();
  TextColumn get supplier => text().nullable()();
  TextColumn get lotNumber => text().nullable()();
  RealColumn get stockGrams => real().withDefault(const Constant(0.0))();
  RealColumn get costPerGram => real().withDefault(const Constant(0.0))();
  RealColumn get recommendedDosagePercent => real().nullable()(); // e.g. 15-20%
  RealColumn get ifraMaxPercent => real().nullable()();
  RealColumn get flashPoint => real().nullable()();
  TextColumn get notes => text().nullable()();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}
