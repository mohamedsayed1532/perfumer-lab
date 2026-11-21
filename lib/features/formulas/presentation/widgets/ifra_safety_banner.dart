import 'package:cupertino_ui/cupertino_ui.dart';
import 'package:perfumery_lab/core/services/ifra_safety_service.dart';
import 'package:perfumery_lab/core/theme/app_colors.dart';
import 'package:perfumery_lab/core/theme/liquid_glass.dart';
import 'package:perfumery_lab/core/utils/haptics.dart';

class IfraSafetyBanner extends StatelessWidget {
  final IfraFormulaEvaluation evaluation;
  final double targetConcentrationPercent;

  const IfraSafetyBanner({
    super.key,
    required this.evaluation,
    required this.targetConcentrationPercent,
  });

  @override
  Widget build(BuildContext context) {
    final isCompliant = evaluation.isCompliant;
    final violations = evaluation.violations;

    final bannerBgColor = isCompliant
        ? const Color(0x1F34C759) // Subtle green glass tint
        : const Color(0x2EFF3B30); // Subtle red alert glass tint

    final borderColor = isCompliant
        ? const Color(0x4D34C759)
        : const Color(0x80FF3B30);

    final iconColor = isCompliant
        ? CupertinoColors.systemGreen
        : CupertinoColors.systemRed;

    final title = isCompliant
        ? 'IFRA 51st Amendment Compliant'
        : 'IFRA Safety Alert: ${violations.length} Restricted ${violations.length == 1 ? "Material" : "Materials"}';

    final subtitle = isCompliant
        ? 'All materials safe for Category 4 skin contact at ${targetConcentrationPercent.toStringAsFixed(0)}% EdP.'
        : 'Exceeds maximum allowable skin exposure threshold. Tap for allowable limits.';

    return GestureDetector(
      onTap: isCompliant
          ? null
          : () async {
              await LabHaptics.selection();
              if (context.mounted) {
                _showViolationsSheet(context);
              }
            },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: bannerBgColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: borderColor, width: 1.0),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              isCompliant
                  ? CupertinoIcons.checkmark_shield_fill
                  : CupertinoIcons.exclamationmark_shield_fill,
              color: iconColor,
              size: 24,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: isCompliant
                          ? CupertinoColors.systemGreen.resolveFrom(context)
                          : CupertinoColors.systemRed.resolveFrom(context),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                      color: AppColors.secondaryLabel.resolveFrom(context),
                    ),
                  ),
                ],
              ),
            ),
            if (!isCompliant)
              Icon(
                CupertinoIcons.chevron_right,
                size: 14,
                color: AppColors.tertiaryLabel.resolveFrom(context),
              ),
          ],
        ),
      ),
    );
  }

  void _showViolationsSheet(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (ctx) => LiquidGlassBackground(
        child: CupertinoPopupSurface(
          child: SafeArea(
            top: false,
            child: Container(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.75,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Row(
                        children: [
                          Icon(
                            CupertinoIcons.exclamationmark_shield_fill,
                            color: CupertinoColors.systemRed,
                            size: 22,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'IFRA Safety Violations',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      CupertinoButton(
                        padding: EdgeInsets.zero,
                        child: const Text('Done'),
                        onPressed: () => Navigator.pop(ctx),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'IFRA 51st Amendment limits apply to finished products applied to skin (Category 4 Fine Fragrance at ${targetConcentrationPercent.toStringAsFixed(0)}% concentration):',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.secondaryLabel.resolveFrom(context),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Flexible(
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: evaluation.violations.length,
                      separatorBuilder: (_, _) => const SizedBox(height: 10),
                      itemBuilder: (ctx, i) {
                        final v = evaluation.violations[i];
                        return Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: const Color(0x1FFFFFFF),
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: const Color(0x33FF3B30),
                              width: 1,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    v.name,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 3),
                                    decoration: BoxDecoration(
                                      color: const Color(0x33FF3B30),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      '${v.currentSkinExposurePercent.toStringAsFixed(3)}% skin',
                                      style: const TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w700,
                                        color: CupertinoColors.systemRed,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Text(
                                '• IFRA Category 4 Max: ${v.maxAllowedSkinExposurePercent.toStringAsFixed(3)}%',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppColors.secondaryLabel
                                      .resolveFrom(context),
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                '• Max Allowed in Formula: ${v.maxAllowedPpt.toStringAsFixed(1)} ppt (to be 100% compliant)',
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: CupertinoColors.systemOrange,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
