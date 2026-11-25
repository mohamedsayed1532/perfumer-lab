import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// All 18 official IFRA 51st Amendment product categories in display order.
const List<(String key, String label)> ifraCategories = [
  ('Cat 1', 'Cat 1 · Lip & Oral'),
  ('Cat 2', 'Cat 2 · Deodorants'),
  ('Cat 3', 'Cat 3 · Face / Shaved Skin'),
  ('Cat 4', 'Cat 4 · Fine Fragrance'),
  ('Cat 5A', 'Cat 5A · Body Lotion'),
  ('Cat 5B', 'Cat 5B · Face Cream'),
  ('Cat 5C', 'Cat 5C · Hand Cream'),
  ('Cat 5D', 'Cat 5D · Baby Products'),
  ('Cat 6', 'Cat 6 · Oral Care'),
  ('Cat 7A', 'Cat 7A · Rinse-Off Hair'),
  ('Cat 7B', 'Cat 7B · Leave-On Hair'),
  ('Cat 8', 'Cat 8 · Intimate / Wipes'),
  ('Cat 9', 'Cat 9 · Soap / Wash'),
  ('Cat 10A', 'Cat 10A · Household / Diffusers'),
  ('Cat 10B', 'Cat 10B · Aerosol Air Care'),
  ('Cat 11A', 'Cat 11A · Diapers / Feminine'),
  ('Cat 11B', 'Cat 11B · Paper / Textiles'),
  ('Cat 12', 'Cat 12 · Candles / Incense'),
];

class IfraStandard {
  final String key;
  final String amendment;
  final String lastPub;
  final String deadlineExisting;
  final String deadlineNew;
  final String name;
  final List<String> cas;
  final String casComment;
  final List<String> synonyms;
  final String type;
  final String endpoint;
  final String contributions;
  final String notes;
  final Map<String, dynamic> categories;

  const IfraStandard({
    required this.key,
    required this.amendment,
    required this.lastPub,
    required this.deadlineExisting,
    required this.deadlineNew,
    required this.name,
    required this.cas,
    required this.casComment,
    required this.synonyms,
    required this.type,
    required this.endpoint,
    required this.contributions,
    required this.notes,
    required this.categories,
  });

  factory IfraStandard.fromJson(Map<String, dynamic> json) {
    return IfraStandard(
      key: json['key'] as String? ?? '',
      amendment: json['amendment'] as String? ?? '',
      lastPub: json['lastPub'] as String? ?? '',
      deadlineExisting: json['deadlineExisting'] as String? ?? '',
      deadlineNew: json['deadlineNew'] as String? ?? '',
      name: json['name'] as String? ?? '',
      cas: List<String>.from(json['cas'] as List? ?? const []),
      casComment: json['casComment'] as String? ?? '',
      synonyms: List<String>.from(json['synonyms'] as List? ?? const []),
      type: json['type'] as String? ?? '',
      endpoint: json['endpoint'] as String? ?? '',
      contributions: json['contributions'] as String? ?? '',
      notes: json['notes'] as String? ?? '',
      categories: Map<String, dynamic>.from(
          json['categories'] as Map? ?? const {}),
    );
  }

  bool get isProhibited => type.contains('PROHIBITION');
  bool get isRestricted => type.contains('RESTRICTION');
  bool get isSpecification => type.contains('SPECIFICATION');

  /// Numeric limit in % for [categoryKey] (e.g. 'Cat 4'), or 0.0 if pure PROHIBITION,
  /// or null if 'No Restriction' / non-numeric.
  double? numericLimitFor(String categoryKey) {
    if (type == 'PROHIBITION') return 0.0;
    final raw = categories[categoryKey];
    if (raw is num) return raw.toDouble();
    if (raw is String) {
      final parsed = double.tryParse(raw.trim());
      if (parsed != null) return parsed;
    }
    return null;
  }

  String displayLimitFor(String categoryKey) {
    if (type == 'PROHIBITION') return 'Prohibited';
    final raw = categories[categoryKey];
    if (raw == null) {
      return isSpecification ? 'Specification' : 'See Notes';
    }
    if (raw is num) {
      final d = raw.toDouble();
      if (d == 0) return 'Prohibited';
      if (d < 0.01) return '${d.toStringAsFixed(4)}%';
      if (d < 1.0) return '${d.toStringAsFixed(3)}%';
      return '${d.toStringAsFixed(2)}%';
    }
    return raw.toString();
  }
}

class IfraNcsConstituent {
  final String name;
  final String cas;
  final String typicalPercentDisplay;

  const IfraNcsConstituent({
    required this.name,
    required this.cas,
    required this.typicalPercentDisplay,
  });

