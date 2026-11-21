import 'package:flutter_test/flutter_test.dart';
import 'package:perfumery_lab/core/services/ifra_safety_service.dart';

void main() {
  group('IfraSafetyService', () {
    const service = IfraSafetyService();

    test('calculates skin exposure accurately for neat material in 20% EdP', () {
      // 50 ppt in 1000 total ppt = 5% in concentrate
      // Neat = 100% dilution
      // 20% EdP target concentration
      // Expected skin exposure: 5% * 0.20 = 1.0%
      final exposure = service.calculateSkinExposure(
        partsPerThousand: 50.0,
        totalPpt: 1000.0,
        specifiedDilutionPercent: 100.0,
        targetConcentrationPercent: 20.0,
      );

      expect(exposure, closeTo(1.0, 0.0001));
    });

    test('calculates skin exposure accurately for 10% DPG pre-diluted material in 20% EdP', () {
      // 50 ppt in 1000 total ppt = 5% of concentrate is the dilution bottle
      // Bottle is 10% active in DPG
      // Active in concentrate = 5% * 0.10 = 0.5%
      // 20% EdP target concentration
      // Expected skin exposure: 0.5% * 0.20 = 0.10%
      final exposure = service.calculateSkinExposure(
        partsPerThousand: 50.0,
        totalPpt: 1000.0,
        specifiedDilutionPercent: 10.0,
        targetConcentrationPercent: 20.0,
      );

      expect(exposure, closeTo(0.10, 0.0001));
    });

    test('calculates max allowed PPT to regain compliance', () {
      // IFRA limit = 0.1% skin exposure (e.g. Oakmoss Category 4)
      // Neat material (100% active)
      // 20% EdP target concentration
      // Total formula PPT = 1000
      // Max allowed active in concentrate = 0.1% / 0.20 = 0.5% = 5.0 ppt
      final maxPpt = service.calculateMaxAllowedPpt(
        idealMaxPercent: 0.1,
        specifiedDilutionPercent: 100.0,
        targetConcentrationPercent: 20.0,
        totalPpt: 1000.0,
      );

      expect(maxPpt, closeTo(5.0, 0.0001));
    });

    test('evaluates compliant formula correctly', () {
      final items = [
        const FormulaItemSafetyInput(
          id: 'item-1',
          name: 'Iso E Super',
          partsPerThousand: 200.0,
          specifiedDilutionPercent: 100.0,
          idealMaxPercent: 21.4, // Category 4 limit for Iso E Super
        ),
        const FormulaItemSafetyInput(
          id: 'item-2',
          name: 'Hedione',
          partsPerThousand: 800.0,
          specifiedDilutionPercent: 100.0,
          idealMaxPercent: null, // No restriction
        ),
      ];

      final result = service.evaluateFormulaSafety(
        targetConcentrationPercent: 20.0,
        items: items,
      );

      expect(result.isCompliant, isTrue);
      expect(result.violations, isEmpty);
    });

    test('evaluates violating formula correctly with exact excess metrics', () {
      final items = [
        const FormulaItemSafetyInput(
          id: 'item-oakmoss',
          name: 'Oakmoss Absolute',
          partsPerThousand: 10.0, // 1% in concentrate -> at 20% EdP = 0.20% skin exposure
          specifiedDilutionPercent: 100.0,
          idealMaxPercent: 0.10, // Max 0.10%
        ),
        const FormulaItemSafetyInput(
          id: 'item-bergamot',
          name: 'Bergamot Oil',
          partsPerThousand: 990.0,
          specifiedDilutionPercent: 100.0,
          idealMaxPercent: null,
        ),
      ];

      final result = service.evaluateFormulaSafety(
        targetConcentrationPercent: 20.0,
        items: items,
      );

      expect(result.isCompliant, isFalse);
      expect(result.violations.length, 1);
      final violation = result.violations.first;
      expect(violation.name, 'Oakmoss Absolute');
      expect(violation.currentSkinExposurePercent, closeTo(0.20, 0.0001));
      expect(violation.maxAllowedSkinExposurePercent, 0.10);
      expect(violation.maxAllowedPpt, closeTo(5.0, 0.0001));
    });
  });
}
