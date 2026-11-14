import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:perfumery_lab/core/database/app_database.dart';
import 'package:perfumery_lab/features/materials/data/materials_repository.dart';

final readyOilsRepositoryProvider = Provider<ReadyOilsRepository>((ref) {
  final db = ref.watch(databaseProvider);
  return ReadyOilsRepository(db);
});

final readyOilsStreamProvider = StreamProvider<List<ReadyOil>>((ref) {
  final repo = ref.watch(readyOilsRepositoryProvider);
  return repo.watchAllReadyOils();
});

class ReadyOilsRepository {
  final AppDatabase _db;
  ReadyOilsRepository(this._db);

  Stream<List<ReadyOil>> watchAllReadyOils() {
    return (_db.select(_db.readyOils)
          ..orderBy([
            (t) => OrderingTerm(expression: t.name, mode: OrderingMode.asc)
          ]))
        .watch();
  }

  Future<void> createOrUpdateReadyOil(ReadyOilsCompanion oil) {
    return _db.into(_db.readyOils).insertOnConflictUpdate(oil);
  }

  Future<int> deleteReadyOil(String id) {
    return (_db.delete(_db.readyOils)..where((t) => t.id.equals(id))).go();
  }
}
