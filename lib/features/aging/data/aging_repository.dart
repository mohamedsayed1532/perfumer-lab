import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:perfumery_lab/core/database/app_database.dart';
import 'package:perfumery_lab/features/materials/data/materials_repository.dart';

final agingRepositoryProvider = Provider<AgingRepository>((ref) {
  final db = ref.watch(databaseProvider);
  return AgingRepository(db);
});

final activeAgingBatchesStreamProvider =
    StreamProvider<List<AgingBatche>>((ref) {
  final repo = ref.watch(agingRepositoryProvider);
  return repo.watchActiveBatches();
});

class AgingRepository {
  final AppDatabase _db;
  AgingRepository(this._db);

  Stream<List<AgingBatche>> watchActiveBatches() {
    return (_db.select(_db.agingBatches)
          ..where((t) => t.status.equals('active'))
          ..orderBy([
            (t) => OrderingTerm(expression: t.startDate, mode: OrderingMode.desc)
          ]))
        .watch();
  }

  Stream<List<AgingEvaluation>> watchEvaluationsForBatch(String batchId) {
    return (_db.select(_db.agingEvaluations)
          ..where((t) => t.batchId.equals(batchId))
          ..orderBy([
            (t) => OrderingTerm(
                expression: t.evaluationDate, mode: OrderingMode.desc)
          ]))
        .watch();
  }

  Future<void> logEvaluation(AgingEvaluationsCompanion eval) {
    return _db.into(_db.agingEvaluations).insert(eval);
  }
}
