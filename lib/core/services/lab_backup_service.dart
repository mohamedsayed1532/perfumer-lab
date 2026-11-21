import 'dart:convert';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:perfumery_lab/core/database/app_database.dart';
import 'package:perfumery_lab/features/materials/data/materials_repository.dart';

final labBackupServiceProvider = Provider<LabBackupService>((ref) {
  final db = ref.watch(databaseProvider);
  return LabBackupService(db);
});

class LabBackupService {
  final AppDatabase _db;
  LabBackupService(this._db);

  /// Exports entire database as JSON and triggers OS share/save dialog.
  Future<void> exportDatabaseBackup() async {
    final formulas = await _db.select(_db.formulas).get();
    final items = await _db.select(_db.formulaItems).get();
    final materials = await _db.select(_db.materials).get();
    final readyOils = await _db.select(_db.readyOils).get();
    final agingBatches = await _db.select(_db.agingBatches).get();
    final evaluations = await _db.select(_db.agingEvaluations).get();

    final data = {
      'version': 1,
      'exportedAt': DateTime.now().toIso8601String(),
      'formulas': formulas.map((f) => f.toJson()).toList(),
      'formulaItems': items.map((i) => i.toJson()).toList(),
      'materials': materials.map((m) => m.toJson()).toList(),
      'readyOils': readyOils.map((o) => o.toJson()).toList(),
      'agingBatches': agingBatches.map((b) => b.toJson()).toList(),
      'agingEvaluations': evaluations.map((e) => e.toJson()).toList(),
    };

    final jsonString = const JsonEncoder.withIndent('  ').convert(data);
    final tempDir = await getTemporaryDirectory();
    final dateStr = DateTime.now().toIso8601String().substring(0, 10);
    final file = File('${tempDir.path}/perfumery_lab_backup_$dateStr.json');
    await file.writeAsString(jsonString);

    await SharePlus.instance.share(
      ShareParams(
        files: [XFile(file.path)],
        subject: 'Perfumery Lab Database Backup ($dateStr)',
      ),
    );
  }

  /// Imports database backup from selected JSON file.
  Future<int> importDatabaseBackup() async {
    final files = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['json'],
    );

    if (files.isEmpty || files.first.path == null) {
      return 0; // User cancelled
    }

    final file = File(files.first.path!);
    final content = await file.readAsString();
    final Map<String, dynamic> data = jsonDecode(content);

    int restoredCount = 0;

    await _db.transaction(() async {
      // Import materials
      if (data['materials'] is List) {
        for (final item in (data['materials'] as List)) {
          final m = Material.fromJson(item as Map<String, dynamic>);
          await _db.into(_db.materials).insertOnConflictUpdate(m);
          restoredCount++;
        }
      }

      // Import formulas
      if (data['formulas'] is List) {
        for (final item in (data['formulas'] as List)) {
          final f = Formula.fromJson(item as Map<String, dynamic>);
          await _db.into(_db.formulas).insertOnConflictUpdate(f);
          restoredCount++;
        }
      }

      // Import formula items
      if (data['formulaItems'] is List) {
        for (final item in (data['formulaItems'] as List)) {
          final fi = FormulaItem.fromJson(item as Map<String, dynamic>);
          await _db.into(_db.formulaItems).insertOnConflictUpdate(fi);
        }
      }

      // Import ready oils
      if (data['readyOils'] is List) {
        for (final item in (data['readyOils'] as List)) {
          final ro = ReadyOil.fromJson(item as Map<String, dynamic>);
          await _db.into(_db.readyOils).insertOnConflictUpdate(ro);
          restoredCount++;
        }
      }

      // Import aging batches
      if (data['agingBatches'] is List) {
        for (final item in (data['agingBatches'] as List)) {
          final b = AgingBatche.fromJson(item as Map<String, dynamic>);
          await _db.into(_db.agingBatches).insertOnConflictUpdate(b);
          restoredCount++;
        }
      }

      // Import evaluations
      if (data['agingEvaluations'] is List) {
        for (final item in (data['agingEvaluations'] as List)) {
          final ev = AgingEvaluation.fromJson(item as Map<String, dynamic>);
          await _db.into(_db.agingEvaluations).insertOnConflictUpdate(ev);
        }
      }
    });

    return restoredCount;
  }

  /// Exports all Raw Materials as CSV.
  Future<void> exportMaterialsCsv() async {
    final materials = await _db.select(_db.materials).get();
    final buffer = StringBuffer();
    buffer.writeln(
        'ID,Name,PyramidNote,DilutionPercent,Solvent,StockGrams,CASNumber,BotanicalName,CostPerGram,IdealMaxPercent');

    for (final m in materials) {
      final cost = m.costPerGram;
      final maxPct = m.idealMaxPercent?.toString() ?? '';
      buffer.writeln(
        '"${m.id}","${m.name.replaceAll('"', '""')}","${m.pyramidNote}",${m.dilutionPercent},"${m.defaultSolvent ?? "Neat"}",${m.stockGrams},"${m.casNumber ?? ""}","${m.botanicalName ?? ""}",$cost,"$maxPct"',
      );
    }

    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/perfumery_materials.csv');
    await file.writeAsString(buffer.toString());

    await SharePlus.instance.share(
      ShareParams(
        files: [XFile(file.path)],
        subject: 'Perfumery Raw Materials (CSV)',
      ),
    );
  }
}
