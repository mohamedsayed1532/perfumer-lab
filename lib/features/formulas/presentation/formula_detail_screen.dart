import 'package:cupertino_ui/cupertino_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:perfumery_lab/core/database/app_database.dart';
import 'package:perfumery_lab/core/services/ifra_safety_service.dart';
import 'package:perfumery_lab/core/theme/app_colors.dart';
import 'package:perfumery_lab/core/theme/app_typography.dart';
import 'package:perfumery_lab/core/theme/liquid_glass.dart';
import 'package:perfumery_lab/core/utils/haptics.dart';
import '../data/formulas_repository.dart';
import 'bench_compounding_screen.dart';
import 'add_or_edit_ingredient_sheet.dart';
import 'widgets/ifra_safety_banner.dart';
import 'widgets/olfactory_pyramid_bar.dart';

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

        const ifraService = IfraSafetyService();
        final safetyInputs = items
            .map(
              (i) => FormulaItemSafetyInput(
                id: i.item.id,
                name: i.material.name,
                partsPerThousand: i.item.partsPerThousand,
                specifiedDilutionPercent: i.item.specifiedDilutionPercent,
                idealMaxPercent: i.material.idealMaxPercent,
              ),
            )
            .toList();

        final ifraEvaluation = ifraService.evaluateFormulaSafety(
          targetConcentrationPercent: formula.targetConcentrationPercent,
          items: safetyInputs,
        );

        return LiquidGlassBackground(
          child: CupertinoPageScaffold(
            backgroundColor: CupertinoColors.transparent,
            navigationBar: CupertinoNavigationBar(
              backgroundColor: AppColors.liquidGlassBg.resolveFrom(context),
              middle: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(formula.name, style: AppTypography.headline(context)),
                  Text(
                    '${formula.version} • ${formula.targetConcentrationPercent.toStringAsFixed(0)}% EdP',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                      color: AppColors.secondaryLabel.resolveFrom(context),
                    ),
                  ),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () =>
                        _showMoreActionsSheet(context, ref, formula),
                    child: const Icon(
                      CupertinoIcons.ellipsis_circle,
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 8),
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () =>
                        _showAddIngredientSheet(context, formula.id),
                    child: const Icon(CupertinoIcons.add, size: 24),
                  ),
                ],
              ),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  // Top Summary Card
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                    child: LiquidGlass(
                      padding: const EdgeInsets.all(16),
                      borderRadius: BorderRadius.circular(16),
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
                                      fontSize: 11,
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
                              Opacity(
                                opacity: items.isEmpty ? 0.4 : 1.0,
                                child: CupertinoButton.filled(
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
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  // IFRA 51st Amendment Safety Banner
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    child: IfraSafetyBanner(
                      evaluation: ifraEvaluation,
                      targetConcentrationPercent:
                          formula.targetConcentrationPercent,
                    ),
                  ),

                  // Olfactory Balance Bar
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    child: OlfactoryPyramidBar(formulaData: data),
                  ),

                  const SizedBox(height: 4),

                  // Ingredients List
                  Expanded(
                    child: items.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  CupertinoIcons.list_bullet_indent,
                                  size: 48,
                                  color: AppColors.tertiaryLabel
                                      .resolveFrom(context),
                                ),
                                const SizedBox(height: 12),
                                Text('Nothing here yet',
                                    style: AppTypography.headline(context)),
                                const SizedBox(height: 6),
                                Text(
                                  'Tap + to add your first material and begin the accord.',
                                  style: AppTypography.subheadline(context),
                                ),
                                const SizedBox(height: 16),
                                CupertinoButton.filled(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  borderRadius: BorderRadius.circular(12),
                                  onPressed: () => _showAddIngredientSheet(
                                      context, formula.id),
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
                            padding: const EdgeInsets.fromLTRB(16, 4, 16, 20),
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
                                  noteIcon = CupertinoIcons.sparkles;
                                  noteColor = const Color(0xFFE5A93C);
                                  break;
                                case 'heart':
                                case 'middle':
                                  noteIcon = CupertinoIcons.heart_fill;
                                  noteColor = const Color(0xFFD47355);
                                  break;
                                case 'base':
                                default:
                                  noteIcon = CupertinoIcons.shield_fill;
                                  noteColor = const Color(0xFF8A3B3B);
                                  break;
                              }

                              final hasIfraLimit = mat.idealMaxPercent != null &&
                                  mat.idealMaxPercent! > 0;
                              final skinExposure = hasIfraLimit
                                  ? ifraService.calculateSkinExposure(
                                      partsPerThousand: item.partsPerThousand,
                                      totalPpt: totalPpt > 0 ? totalPpt : 1000.0,
                                      specifiedDilutionPercent:
                                          item.specifiedDilutionPercent,
                                      targetConcentrationPercent:
                                          formula.targetConcentrationPercent,
                                    )
                                  : 0.0;
                              final isOverIfra = hasIfraLimit &&
                                  (skinExposure > (mat.idealMaxPercent! + 0.00001));

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
                                          color:
                                              noteColor.withValues(alpha: 0.2),
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
                                              style: AppTypography.atelierCardTitle(
                                                  context,
                                                  fontSize: 16),
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
                                            if (hasIfraLimit) ...[
                                              const SizedBox(height: 4),
                                              Row(
                                                children: [
                                                  Icon(
                                                    isOverIfra
                                                        ? CupertinoIcons
                                                            .exclamationmark_triangle_fill
                                                        : CupertinoIcons
                                                            .checkmark_shield_fill,
                                                    size: 11,
                                                    color: isOverIfra
                                                        ? CupertinoColors
                                                            .systemRed
                                                        : CupertinoColors
                                                            .systemGreen,
                                                  ),
                                                  const SizedBox(width: 4),
                                                  Text(
                                                    isOverIfra
                                                        ? 'IFRA Violation: ${skinExposure.toStringAsFixed(2)}% > Max ${mat.idealMaxPercent!.toStringAsFixed(2)}%'
                                                        : 'IFRA Safe: ${skinExposure.toStringAsFixed(2)}% (Max ${mat.idealMaxPercent!.toStringAsFixed(2)}%)',
                                                    style: TextStyle(
                                                      fontSize: 11,
                                                      fontWeight: isOverIfra
                                                          ? FontWeight.w700
                                                          : FontWeight.w500,
                                                      color: isOverIfra
                                                          ? CupertinoColors
                                                              .systemRed
                                                          : CupertinoColors
                                                              .systemGreen,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ],
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            '${item.partsPerThousand.toStringAsFixed(1)} ppt',
                                            style:
                                                AppTypography.precisionNumber(
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
          ),
        );
      },
    );
  }

  void _showMoreActionsSheet(
    BuildContext context,
    WidgetRef ref,
    Formula formula,
  ) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (ctx) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(ctx);
              _showDuplicateModDialog(context, ref, formula);
            },
            child: const Text('Duplicate as Mod'),
          ),
          CupertinoActionSheetAction(
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(ctx);
              _confirmDeleteFormula(context, ref, formula);
            },
            child: const Text('Delete Formula'),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          onPressed: () => Navigator.pop(ctx),
          child: const Text('Cancel'),
        ),
      ),
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

  void _showDuplicateModDialog(
    BuildContext context,
    WidgetRef ref,
    Formula formula,
  ) {
    final nameController = TextEditingController(text: '${formula.name} Mod 2');
    final versionController = TextEditingController(text: 'Mod 2');

    showCupertinoDialog(
      context: context,
      builder: (ctx) => CupertinoAlertDialog(
        title: const Text('Duplicate Formula as Mod'),
        content: Padding(
          padding: const EdgeInsets.only(top: 12),
          child: Column(
            children: [
              const Text(
                'Branch this formula to test a new iteration while preserving the original.',
                style: TextStyle(fontSize: 12),
              ),
              const SizedBox(height: 12),
              CupertinoTextField(
                controller: nameController,
                placeholder: 'Formula Name',
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 8),
              CupertinoTextField(
                controller: versionController,
                placeholder: 'Version / Mod Tag',
                style: const TextStyle(fontSize: 14),
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
            child: const Text('Duplicate'),
            onPressed: () async {
              final newName = nameController.text.trim();
              if (newName.isEmpty) return;
              Navigator.pop(ctx);

              final repo = ref.read(formulasRepositoryProvider);
              final newId = await repo.duplicateFormulaAsMod(
                sourceFormulaId: formula.id,
                newName: newName,
                newVersion: versionController.text.trim(),
              );
              await LabHaptics.batchSuccess();

              if (context.mounted) {
                Navigator.pushReplacement(
                  context,
                  CupertinoPageRoute(
                    builder: (_) => FormulaDetailScreen(formulaId: newId),
                  ),
                );
              }
            },
          ),
        ],
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
