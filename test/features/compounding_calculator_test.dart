import 'package:flutter_test/flutter_test.dart';

class CompoundingCalculations {
  /// Converts formula parts per thousand (ppt) to grams for a target batch weight.
  /// TargetBatchGrams * (ppt / 1000)
  static double calculateTargetGrams({
    required double partsPerThousand,
    required double targetBatchGrams,
  }) {
    return (targetBatchGrams * (partsPerThousand / 1000.0));
  }

  /// Calculates compensatory scale weight when substituting a diluted material for neat,
  /// or vice-versa.
  /// Formula calls for targetGrams of material at `formulaDilutionPercent` (e.g. 100% neat).
  /// Bench has stock at `stockDilutionPercent` (e.g. 10%).
  /// Required bench scale weight = targetGrams * (formulaDilutionPercent / stockDilutionPercent)
  static double calculateDilutionSubstitution({
    required double targetGrams,
    required double formulaDilutionPercent,
    required double stockDilutionPercent,
  }) {
    if (stockDilutionPercent <= 0) return 0.0;
    return targetGrams * (formulaDilutionPercent / stockDilutionPercent);
  }
}

void main() {
  test('CompoundingCalculations accurately scales ppt to target batch grams', () {
    // 50 ppt of Iso E Super in a 50.0g batch -> 50.0 * (50 / 1000) = 2.500g
    final result = CompoundingCalculations.calculateTargetGrams(
      partsPerThousand: 50.0,
      targetBatchGrams: 50.0,
    );
    expect(result, 2.500);
  });

  test('CompoundingCalculations accurately calculates neat-to-dilution substitution weight', () {
    // Formula calls for 0.100g of pure neat Civet (100%).
    // Perfumer has 10% dilution at the bench.
    // Required weight = 0.100 * (100 / 10) = 1.000g of 10% solution.
    final compensatedGrams = CompoundingCalculations.calculateDilutionSubstitution(
      targetGrams: 0.100,
      formulaDilutionPercent: 100.0,
      stockDilutionPercent: 10.0,
    );
    expect(compensatedGrams, 1.000);
  });
}
