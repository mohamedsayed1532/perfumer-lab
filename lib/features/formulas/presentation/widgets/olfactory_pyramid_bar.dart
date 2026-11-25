import 'package:cupertino_ui/cupertino_ui.dart';
import 'package:perfumery_lab/core/theme/app_colors.dart';
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

    const topColor = Color(0xFFE5A93C); // Amber — Top
    const heartColor = Color(0xFFD47355); // Rose damask — Heart
    const baseColor = Color(0xFFA67C52); // Smoked bronze — Base

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0x14FFFFFF),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.cardBorder.resolveFrom(context), width: 0.75),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Olfactory balance',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColors.secondaryLabel.resolveFrom(context),
                ),
              ),
              Text(
                'Top ${topPct.toStringAsFixed(0)}% • Heart ${heartPct.toStringAsFixed(0)}% • Base ${basePct.toStringAsFixed(0)}%',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: AppColors.secondaryLabel.resolveFrom(context),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: SizedBox(
              height: 8,
              child: total == 0
                  ? Container(color: const Color(0x2AFFFFFF))
                  : Row(
                      children: [
                        if (topPct > 0)
                          Expanded(
                            flex: (topPct * 10).round(),
                            child: Container(color: topColor),
                          ),
                        if (heartPct > 0)
                          Expanded(
                            flex: (heartPct * 10).round(),
                            child: Container(color: heartColor),
                          ),
                        if (basePct > 0)
                          Expanded(
                            flex: (basePct * 10).round(),
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
