import 'package:cupertino_ui/cupertino_ui.dart';
import 'package:perfumery_lab/core/theme/app_colors.dart';
import 'package:perfumery_lab/core/theme/app_typography.dart';
import 'package:perfumery_lab/core/theme/liquid_glass.dart';

class LabUtilitiesScreen extends StatelessWidget {
  const LabUtilitiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: AppColors.systemGroupedBackground.resolveFrom(context),
      navigationBar: CupertinoNavigationBar(
        middle: Text('Lab Utilities', style: AppTypography.headline(context)),
      ),
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildUtilityTile(
              context,
              title: 'Alcohol Gauging & Proof Calculator',
              subtitle: 'Compute dilution from 96% to 80% with water contraction tables',
              icon: CupertinoIcons.flame_fill,
              color: CupertinoColors.systemIndigo,
            ),
            const SizedBox(height: 12),
            _buildUtilityTile(
              context,
              title: 'Solvent Density & Volume to Mass',
              subtitle: 'Convert volume (ml) to grams using specific gravity of DPG, TEC, IPM',
              icon: CupertinoIcons.drop_fill,
              color: CupertinoColors.systemTeal,
            ),
            const SizedBox(height: 12),
            _buildUtilityTile(
              context,
              title: 'IFRA 51st Amendment Limit Checker',
              subtitle: 'Check Category 4 (Fine Fragrance) safe maximum usage thresholds',
              icon: CupertinoIcons.shield_lefthalf_fill,
              color: CupertinoColors.systemGreen,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUtilityTile(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
  }) {
    return LiquidGlass(
      padding: const EdgeInsets.all(16),
      borderRadius: BorderRadius.circular(16),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, size: 22, color: color),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.label.resolveFrom(context),
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.secondaryLabel.resolveFrom(context),
                  ),
                ),
              ],
            ),
          ),
          Icon(
            CupertinoIcons.chevron_forward,
            size: 16,
            color: AppColors.tertiaryLabel.resolveFrom(context),
          ),
        ],
      ),
    );
  }
}
