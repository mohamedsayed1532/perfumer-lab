import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Canonical ordering & IDs matching [GhsPicker.pictograms].
const List<String> kValidHazardIds = [
  'flammable',
  'irritant',
  'health_hazard',
  'environmental',
  'corrosive',
  'acute_toxic',
];

class CatalogMaterialEntry {
  final String cas;
  final List<String> altCas;
  final String name;
  final List<String> hazards;
  final String? hazardSource;
  final double? idealMaxPercent;
  final String? maxSource;
  final String? ifraType;
  final String? ifraKey;
  final String? ifraEndpoint;
  final String? pyramidNote;
  final List<String> categories;
  final String? botanicalName;
  final String? iupacName;
  final String? pubchemCid;
  final String? molecularFormula;
  final String? molecularWeight;

  const CatalogMaterialEntry({
    required this.cas,
    this.altCas = const [],
    required this.name,
    this.hazards = const [],
    this.hazardSource,
    this.idealMaxPercent,
    this.maxSource,
    this.ifraType,
    this.ifraKey,
    this.ifraEndpoint,
    this.pyramidNote,
    this.categories = const [],
    this.botanicalName,
    this.iupacName,
    this.pubchemCid,
    this.molecularFormula,
    this.molecularWeight,
  });

  factory CatalogMaterialEntry.fromJson(Map<String, dynamic> json) {
    final maxVal = json['max'] ?? json['idealMaxPercent'];
    return CatalogMaterialEntry(
      cas: (json['cas'] as String? ?? '').trim(),
      altCas: List<String>.from(json['altCas'] as List? ?? const []),
      name: (json['name'] as String? ?? '').trim(),
      hazards: List<String>.from(json['haz'] ?? json['hazards'] ?? const []),
      hazardSource: json['hSrc'] as String? ?? json['hazardSource'] as String?,
      idealMaxPercent: maxVal is num ? maxVal.toDouble() : null,
      maxSource: json['mSrc'] as String? ?? json['maxSource'] as String?,
      ifraType: json['iType'] as String? ?? json['ifraType'] as String?,
      ifraKey: json['iKey'] as String? ?? json['ifraKey'] as String?,
      ifraEndpoint: json['iEp'] as String? ?? json['ifraEndpoint'] as String?,
      pyramidNote: json['note'] as String? ?? json['pyramidNote'] as String?,
      categories: List<String>.from(json['cats'] ?? json['categories'] ?? const []),
      botanicalName: json['bot'] as String? ?? json['botanicalName'] as String?,
      iupacName: json['iupac'] as String? ?? json['iupacName'] as String?,
      pubchemCid: json['cid']?.toString() ?? json['pubchemCid']?.toString(),
      molecularFormula: json['mf'] as String? ?? json['molecularFormula'] as String?,
      molecularWeight: json['mw']?.toString() ?? json['molecularWeight']?.toString(),
    );
  }

  bool get isIfraProhibited => ifraType == 'PROHIBITION';
  bool get hasHazards => hazards.isNotEmpty;
}

class MaterialsCatalogData {
  final List<CatalogMaterialEntry> entries;
  final Map<String, CatalogMaterialEntry> _byCas;

  MaterialsCatalogData._(this.entries, this._byCas);

  static Future<MaterialsCatalogData> loadFromAssets() async {
    final raw =
        await rootBundle.loadString('assets/data/materials_catalog.json');
    return compute(parseFromString, raw);
  }

  static MaterialsCatalogData parseFromString(String rawJson) {
    final list = jsonDecode(rawJson) as List<dynamic>;
    final entries = <CatalogMaterialEntry>[];
    final byCas = <String, CatalogMaterialEntry>{};

    for (final item in list) {
      final entry = CatalogMaterialEntry.fromJson(item as Map<String, dynamic>);
      if (entry.cas.isEmpty) continue;
      entries.add(entry);
      byCas[entry.cas] = entry;
      for (final alt in entry.altCas) {
        final clean = cleanCas(alt);
        if (clean.isNotEmpty) {
          byCas.putIfAbsent(clean, () => entry);
        }
      }
    }
    return MaterialsCatalogData._(entries, byCas);
  }

  /// Extracts canonical `NNNNNNN-NN-N` CAS registry number if present.
  static String cleanCas(String? input) {
    if (input == null) return '';
    final m = RegExp(r'\b(\d{2,7}-\d{2}-\d)\b').firstMatch(input.trim());
    return m?.group(1) ?? input.trim();
  }

  CatalogMaterialEntry? findByCas(String? casNumber) {
    final key = cleanCas(casNumber);
    if (key.isEmpty) return null;
    return _byCas[key];
  }
}

final materialsCatalogProvider =
    FutureProvider<MaterialsCatalogData>((ref) async {
  return MaterialsCatalogData.loadFromAssets();
});
