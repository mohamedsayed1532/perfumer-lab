import 'package:flutter_test/flutter_test.dart';
import 'package:perfumery_lab/core/services/materials_catalog_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test(
      'MaterialsCatalogData loads 5000+ hidden CAS materials with GHS hazards and IFRA limits',
      () async {
    final catalog = await MaterialsCatalogData.loadFromAssets();
    expect(catalog.entries.length, greaterThanOrEqualTo(5000));

    // Iso E Super (OTNE): IFRA Cat 4 = 20.0%, Irritant
    final isoE = catalog.findByCas('54464-57-2');
    expect(isoE, isNotNull);
    expect(isoE!.idealMaxPercent, closeTo(20.0, 0.001));
    expect(isoE.hazards, contains('irritant'));

    // Isoeugenol: IFRA Cat 4 = 0.11%, Irritant + Health Hazard
    final isoeugenol = catalog.findByCas('97-54-1');
    expect(isoeugenol, isNotNull);
    expect(isoeugenol!.idealMaxPercent, closeTo(0.11, 0.001));
    expect(isoeugenol.hazards, containsAll(['irritant', 'health_hazard']));

    // D-Limonene: EC1272 Flammable + Irritant + Environmental
    final limonene = catalog.findByCas('5989-27-5');
    expect(limonene, isNotNull);
    expect(
      limonene!.hazards,
      containsAll(['flammable', 'irritant', 'environmental']),
    );

    // Ethanol: EC1272 Flammable
    final ethanol = catalog.findByCas('64-17-5');
    expect(ethanol, isNotNull);
    expect(ethanol!.hazards, contains('flammable'));

    // Bergamot Oil: IFRA Cat 4 = 0.4%, Botanical name + hazards
    final bergamot = catalog.findByCas('8007-75-8');
    expect(bergamot, isNotNull);
    expect(bergamot!.idealMaxPercent, closeTo(0.4, 0.001));
    expect(bergamot.botanicalName, 'Citrus bergamia');

    // Works cleanly with whitespace or CAS prefix noise, and alternate CAS
    expect(catalog.findByCas(' CAS 5989-27-5 ')?.cas, '5989-27-5');
    expect(catalog.findByCas('7705-13-7')?.cas, '5989-27-5');
  });
}
