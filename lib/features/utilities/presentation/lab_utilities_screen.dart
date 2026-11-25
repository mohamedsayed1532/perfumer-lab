import 'package:cupertino_ui/cupertino_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:perfumery_lab/core/services/lab_backup_service.dart';
import 'package:perfumery_lab/core/theme/app_colors.dart';
import 'package:perfumery_lab/core/theme/liquid_glass.dart';
import 'package:perfumery_lab/core/utils/haptics.dart';
import 'alcohol_gauging_sheet.dart';
import 'ifra_reference_sheet.dart';
import 'solvent_density_sheet.dart';

class LabUtilitiesScreen extends ConsumerWidget {
  const LabUtilitiesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final backupService = ref.watch(labBackupServiceProvider);

    return LiquidGlassBackground(
      child: CupertinoPageScaffold(
        backgroundColor: CupertinoColors.transparent,
        child: CustomScrollView(
          slivers: [
            CupertinoSliverNavigationBar(
              backgroundColor: AppColors.liquidGlassBg.resolveFrom(context),
              largeTitle: const Text('Lab Utilities'),
            ),

            // Section 1: Interactive Calculators
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 6),
                child: Text(
                  'Lab calculators',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.secondaryLabel.resolveFrom(context),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    _buildUtilityTile(
                      context,
                      icon: CupertinoIcons.flame_fill,
                      iconColor: AppColors.accent.resolveFrom(context),
                      title: 'Alcohol Gauging & Proof',
                      subtitle: 'Dilute 96° to 80° or 70° with contraction factor',
                      onTap: () {
                        showCupertinoModalPopup(
                          context: context,
                          builder: (_) => const AlcoholGaugingSheet(),
                        );
                      },
                    ),
                    const SizedBox(height: 10),
                    _buildUtilityTile(
                      context,
                      icon: CupertinoIcons.drop_fill,
                      iconColor: AppColors.accent.resolveFrom(context),
                      title: 'Solvent Density & Mass',
                      subtitle: 'Convert ml to grams via DPG, TEC, IPM density',
                      onTap: () {
                        showCupertinoModalPopup(
                          context: context,
                          builder: (_) => const SolventDensitySheet(),
                        );
                      },
                    ),
                    const SizedBox(height: 10),
                    _buildUtilityTile(
                      context,
                      icon: CupertinoIcons.shield_lefthalf_fill,
                      iconColor: AppColors.accent.resolveFrom(context),
                      title: 'IFRA 51st Amendment Limits',
                      subtitle: 'Category 4 fine fragrance threshold reference',
                      onTap: () {
                        showCupertinoModalPopup(
                          context: context,
                          builder: (_) => const IfraReferenceSheet(),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),

            // Section 2: Data & IP Backup (JSON / CSV)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 24, 16, 6),
                child: Text(
                  'Formulas & backups',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.secondaryLabel.resolveFrom(context),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    _buildUtilityTile(
                      context,
                      icon: CupertinoIcons.arrow_down_doc_fill,
                      iconColor: AppColors.accent.resolveFrom(context),
                      title: 'Backup Database (JSON)',
                      subtitle: 'Export formulas, raw materials & aging logs',
                      onTap: () async {
                        await LabHaptics.selection();
                        await backupService.exportDatabaseBackup();
                      },
                    ),
                    const SizedBox(height: 10),
                    _buildUtilityTile(
                      context,
                      icon: CupertinoIcons.arrow_up_doc_fill,
                      iconColor: AppColors.accent.resolveFrom(context),
                      title: 'Restore Database (JSON)',
                      subtitle: 'Import a previously exported JSON lab backup',
                      onTap: () async {
                        await LabHaptics.selection();
                        final count = await backupService.importDatabaseBackup();
                        if (context.mounted && count > 0) {
                          _showInfoDialog(
                            context,
                            'Restore Completed',
                            'Successfully restored $count records into your laboratory database.',
                          );
                          LabHaptics.batchSuccess();
                        }
                      },
                    ),
                    const SizedBox(height: 10),
                    _buildUtilityTile(
                      context,
                      icon: CupertinoIcons.table,
                      iconColor: AppColors.accent.resolveFrom(context),
                      title: 'Export Materials Catalog (CSV)',
                      subtitle: 'Download spreadsheet for physical inventory binder',
                      onTap: () async {
                        await LabHaptics.selection();
                        await backupService.exportMaterialsCsv();
                      },
                    ),
                  ],
                ),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 100)),
          ],
        ),
      ),
    );
  }

  Widget _buildUtilityTile(
    BuildContext context, {
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: LiquidGlass(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        borderRadius: BorderRadius.circular(16),
        child: Row(
          children: [
            SizedBox(
              width: 28,
              child: Center(
                child: Icon(icon, color: iconColor, size: 20),
              ),
            ),
            const SizedBox(width: 12),
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
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12.5,
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
      ),
    );
  }

  void _showInfoDialog(BuildContext context, String title, String content) {
    showCupertinoDialog(
      context: context,
      builder: (ctx) => CupertinoAlertDialog(
        title: Text(title),
        content: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Text(content),
        ),
        actions: [
          CupertinoDialogAction(
            child: const Text('OK'),
            onPressed: () => Navigator.pop(ctx),
          ),
        ],
      ),
    );
  }
}
