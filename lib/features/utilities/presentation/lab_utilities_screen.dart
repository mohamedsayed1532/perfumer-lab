import 'package:cupertino_ui/cupertino_ui.dart';
import 'package:perfumery_lab/core/theme/app_colors.dart';
import 'package:perfumery_lab/core/theme/liquid_glass.dart';

class LabUtilitiesScreen extends StatelessWidget {
  const LabUtilitiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LiquidGlassBackground(
      child: CupertinoPageScaffold(
        backgroundColor: CupertinoColors.transparent,
        child: CustomScrollView(
          slivers: [
            CupertinoSliverNavigationBar(
              backgroundColor: AppColors.liquidGlassBg.resolveFrom(context),
              largeTitle: const Text('Lab Utilities'),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 8),
                child: CupertinoListSection.insetGrouped(
                  header: const Text(
                    'REFERENCE CALCULATORS',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                  ),
                  backgroundColor: CupertinoColors.transparent,
                  children: [
                    CupertinoListTile.notched(
                      leading: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: CupertinoColors.systemIndigo,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          CupertinoIcons.flame_fill,
                          color: CupertinoColors.white,
                          size: 18,
                        ),
                      ),
                      title: const Text(
                        'Alcohol Gauging & Proof',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      subtitle: const Text('Dilute 96° to 80° with contraction tables'),
                      trailing: const CupertinoListTileChevron(),
                      onTap: () {
                        _showToolAlert(context, 'Alcohol Gauging Calculator');
                      },
                    ),
                    CupertinoListTile.notched(
                      leading: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: CupertinoColors.systemTeal,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          CupertinoIcons.drop_fill,
                          color: CupertinoColors.white,
                          size: 18,
                        ),
                      ),
                      title: const Text(
                        'Solvent Density & Mass',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      subtitle: const Text('Convert ml to grams via DPG, TEC, IPM density'),
                      trailing: const CupertinoListTileChevron(),
                      onTap: () {
                        _showToolAlert(context, 'Solvent Mass Converter');
                      },
                    ),
                    CupertinoListTile.notched(
                      leading: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: CupertinoColors.systemGreen,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          CupertinoIcons.shield_lefthalf_fill,
                          color: CupertinoColors.white,
                          size: 18,
                        ),
                      ),
                      title: const Text(
                        'IFRA 51st Amendment Limits',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      subtitle: const Text('Category 4 fine fragrance threshold rules'),
                      trailing: const CupertinoListTileChevron(),
                      onTap: () {
                        _showToolAlert(context, 'IFRA Conformity Checker');
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

  void _showToolAlert(BuildContext context, String toolName) {
    showCupertinoDialog(
      context: context,
      builder: (ctx) => CupertinoAlertDialog(
        title: Text(toolName),
        content: const Padding(
          padding: EdgeInsets.only(top: 8),
          child: Text('Interactive reference calculator module ready.'),
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
