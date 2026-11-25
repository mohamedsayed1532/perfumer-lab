import 'package:cupertino_ui/cupertino_ui.dart';
import 'package:perfumery_lab/core/theme/app_colors.dart';
import 'package:perfumery_lab/core/theme/app_typography.dart';
import '../../data/formulas_repository.dart';

class OlfactoryPyramidBar extends StatelessWidget {
  final FormulaWithMaterials formulaData;

  const OlfactoryPyramidBar({super.key, required this.formulaData});

  @override
  Widget build(BuildContext context) {
    final items = formulaData.items;
    double topPpt = 0.0;
    double heartPpt = 0.0;
    double basePpt = 0.0;

    for (final item in items) {
      final note = (item.material.pyramidNote).toLowerCase().trim();
      final ppt = item.item.partsPerThousand;
      if (note == 'top') {
        topPpt += ppt;
      } else if (note == 'heart' || note == 'middle') {
        heartPpt += ppt;
      } else {
        basePpt += ppt;
      }
    }

    final total = topPpt + heartPpt + basePpt;
    final topPct = total > 0 ? (topPpt / total * 100) : 0.0;
    final heartPct = total > 0 ? (heartPpt / total * 100) : 0.0;
    final basePct = total > 0 ? (basePpt / total * 100) : 0.0;

    final topColor = AppColors.accent.resolveFrom(context); // Cyan — Top
    final heartColor = AppColors.secondaryLabel.resolveFrom(context); // Slate — Heart
    final baseColor = AppColors.naturalGreen.resolveFrom(context); // Emerald — Base

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.secondarySystemBackground.resolveFrom(context),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
            color: AppColors.cardBorder.resolveFrom(context), width: 0.75),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Olfactory volatility',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColors.secondaryLabel.resolveFrom(context),
                ),
              ),
              Text(
                '${topPct.toStringAsFixed(0)}T / ${heartPct.toStringAsFixed(0)}H / ${basePct.toStringAsFixed(0)}B',
                style: AppTypography.monoData(
                  context,
                  fontSize: 11.5,
                  color: AppColors.label.resolveFrom(context),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: SizedBox(
              height: 7,
              child: total == 0
                  ? Container(color: AppColors.recessedWell.resolveFrom(context))
                  : Row(
                      children: [
                        if (topPct > 0)
                          Expanded(
                            flex: (topPct * 10).round().clamp(1, 1000),
                            child: Container(color: topColor),
                          ),
                        if (heartPct > 0)
                          Expanded(
                            flex: (heartPct * 10).round().clamp(1, 1000),
                            child: Container(color: heartColor),
                          ),
                        if (basePct > 0)
                          Expanded(
                            flex: (basePct * 10).round().clamp(1, 1000),
                            child: Container(color: baseColor),
                          ),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
