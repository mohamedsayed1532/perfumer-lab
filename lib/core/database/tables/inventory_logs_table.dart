import 'package:drift/drift.dart';
import 'materials_table.dart';

/// Immutable audit ledger recording stock changes for lab raw materials.
class InventoryLogs extends Table {
  TextColumn get id => text()(); // UUID
  TextColumn get materialId => text().references(Materials, #id)();

  // Negative for deduction, positive for restock / calibration
  RealColumn get deltaGrams => real()();

  // Snapshot of remaining stock after this change
  RealColumn get remainingStockGrams => real()();

  // 'compounding', 'manual_adjustment', 'restock', 'spill'
  TextColumn get reason => text()();

  // Linked AgingBatch ID or Formula ID if triggered by compounding
  TextColumn get referenceBatchId => text().nullable()();

  DateTimeColumn get timestamp => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}
