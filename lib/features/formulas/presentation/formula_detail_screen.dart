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

class FormulaDetailScreen extends ConsumerStatefulWidget {
  final String formulaId;
  const FormulaDetailScreen({super.key, required this.formulaId});

  @override
  ConsumerState<FormulaDetailScreen> createState() =>
      _FormulaDetailScreenState();
}

class _FormulaDetailScreenState extends ConsumerState<FormulaDetailScreen> {
  String _viewMode = 'ppt'; // 'ppt' | 'grams' | 'active'

  @override
  Widget build(BuildContext context) {
    final repo = ref.watch(formulasRepositoryProvider);
    final formulaStream = repo.watchFormulaWithItems(widget.formulaId);

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
                  // Integrity Header Card
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 10, 16, 6),
                    child: LiquidGlass(
                      padding: const EdgeInsets.all(14),
                      borderRadius: BorderRadius.circular(14),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 12),
                        decoration: BoxDecoration(
                          color: AppColors.recessedWell.resolveFrom(context),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: AppColors.cardBorder.resolveFrom(context),
                            width: 0.5,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Formula integrity',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.secondaryLabel
                                        .resolveFrom(context),
                                  ),
                                ),
                                Text(
                                  '${totalPercent.toStringAsFixed(2)}% Balanced',
                                  style: AppTypography.monoData(
                                    context,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.naturalGreen
                                        .resolveFrom(context),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                Text(
                                  totalPpt.toStringAsFixed(2),
                                  style: AppTypography.precisionNumber(context,
                                      fontSize: 26),
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  '/ 1,000.00 ppt',
                                  style: AppTypography.monoData(
                                    context,
                                    fontSize: 13,
                                    color: AppColors.accentInk
                                        .resolveFrom(context),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
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

                  if (items.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 6, 16, 6),
                      child: SizedBox(
                        width: double.infinity,
                        child: CupertinoSlidingSegmentedControl<String>(
                          groupValue: _viewMode,
                          thumbColor: AppColors.accent.resolveFrom(context),
                          backgroundColor: AppColors
                              .secondarySystemGroupedBackground
                              .resolveFrom(context),
                          children: {
                            'ppt': _buildModeTab('Parts / 1000', _viewMode == 'ppt'),
                            'grams': _buildModeTab('Weight (100g)', _viewMode == 'grams'),
                            'active': _buildModeTab('Pure Active', _viewMode == 'active'),
                          },
                          onValueChanged: (v) {
                            if (v != null) setState(() => _viewMode = v);
                          },
                        ),
                      ),
                    ),

                  const SizedBox(height: 2),

                  // Ingredients List grouped by Top / Heart / Base
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
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(CupertinoIcons.add,
                                          size: 18,
                                          color: AppColors.onAccent(context)),
                                      const SizedBox(width: 6),
                                      Text(
                                        'Add Ingredient',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.onAccent(context),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        : _buildGroupedIngredientsList(
                            context,
                            formula: formula,
                            items: items,
                            totalPpt: totalPpt,
                            ifraService: ifraService,
                          ),
                  ),
                  if (items.isNotEmpty)
                    Container(
                      padding: const EdgeInsets.fromLTRB(16, 10, 16, 12),
                      decoration: BoxDecoration(
                        color: AppColors.liquidGlassBg.resolveFrom(context),
                        border: Border(
                          top: BorderSide(
                            color: AppColors.separator.resolveFrom(context),
                            width: 0.75,
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          CupertinoButton(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            color: AppColors.tertiarySystemGroupedBackground
                                .resolveFrom(context),
                            borderRadius: BorderRadius.circular(12),
                            onPressed: () =>
                                _showAddIngredientSheet(context, formula.id),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(CupertinoIcons.add,
                                    size: 16,
                                    color: AppColors.label.resolveFrom(context)),
                                const SizedBox(width: 6),
                                Text(
                                  'Ingredient',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.label.resolveFrom(context),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: CupertinoButton.filled(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              borderRadius: BorderRadius.circular(12),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (_) => BenchCompoundingScreen(
                                      formulaWithMaterials: data,
                                    ),
                                  ),
                                );
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    CupertinoIcons.lab_flask_solid,
                                    size: 16,
                                    color: AppColors.onAccent(context),
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    'Scale & Compound',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.onAccent(context),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
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

  Widget _buildModeTab(String label, bool isSelected) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
          color: isSelected
              ? AppColors.onAccent(context)
              : AppColors.label.resolveFrom(context),
        ),
      ),
    );
  }

  Widget _buildGroupedIngredientsList(
    BuildContext context, {
    required Formula formula,
    required List<FormulaItemWithMaterial> items,
    required double totalPpt,
    required IfraSafetyService ifraService,
  }) {
    final topItems = <FormulaItemWithMaterial>[];
    final heartItems = <FormulaItemWithMaterial>[];
    final baseItems = <FormulaItemWithMaterial>[];

    for (final row in items) {
      final note = row.material.pyramidNote.toLowerCase().trim();
      if (note == 'top') {
        topItems.add(row);
      } else if (note == 'heart' || note == 'middle') {
        heartItems.add(row);
      } else {
        baseItems.add(row);
      }
    }

    final sections = [
      (
        title: 'Top notes',
        color: AppColors.accent.resolveFrom(context),
        icon: CupertinoIcons.sparkles,
        rows: topItems,
      ),
      (
        title: 'Heart notes',
        color: AppColors.naturalGreen.resolveFrom(context),
        icon: CupertinoIcons.heart_fill,
        rows: heartItems,
      ),
      (
        title: 'Base notes',
        color: AppColors.secondaryLabel.resolveFrom(context),
        icon: CupertinoIcons.shield_fill,
        rows: baseItems,
      ),
    ].where((s) => s.rows.isNotEmpty).toList();

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
      children: [
        for (final section in sections) ...[
          Padding(
            padding: const EdgeInsets.fromLTRB(4, 10, 4, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 7,
                      height: 7,
                      decoration: BoxDecoration(
                        color: section.color,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 7),
                    Text(
                      section.title,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.label.resolveFrom(context),
                      ),
                    ),
                  ],
                ),
                Text(
                  _formatSectionTotal(section.rows, totalPpt),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    fontFeatures: const [FontFeature.tabularFigures()],
                    color: AppColors.secondaryLabel.resolveFrom(context),
                  ),
                ),
              ],
            ),
          ),
          for (final row in section.rows)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: _buildIngredientCard(
                context,
                formula: formula,
                row: row,
                totalPpt: totalPpt,
                ifraService: ifraService,
                noteIcon: section.icon,
                noteColor: section.color,
              ),
            ),
        ],
      ],
    );
  }

  String _formatSectionTotal(
      List<FormulaItemWithMaterial> rows, double totalPpt) {
    final sumPpt =
        rows.fold<double>(0.0, (sum, r) => sum + r.item.partsPerThousand);
    final pct = totalPpt > 0 ? (sumPpt / totalPpt) * 100.0 : 0.0;
    return '${sumPpt.toStringAsFixed(1)} ppt • ${pct.toStringAsFixed(0)}%';
  }

  Widget _buildIngredientCard(
    BuildContext context, {
    required Formula formula,
    required FormulaItemWithMaterial row,
    required double totalPpt,
    required IfraSafetyService ifraService,
    required IconData noteIcon,
    required Color noteColor,
  }) {
    final mat = row.material;
    final item = row.item;
    final percent = totalPpt > 0
        ? (item.partsPerThousand / totalPpt) * 100.0
        : item.partsPerThousand / 10.0;

    final hasIfraLimit =
        mat.idealMaxPercent != null && mat.idealMaxPercent! > 0;
    final skinExposure = hasIfraLimit
        ? ifraService.calculateSkinExposure(
            partsPerThousand: item.partsPerThousand,
            totalPpt: totalPpt > 0 ? totalPpt : 1000.0,
            specifiedDilutionPercent: item.specifiedDilutionPercent,
            targetConcentrationPercent: formula.targetConcentrationPercent,
          )
        : 0.0;
    final isOverIfra =
        hasIfraLimit && (skinExposure > (mat.idealMaxPercent! + 0.00001));

    String primaryMetric;
    String secondaryMetric;
    switch (_viewMode) {
      case 'grams':
        final gramsIn100 =
            totalPpt > 0 ? (item.partsPerThousand / totalPpt) * 100.0 : 0.0;
        primaryMetric = '${gramsIn100.toStringAsFixed(2)} g';
        secondaryMetric = '${item.partsPerThousand.toStringAsFixed(1)} ppt';
        break;
      case 'active':
        final pureActive = percent * (item.specifiedDilutionPercent / 100.0);
        primaryMetric = '${pureActive.toStringAsFixed(2)}%';
        secondaryMetric =
            '${item.specifiedDilutionPercent.toStringAsFixed(0)}% dil.';
        break;
      case 'ppt':
      default:
        primaryMetric = '${item.partsPerThousand.toStringAsFixed(1)} ppt';
        secondaryMetric = '${percent.toStringAsFixed(2)}%';
        break;
    }

    return GestureDetector(
      onTap: () => _openEditIngredientSheet(context, formula.id, row),
      child: LiquidGlass(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
        borderRadius: BorderRadius.circular(16),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: noteColor.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: noteColor.withValues(alpha: 0.28),
                  width: 0.75,
                ),
              ),
              child: Center(
                child: Icon(noteIcon, size: 16, color: noteColor),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    mat.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.atelierCardTitle(context, fontSize: 16),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    '${item.specifiedDilutionPercent.toStringAsFixed(0)}% dilution${mat.casNumber != null && mat.casNumber!.isNotEmpty ? ' • ${mat.casNumber}' : ''}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12.5,
                      color: AppColors.secondaryLabel.resolveFrom(context),
                    ),
                  ),
                  if (hasIfraLimit) ...[
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          isOverIfra
                              ? CupertinoIcons.exclamationmark_triangle_fill
                              : CupertinoIcons.checkmark_shield_fill,
                          size: 11,
                          color: isOverIfra
                              ? CupertinoColors.systemRed
                              : CupertinoColors.systemGreen,
                        ),
                        const SizedBox(width: 4),
                        Flexible(
                          child: Text(
                            isOverIfra
                                ? 'IFRA Violation: ${skinExposure.toStringAsFixed(2)}% > Max ${mat.idealMaxPercent!.toStringAsFixed(2)}%'
                                : 'IFRA Safe: ${skinExposure.toStringAsFixed(2)}% (Max ${mat.idealMaxPercent!.toStringAsFixed(2)}%)',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: isOverIfra
                                  ? FontWeight.w700
                                  : FontWeight.w500,
                              color: isOverIfra
                                  ? CupertinoColors.systemRed
                                  : CupertinoColors.systemGreen,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(width: 8),
            ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 54),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    primaryMetric,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.precisionNumber(context, fontSize: 16),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    secondaryMetric,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      fontFeatures: const [FontFeature.tabularFigures()],
                      color: AppColors.accent.resolveFrom(context),
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
