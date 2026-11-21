import 'package:cupertino_ui/cupertino_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:perfumery_lab/core/theme/app_colors.dart';
import 'package:perfumery_lab/core/theme/app_typography.dart';
import 'package:perfumery_lab/core/theme/liquid_glass.dart';
import '../data/formulas_repository.dart';
import 'formula_detail_screen.dart';
import 'create_formula_sheet.dart';

class FormulasListScreen extends ConsumerWidget {
  const FormulasListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formulasAsync = ref.watch(formulasStreamProvider);

    return LiquidGlassBackground(
      child: CupertinoPageScaffold(
        backgroundColor: CupertinoColors.transparent,
        child: CustomScrollView(
          slivers: [
            CupertinoSliverNavigationBar(
              backgroundColor: AppColors.liquidGlassBg.resolveFrom(context),
              largeTitle: const Text('Formulas Lab'),
              trailing: CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () => _openCreateFormula(context),
                child: const Icon(CupertinoIcons.add, size: 26),
              ),
            ),
            formulasAsync.when(
              data: (formulas) {
                if (formulas.isEmpty) {
                  return SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            CupertinoIcons.lab_flask,
                            size: 48,
                            color: AppColors.tertiaryLabel.resolveFrom(context),
                          ),
                          const SizedBox(height: 12),
                          Text('No Formulas Created Yet',
                              style: AppTypography.headline(context)),
                          const SizedBox(height: 6),
                          Text('Tap + to create your first fragrance formula.',
                              style: AppTypography.subheadline(context)),
                          const SizedBox(height: 20),
                          CupertinoButton.filled(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 12),
                            borderRadius: BorderRadius.circular(14),
                            onPressed: () => _openCreateFormula(context),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(CupertinoIcons.add,
                                    size: 18, color: CupertinoColors.white),
                                SizedBox(width: 8),
                                Text(
                                  'Create Formula',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: CupertinoColors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                return SliverPadding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final formula = formulas[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (_) =>
                                      FormulaDetailScreen(formulaId: formula.id),
                                ),
                              );
                            },
                            child: LiquidGlass(
                              padding: const EdgeInsets.all(16),
                              borderRadius: BorderRadius.circular(18),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        formula.name,
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.label.resolveFrom(context),
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        'v${formula.version} • Concentration: ${formula.targetConcentrationPercent.toStringAsFixed(0)}% EdP',
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: AppColors.secondaryLabel
                                              .resolveFrom(context),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Icon(
                                    CupertinoIcons.chevron_forward,
                                    size: 16,
                                    color:
                                        AppColors.tertiaryLabel.resolveFrom(context),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      childCount: formulas.length,
                    ),
                  ),
                );
              },
              loading: () => const SliverFillRemaining(
                child: Center(child: CupertinoActivityIndicator()),
              ),
              error: (err, _) => SliverFillRemaining(
                child: Center(child: Text('Error: $err')),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 100)),
          ],
        ),
      ),
    );
  }

  void _openCreateFormula(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (ctx) => const CreateFormulaSheet(),
    );
  }
}
