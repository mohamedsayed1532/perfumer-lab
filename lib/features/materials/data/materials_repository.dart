import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:perfumery_lab/core/database/app_database.dart';

final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(() => db.close());
  return db;
});

final materialsRepositoryProvider = Provider<MaterialsRepository>((ref) {
  final db = ref.watch(databaseProvider);
  return MaterialsRepository(db);
});

final materialsStreamProvider = StreamProvider<List<Material>>((ref) {
  final repo = ref.watch(materialsRepositoryProvider);
  return repo.watchAllMaterials();
});

class MaterialsRepository {
  final AppDatabase _db;
  MaterialsRepository(this._db);

  Stream<List<Material>> watchAllMaterials() {
    return (_db.select(_db.materials)
          ..orderBy([
            (t) => OrderingTerm(expression: t.name, mode: OrderingMode.asc)
          ]))
        .watch();
  }

  Future<Material?> getMaterialById(String id) {
    return (_db.select(_db.materials)..where((t) => t.id.equals(id)))
        .getSingleOrNull();
  }

  Future<void> createOrUpdateMaterial(MaterialsCompanion material) {
    return _db.into(_db.materials).insertOnConflictUpdate(material);
  }

  Future<int> deleteMaterial(String id) {
    return (_db.delete(_db.materials)..where((t) => t.id.equals(id))).go();
  }
}
