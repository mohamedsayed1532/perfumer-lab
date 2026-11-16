import 'package:cupertino_ui/cupertino_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:perfumery_lab/core/database/app_database.dart';
import 'package:perfumery_lab/core/theme/app_colors.dart';
import 'package:perfumery_lab/core/theme/app_typography.dart';
import 'package:perfumery_lab/core/theme/liquid_glass.dart';
import 'package:perfumery_lab/core/utils/haptics.dart';
import '../data/formulas_repository.dart';
import 'bench_compounding_screen.dart';
import 'add_or_edit_ingredient_sheet.dart';

class FormulaDetailScreen extends ConsumerWidget {
  final String formulaId;
  const FormulaDetailScreen({super.key, required this.formulaId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repo = ref.watch(formulasRepositoryProvider);
    final formulaStream = repo.watchFormulaWithItems(formulaId);

    return StreamBuilder<FormulaWithMaterials?>(
      stream: formulaStream,
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data == null) {
          return const CupertinoPageScaffold(
            child: Center(child: CupertinoActivityIndicator()),
          );
        }

        final data = snapshot.data!;
        final formula = data.formula;
        final items = data.items;
        final totalPpt = data.totalPpt;
        final totalPercent = totalPpt / 10.0;

        return CupertinoPageScaffold(
          backgroundColor:
              AppColors.systemGroupedBackground.resolveFrom(context),
          navigationBar: CupertinoNavigationBar(
            middle: Text(formula.name, style: AppTypography.headline(context)),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () => _confirmDeleteFormula(context, ref, formula),
                  child: const Icon(
                    CupertinoIcons.trash,
                    size: 20,
                    color: CupertinoColors.systemRed,
                  ),
                ),
                const SizedBox(width: 12),
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () => _showAddIngredientSheet(context, formula.id),
                  child: const Icon(CupertinoIcons.add, size: 26),
                ),
              ],
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                // Top Summary Card
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: LiquidGlass(
                    padding: const EdgeInsets.all(16),
                    borderRadius: BorderRadius.circular(18),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'FORMULA TOTAL',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.5,
                                    color: AppColors.secondaryLabel
                                        .resolveFrom(context),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.baseline,
                                  textBaseline: TextBaseline.alphabetic,
                                  children: [
                                    Text(
                                      '${totalPpt.toStringAsFixed(1)} / 1000 ppt',
                                      style: AppTypography.precisionNumber(
                                        context,
                                        fontSize: 20,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 6, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: AppColors.accent
                                            .resolveFrom(context)
                                            .withValues(alpha: 0.18),
                                        borderRadius:
                                            BorderRadius.circular(6),
                                      ),
                                      child: Text(
                                        '${totalPercent.toStringAsFixed(2)}%',
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.accent
                                              .resolveFrom(context),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            CupertinoButton.filled(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              borderRadius: BorderRadius.circular(12),
                              onPressed: items.isEmpty
                                  ? null
                                  : () {
                                      Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                          builder: (_) =>
                                              BenchCompoundingScreen(
                                            formulaWithMaterials: data,
                                          ),
                                        ),
                                      );
                                    },
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    CupertinoIcons.circle_grid_hex_fill,
                                    size: 16,
                                    color: CupertinoColors.white,
                                  ),
                                  SizedBox(width: 6),
                                  Text(
                                    'Compound',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: CupertinoColors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: items.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                CupertinoIcons.list_bullet_indent,
                                size: 48,
                                color:
                                    AppColors.tertiaryLabel.resolveFrom(context),
                              ),
                              const SizedBox(height: 12),
                              Text('No Ingredients Added Yet',
                                  style: AppTypography.headline(context)),
                              const SizedBox(height: 6),
                              Text(
                                'Tap + to add aroma chemicals by ppt or %.',
                                style: AppTypography.subheadline(context),
                              ),
                              const SizedBox(height: 16),
                              CupertinoButton.filled(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                borderRadius: BorderRadius.circular(12),
                                onPressed: () =>
                                    _showAddIngredientSheet(context, formula.id),
                                child: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(CupertinoIcons.add,
                                        size: 18,
                                        color: CupertinoColors.white),
                                    SizedBox(width: 6),
                                    Text(
                                      'Add Ingredient',
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
                        )
                      : ListView.separated(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 4),
                          itemCount: items.length,
                          separatorBuilder: (_, _) =>
                              const SizedBox(height: 10),
                          itemBuilder: (context, index) {
                            final row = items[index];
                            final mat = row.material;
                            final item = row.item;
                            final percent = item.partsPerThousand / 10.0;

                            IconData noteIcon;
                            Color noteColor;
                            switch (mat.pyramidNote.toLowerCase()) {
                              case 'top':
                                noteIcon = CupertinoIcons.triangle;
                                noteColor = CupertinoColors.systemYellow;
                                break;
                              case 'heart':
                                noteIcon = CupertinoIcons.heart_fill;
                                noteColor = CupertinoColors.systemPink;
                                break;
                              case 'base':
                              default:
                                noteIcon = CupertinoIcons.triangle_fill;
                                noteColor = CupertinoColors.systemPurple;
                                break;
                            }

                            return GestureDetector(
                              onTap: () => _openEditIngredientSheet(
                                context,
                                formula.id,
                                row,
                              ),
                              child: LiquidGlass(
                                padding: const EdgeInsets.all(14),
                                borderRadius: BorderRadius.circular(16),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: noteColor.withValues(alpha: 0.2),
                                        borderRadius:
                                            BorderRadius.circular(10),
                                      ),
                                      child: Center(
                                        child: Icon(noteIcon,
                                            size: 18, color: noteColor),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            mat.name,
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.label
                                                  .resolveFrom(context),
                                            ),
                                          ),
                                          const SizedBox(height: 3),
                                          Text(
                                            '${mat.pyramidNote.toUpperCase()} • ${item.specifiedDilutionPercent.toStringAsFixed(0)}% dilution',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: AppColors.secondaryLabel
                                                  .resolveFrom(context),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          '${item.partsPerThousand.toStringAsFixed(1)} ppt',
                                          style: AppTypography.precisionNumber(
                                            context,
                                            fontSize: 16,
                                          ),
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          '${percent.toStringAsFixed(2)}%',
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.accent
                                                .resolveFrom(context),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showAddIngredientSheet(BuildContext context, String formulaId) {
    showCupertinoModalPopup(
      context: context,
      builder: (ctx) => AddOrEditIngredientSheet(formulaId: formulaId),
    );
  }

  void _openEditIngredientSheet(
    BuildContext context,
    String formulaId,
    FormulaItemWithMaterial row,
  ) {
    showCupertinoModalPopup(
      context: context,
      builder: (ctx) => AddOrEditIngredientSheet(
        formulaId: formulaId,
        existing: row,
      ),
    );
  }

  void _confirmDeleteFormula(
    BuildContext context,
    WidgetRef ref,
    Formula formula,
  ) {
    showCupertinoDialog(
      context: context,
      builder: (ctx) => CupertinoAlertDialog(
        title: Text('Delete "${formula.name}"?'),
        content: const Text(
          'This will permanently delete this formula and all its compounding line items. This cannot be undone.',
        ),
        actions: [
          CupertinoDialogAction(
            child: const Text('Cancel'),
            onPressed: () => Navigator.pop(ctx),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            child: const Text('Delete'),
            onPressed: () async {
              Navigator.pop(ctx);
              final repo = ref.read(formulasRepositoryProvider);
              await repo.deleteFormula(formula.id);
              await LabHaptics.batchSuccess();
              if (context.mounted) {
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
    );
  }
}
