import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'tables/materials_table.dart';
import 'tables/ready_oils_table.dart';
import 'tables/formulas_table.dart';
import 'tables/aging_tables.dart';
import 'tables/inventory_logs_table.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [
  Materials,
  ReadyOils,
  Formulas,
  FormulaItems,
  AgingBatches,
  AgingEvaluations,
  InventoryLogs,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? e]) : super(e ?? _openConnection());

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) => m.createAll(),
        onUpgrade: (m, from, to) async {
          if (from == 1) {
            await m.createTable(inventoryLogs);
          }
        },
      );

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'perfumery_lab_db',
      native: const DriftNativeOptions(
        shareAcrossIsolates: true,
      ),
    );
  }
}
