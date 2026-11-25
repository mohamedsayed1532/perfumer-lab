import 'package:flutter_test/flutter_test.dart';
import 'package:perfumery_lab/core/services/ifra_catalog_service.dart';
import 'package:perfumery_lab/core/services/ifra_safety_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('IfraCatalogData loads all 263 official IFRA standards and 302 NCS extracts',
      () async {
    final catalog = await IfraCatalogData.loadFromAssets();

    expect(catalog.standards.length, 263);
    expect(catalog.ncsEntries.length, 302);

    // Verify Isoeugenol (CAS 97-54-1) Cat 4 limit (0.11%)
    final isoeugenol = catalog.findStandardForMaterial(
      casNumber: '97-54-1',
      name: 'Isoeugenol',
    );
    expect(isoeugenol, isNotNull);
    expect(isoeugenol!.numericLimitFor('Cat 4'), 0.11);
    expect(isoeugenol.categories.length, 18);

    // Verify Geraniol (CAS 106-24-1) Cat 4 limit (4.7%)
    final geraniol = catalog.findStandardForMaterial(
      casNumber: '106-24-1',
      name: 'Geraniol',
    );
    expect(geraniol, isNotNull);
    expect(geraniol!.numericLimitFor('Cat 4'), 4.7);

    // Verify Alantroot oil (CAS 97676-35-2) is pure PROHIBITION
    final alantroot = catalog.findStandardForMaterial(casNumber: '97676-35-2');
    expect(alantroot, isNotNull);
    expect(alantroot!.type, 'PROHIBITION');
    expect(alantroot.numericLimitFor('Cat 4'), 0.0);

    // Verify prohibited ingredient flags violation in IfraSafetyService
    const safety = IfraSafetyService();
    final eval = safety.evaluateFormulaSafety(
      targetConcentrationPercent: 20.0,
      items: [
        const FormulaItemSafetyInput(
          id: '1',
          name: 'Lyral',
          partsPerThousand: 5.0,
          idealMaxPercent: 0.0,
          isProhibited: true,
        ),
      ],
    );
    expect(eval.isCompliant, isFalse);
    expect(eval.violations.first.isProhibited, isTrue);

    // Verify Natural Complex Substance lookup (Balm oil / Bergamot)
    final balm = catalog.findNcsForMaterial(casNumber: '8014-71-9');
    expect(balm, isNotNull);
    expect(balm!.constituents, isNotEmpty);
  });
}