  factory IfraNcsConstituent.fromJson(Map<String, dynamic> json) {
    final val = json['typicalPercent'];
    final display = val is num ? '${val.toString()}%' : val.toString();
    return IfraNcsConstituent(
      name: json['name'] as String? ?? '',
      cas: json['cas'] as String? ?? '',
      typicalPercentDisplay: display,
    );
  }
}

class IfraNcsEntry {
  final String name;
  final String botanical;
  final String isoCategory;
  final List<String> cas;
  final String amendment;
  final List<IfraNcsConstituent> constituents;

  const IfraNcsEntry({
    required this.name,
    required this.botanical,
    required this.isoCategory,
    required this.cas,
    required this.amendment,
    required this.constituents,
  });

  factory IfraNcsEntry.fromJson(Map<String, dynamic> json) {
    return IfraNcsEntry(
      name: json['name'] as String? ?? '',
      botanical: json['botanical'] as String? ?? '',
      isoCategory: json['isoCategory'] as String? ?? '',
      cas: List<String>.from(json['cas'] as List? ?? const []),
      amendment: json['amendment'] as String? ?? '',
      constituents: (json['constituents'] as List? ?? const [])
          .map((e) => IfraNcsConstituent.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class IfraCatalogData {
  final List<IfraStandard> standards;
  final List<IfraNcsEntry> ncsEntries;

  const IfraCatalogData({
    required this.standards,
    required this.ncsEntries,
  });

  static Future<IfraCatalogData> loadFromAssets() async {
    final stdJson =
        await rootBundle.loadString('assets/data/ifra_51_standards.json');
    final ncsJson =
        await rootBundle.loadString('assets/data/ifra_51_ncs_annex.json');
    return parseFromStrings(stdJson, ncsJson);
  }

  static IfraCatalogData parseFromStrings(String stdJson, String ncsJson) {
    final stdList = (jsonDecode(stdJson) as List)
        .map((e) => IfraStandard.fromJson(e as Map<String, dynamic>))
        .toList();
    final ncsList = (jsonDecode(ncsJson) as List)
        .map((e) => IfraNcsEntry.fromJson(e as Map<String, dynamic>))
        .toList();
    return IfraCatalogData(standards: stdList, ncsEntries: ncsList);
  }

  /// Matches an official IFRA standard by CAS number first, then name/synonym.
  IfraStandard? findStandardForMaterial({String? casNumber, String? name}) {
    final cleanCas = _cleanCas(casNumber);
    if (cleanCas.isNotEmpty) {
      for (final s in standards) {
        if (s.cas.any((c) => _cleanCas(c) == cleanCas)) {
          return s;
        }
      }
    }
    final cleanName = _normName(name);
    if (cleanName.isEmpty) return null;

    // Exact normalized name or synonym match
    for (final s in standards) {
      if (_normName(s.name) == cleanName) return s;
      if (s.synonyms.any((syn) => _normName(syn) == cleanName)) return s;
    }

    // Fallback substring match for closely named materials (min length 5)
    if (cleanName.length >= 5) {
      for (final s in standards) {
        final sName = _normName(s.name);
        if (sName.contains(cleanName) || cleanName.contains(sName)) {
          return s;
        }
      }
    }
    return null;
  }

  /// Matches a Natural Complex Substance (essential oil/absolute) by CAS or name.
  IfraNcsEntry? findNcsForMaterial({String? casNumber, String? name}) {
    final cleanCas = _cleanCas(casNumber);
    if (cleanCas.isNotEmpty) {
      for (final n in ncsEntries) {
        if (n.cas.any((c) => _cleanCas(c) == cleanCas)) {
          return n;
        }
      }
    }
    final cleanName = _normName(name);
    if (cleanName.isEmpty) return null;

    for (final n in ncsEntries) {
      final nName = _normName(n.name);
      if (nName == cleanName ||
          (cleanName.length >= 5 &&
              (nName.contains(cleanName) || cleanName.contains(nName)))) {
        return n;
      }
    }
    return null;
  }

  static String _cleanCas(String? cas) {
    if (cas == null) return '';
    return cas.trim().split('*').first.trim();
  }

  static String _normName(String? val) {
    if (val == null) return '';
    return val
        .toLowerCase()
        .replaceAll(RegExp(r'\s*\d+%.*$'), '')
        .replaceAll(RegExp(r'[^a-z0-9]+'), ' ')
        .trim();
  }
}

final ifraCatalogProvider = FutureProvider<IfraCatalogData>((ref) {
  return IfraCatalogData.loadFromAssets();
});
