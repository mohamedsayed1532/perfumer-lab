import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'tables/materials_table.dart';
import 'tables/ready_oils_table.dart';
import 'tables/formulas_table.dart';
import 'tables/aging_tables.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [
  Materials,
  ReadyOils,
  Formulas,
  FormulaItems,
  AgingBatches,
  AgingEvaluations,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? e]) : super(e ?? _openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'perfumery_lab_db',
      native: const DriftNativeOptions(
        shareAcrossIsolates: true,
      ),
    );
  }
}
