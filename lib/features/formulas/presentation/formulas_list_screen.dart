import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:drift/drift.dart' as drift;
import 'package:perfumery_lab/core/database/app_database.dart';
import 'package:perfumery_lab/core/theme/app_colors.dart';
import 'package:perfumery_lab/core/theme/app_typography.dart';
import 'package:perfumery_lab/core/theme/liquid_glass.dart';
import '../data/formulas_repository.dart';
import 'formula_detail_screen.dart';

class FormulasListScreen extends ConsumerWidget {
  const FormulasListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formulasAsync = ref.watch(formulasStreamProvider);

    return CupertinoPageScaffold(
      backgroundColor: AppColors.systemGroupedBackground.resolveFrom(context),
      child: CustomScrollView(
        slivers: [
          CupertinoSliverNavigationBar(
            largeTitle: const Text('Formulas Lab'),
            trailing: CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () => _showCreateFormulaDialog(context, ref),
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
                                    const SizedBox(height: 3),
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
          const SliverToBoxAdapter(child: SizedBox(height: 40)),
        ],
      ),
    );
  }

  void _showCreateFormulaDialog(BuildContext context, WidgetRef ref) {
    final nameController = TextEditingController();
    final versionController = TextEditingController(text: '1.0');

    showCupertinoDialog(
      context: context,
      builder: (ctx) => CupertinoAlertDialog(
        title: const Text('New Formula'),
        content: Padding(
          padding: const EdgeInsets.only(top: 12),
          child: Column(
            children: [
              CupertinoTextField(
                controller: nameController,
                placeholder: 'Formula Name (e.g. Santal Minimal, Citrus Amber)',
              ),
              const SizedBox(height: 8),
              CupertinoTextField(
                controller: versionController,
                placeholder: 'Version (e.g. 1.0, Mod 3)',
              ),
            ],
          ),
        ),
        actions: [
          CupertinoDialogAction(
            child: const Text('Cancel'),
            onPressed: () => Navigator.pop(ctx),
          ),
          CupertinoDialogAction(
            isDefaultAction: true,
            child: const Text('Create'),
            onPressed: () async {
              if (nameController.text.trim().isEmpty) return;
              final repo = ref.read(formulasRepositoryProvider);
              await repo.createFormula(
                FormulasCompanion.insert(
                  id: const Uuid().v4(),
                  name: nameController.text.trim(),
                  version: drift.Value(versionController.text.trim()),
                ),
              );
              Navigator.pop(ctx);
            },
          ),
        ],
      ),
    );
  }
}
