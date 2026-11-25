/// Pure domain service calculating IFRA 51st Amendment skin exposure and Category 4 compliance.
class FormulaItemSafetyInput {
  final String id;
  final String name;
  final double partsPerThousand;
  final double specifiedDilutionPercent;
  final double? idealMaxPercent;
  final bool isProhibited;

  const FormulaItemSafetyInput({
    required this.id,
    required this.name,
    required this.partsPerThousand,
    this.specifiedDilutionPercent = 100.0,
    this.idealMaxPercent,
    this.isProhibited = false,
  });
}

class IfraViolationItem {
  final String id;
  final String name;
  final double currentSkinExposurePercent;
  final double maxAllowedSkinExposurePercent;
  final double maxAllowedPpt;
  final bool isProhibited;

  const IfraViolationItem({
    required this.id,
    required this.name,
    required this.currentSkinExposurePercent,
    required this.maxAllowedSkinExposurePercent,
    required this.maxAllowedPpt,
    this.isProhibited = false,
  });
}

class IfraFormulaEvaluation {
  final bool isCompliant;
  final double totalPpt;
  final List<IfraViolationItem> violations;

  const IfraFormulaEvaluation({
    required this.isCompliant,
    required this.totalPpt,
    required this.violations,
  });
}

class IfraSafetyService {
  const IfraSafetyService();

  /// Calculates actual skin exposure percentage for an ingredient in the finished perfume.
  ///
  /// [partsPerThousand]: parts per thousand in formula concentrate.
  /// [totalPpt]: total formula PPT (defaults to 1000.0 if not specified).
  /// [specifiedDilutionPercent]: percentage of active material in bottle (e.g. 10.0 for 10% in DPG).
  /// [targetConcentrationPercent]: finished fragrance concentration (e.g. 20.0% for EdP).
  double calculateSkinExposure({
    required double partsPerThousand,
    required double totalPpt,
    required double specifiedDilutionPercent,
    required double targetConcentrationPercent,
  }) {
    if (totalPpt <= 0 || targetConcentrationPercent <= 0) return 0.0;

    // Fraction of concentrate made up of this physical ingredient
    final concentrateFraction = partsPerThousand / totalPpt;

    // Active pure chemical fraction within that ingredient
    final activeFraction = specifiedDilutionPercent / 100.0;

    // Active pure chemical percentage in the concentrate
    final activePercentInConcentrate = concentrateFraction * activeFraction * 100.0;

    // Active pure chemical percentage in the finished hydroalcoholic product
    return activePercentInConcentrate * (targetConcentrationPercent / 100.0);
  }

  /// Calculates the maximum allowed PPT in the concentrate formula to meet [idealMaxPercent].
  double calculateMaxAllowedPpt({
    required double idealMaxPercent,
    required double specifiedDilutionPercent,
    required double targetConcentrationPercent,
    required double totalPpt,
  }) {
    if (targetConcentrationPercent <= 0 || specifiedDilutionPercent <= 0) {
      return 0.0;
    }

    // Max allowed active % in the concentrate
    final maxAllowedActiveInConcentrate =
        idealMaxPercent / (targetConcentrationPercent / 100.0);

    // Max allowed physical % of bottle in concentrate
    final maxAllowedPhysicalPercent =
        maxAllowedActiveInConcentrate / (specifiedDilutionPercent / 100.0);

    // Converted to PPT of total formula
    return (maxAllowedPhysicalPercent / 100.0) * totalPpt;
  }

  /// Evaluates entire formula for IFRA Category 4 compliance.
  IfraFormulaEvaluation evaluateFormulaSafety({
    required double targetConcentrationPercent,
    required List<FormulaItemSafetyInput> items,
  }) {
    final totalPpt = items.fold(0.0, (acc, item) => acc + item.partsPerThousand);
    final effectiveTotalPpt = totalPpt > 0 ? totalPpt : 1000.0;

    final violations = <IfraViolationItem>[];

    for (final item in items) {
      final skinExposure = calculateSkinExposure(
        partsPerThousand: item.partsPerThousand,
        totalPpt: effectiveTotalPpt,
        specifiedDilutionPercent: item.specifiedDilutionPercent,
        targetConcentrationPercent: targetConcentrationPercent,
      );

      if (item.isProhibited && item.partsPerThousand > 0) {
        violations.add(
          IfraViolationItem(
            id: item.id,
            name: item.name,
            currentSkinExposurePercent: skinExposure,
            maxAllowedSkinExposurePercent: 0.0,
            maxAllowedPpt: 0.0,
            isProhibited: true,
          ),
        );
        continue;
      }

      final maxLimit = item.idealMaxPercent;
      if (maxLimit == null || maxLimit <= 0) continue;

      // Check if skin exposure exceeds threshold (with 0.0001 precision margin)
      if (skinExposure > (maxLimit + 0.00001)) {
        final maxPpt = calculateMaxAllowedPpt(
          idealMaxPercent: maxLimit,
          specifiedDilutionPercent: item.specifiedDilutionPercent,
          targetConcentrationPercent: targetConcentrationPercent,
          totalPpt: effectiveTotalPpt,
        );

        violations.add(
          IfraViolationItem(
            id: item.id,
            name: item.name,
            currentSkinExposurePercent: skinExposure,
            maxAllowedSkinExposurePercent: maxLimit,
            maxAllowedPpt: maxPpt,
          ),
        );
      }
    }

    return IfraFormulaEvaluation(
      isCompliant: violations.isEmpty,
      totalPpt: effectiveTotalPpt,
      violations: violations,
    );
  }
}
