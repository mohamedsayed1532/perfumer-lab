import 'package:cupertino_ui/cupertino_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:perfumery_lab/core/services/ifra_safety_service.dart';
import 'package:perfumery_lab/core/theme/app_colors.dart';
import 'package:perfumery_lab/core/theme/app_typography.dart';
import 'package:perfumery_lab/core/theme/liquid_glass.dart';
import 'package:perfumery_lab/core/utils/haptics.dart';
import '../data/formulas_repository.dart';
import 'compounding_summary_sheet.dart';

class BenchCompoundingScreen extends ConsumerStatefulWidget {
  final FormulaWithMaterials formulaWithMaterials;
  const BenchCompoundingScreen({super.key, required this.formulaWithMaterials});

  @override
  ConsumerState<BenchCompoundingScreen> createState() =>
      _BenchCompoundingScreenState();
}

class _BenchCompoundingScreenState
    extends ConsumerState<BenchCompoundingScreen> {
  double _targetBatchGrams = 50.0; // Default 50g bench batch
  final Map<String, double> _addedWeights = {};
  final Set<String> _completedItems = {};

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkIfraSafetyAdvisory();
    });
  }

  void _checkIfraSafetyAdvisory() {
    const ifraService = IfraSafetyService();
    final items = widget.formulaWithMaterials.items;
    final formula = widget.formulaWithMaterials.formula;

    final inputs = items
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

    final evaluation = ifraService.evaluateFormulaSafety(
      targetConcentrationPercent: formula.targetConcentrationPercent,
      items: inputs,
    );

    if (!evaluation.isCompliant && mounted) {
      showCupertinoDialog(
        context: context,
        builder: (ctx) => CupertinoAlertDialog(
          title: const Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(CupertinoIcons.exclamationmark_shield_fill,
                  color: CupertinoColors.systemRed, size: 20),
              SizedBox(width: 6),
              Text('IFRA Safety Advisory'),
            ],
          ),
          content: Text(
            'This formula contains ${evaluation.violations.length} restricted ingredient(s) exceeding Category 4 skin contact limits at ${formula.targetConcentrationPercent.toStringAsFixed(0)}% EdP concentration.\n\nProceed only if compounding for technical evaluation or blotter testing.',
          ),
          actions: [
            CupertinoDialogAction(
              child: const Text('Acknowledge & Proceed'),
              onPressed: () => Navigator.pop(ctx),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final formula = widget.formulaWithMaterials.formula;
    final items = widget.formulaWithMaterials.items;
    final totalPpt = widget.formulaWithMaterials.totalPpt > 0
        ? widget.formulaWithMaterials.totalPpt
        : 1000.0;

    double totalAddedSoFar = _addedWeights.values.fold(0.0, (a, b) => a + b);
    double progressPercent = (_targetBatchGrams > 0)
        ? (totalAddedSoFar / _targetBatchGrams).clamp(0.0, 1.0)
        : 0.0;

    return LiquidGlassBackground(
      child: CupertinoPageScaffold(
        backgroundColor: CupertinoColors.transparent,
        navigationBar: CupertinoNavigationBar(
          backgroundColor: AppColors.liquidGlassBg.resolveFrom(context),
          middle: Text('Compounding: ${formula.name}',
              style: AppTypography.headline(context)),
          trailing: CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: _showTargetBatchDialog,
            child: Text('${_targetBatchGrams.toStringAsFixed(0)}g Target',
                style: const TextStyle(fontWeight: FontWeight.w600)),
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Top Bench HUD Card
              Padding(
                padding: const EdgeInsets.all(16),
                child: LiquidGlass(
                  padding: const EdgeInsets.all(18),
                  borderRadius: BorderRadius.circular(20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Scale dispense progress',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.secondaryLabel
                                      .resolveFrom(context),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${totalAddedSoFar.toStringAsFixed(3)} g',
                                style: AppTypography.precisionNumber(context,
                                    fontSize: 28),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'Batch goal',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.secondaryLabel
                                      .resolveFrom(context),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${_targetBatchGrams.toStringAsFixed(1)} g',
                                style: AppTypography.precisionNumber(context,
                                    fontSize: 24),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: Container(
                          height: 8,
                          color: AppColors.tertiaryLabel.resolveFrom(context),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: FractionallySizedBox(
                              widthFactor: progressPercent,
                              child: Container(
                                color: progressPercent >= 1.0
                                    ? CupertinoColors.systemGreen
                                    : AppColors.accent.resolveFrom(context),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Active Dispensing Focus Card
              if (items.isNotEmpty)
                Builder(
                  builder: (context) {
                    final nextRow = items
                        .where((r) => !_completedItems.contains(r.item.id))
                        .firstOrNull;
                    if (nextRow == null) {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                        child: LiquidGlass(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          borderRadius: BorderRadius.circular(14),
                          child: const Row(
                            children: [
                              Icon(CupertinoIcons.checkmark_seal_fill,
                                  color: CupertinoColors.systemGreen, size: 18),
                              SizedBox(width: 10),
                              Text(
                                'All ingredients weighed and ready to log',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: CupertinoColors.systemGreen,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                    final nextTarget = (nextRow.item.partsPerThousand / totalPpt) *
                        _targetBatchGrams;
                    final nextAdded = _addedWeights[nextRow.item.id] ?? 0.0;
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                      child: LiquidGlass(
                        padding: const EdgeInsets.all(14),
                        borderRadius: BorderRadius.circular(16),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 7,
                                        height: 7,
                                        decoration: BoxDecoration(
                                          color: AppColors.accent
                                              .resolveFrom(context),
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        'Next to weigh',
                                        style: TextStyle(
                                          fontSize: 11.5,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.accent
                                              .resolveFrom(context),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    nextRow.material.name,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppTypography.atelierCardTitle(
                                        context,
                                        fontSize: 16),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    'Target ${nextTarget.toStringAsFixed(3)} g • ${nextRow.item.specifiedDilutionPercent.toStringAsFixed(0)}% dilution',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: AppColors.secondaryLabel
                                          .resolveFrom(context),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 10),
                            CupertinoButton(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 14, vertical: 8),
                              color: AppColors.accent.resolveFrom(context),
                              borderRadius: BorderRadius.circular(10),
                              onPressed: () => _showRecordWeightDialog(
                                nextRow.item.id,
                                nextRow.material.name,
                                nextTarget,
                                nextAdded,
                              ),
                              child: Text(
                                'Weigh',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.onAccent(context),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),

              // Materials List with Target Weight
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: items.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final row = items[index];
                    final mat = row.material;
                    final item = row.item;
                    final isDone = _completedItems.contains(item.id);

                    // Compute target grams for this batch size
                    final itemTargetGrams =
                        (item.partsPerThousand / totalPpt) * _targetBatchGrams;
                    final addedGrams = _addedWeights[item.id] ?? 0.0;

                    return GestureDetector(
                      onTap: () => _showRecordWeightDialog(
                        item.id,
                        mat.name,
                        itemTargetGrams,
                        addedGrams,
                      ),
                      child: LiquidGlass(
                        padding: const EdgeInsets.all(14),
                        borderRadius: BorderRadius.circular(16),
                        child: Row(
                          children: [
                            Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: isDone
                                    ? CupertinoColors.systemGreen
                                        .withValues(alpha: 0.2)
                                    : AppColors.tertiaryLabel
                                        .resolveFrom(context),
                              ),
                              child: Center(
                                child: Icon(
                                  isDone
                                      ? CupertinoIcons.check_mark
                                      : CupertinoIcons.circle,
                                  size: 18,
                                  color: isDone
                                      ? CupertinoColors.systemGreen
                                      : AppColors.secondaryLabel
                                          .resolveFrom(context),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    mat.name,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      decoration: isDone
                                          ? TextDecoration.lineThrough
                                          : null,
                                      color: isDone
                                          ? AppColors.secondaryLabel
                                              .resolveFrom(context)
                                          : AppColors.label
                                              .resolveFrom(context),
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    '${mat.pyramidNote[0].toUpperCase()}${mat.pyramidNote.substring(1).toLowerCase()} note • ${item.specifiedDilutionPercent.toStringAsFixed(0)}% • Stock ${mat.stockGrams.toStringAsFixed(1)} g',
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: AppColors.secondaryLabel
                                          .resolveFrom(context),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'Target: ${itemTargetGrams.toStringAsFixed(3)} g',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.secondaryLabel
                                        .resolveFrom(context),
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  isDone
                                      ? '${addedGrams.toStringAsFixed(3)} g'
                                      : '0.000 g',
                                  style: AppTypography.precisionNumber(
                                    context,
                                    fontSize: 16,
                                  ).copyWith(
                                    color: isDone
                                        ? CupertinoColors.systemGreen
                                        : null,
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

              // Bottom Finish Compounding Button
              Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  width: double.infinity,
                  child: CupertinoButton.filled(
                    borderRadius: BorderRadius.circular(16),
                    onPressed: _finishCompounding,
                    child: Text(
                      'Finish Compounding & Deduct Stock',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.onAccent(context),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showTargetBatchDialog() {
    final controller =
        TextEditingController(text: _targetBatchGrams.toStringAsFixed(0));
    showCupertinoDialog(
      context: context,
      builder: (ctx) => CupertinoAlertDialog(
        title: const Text('Set Target Batch Size'),
        content: Padding(
          padding: const EdgeInsets.only(top: 12),
          child: CupertinoTextField(
            controller: controller,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            suffix: const Padding(
              padding: EdgeInsets.only(right: 8),
              child: Text('grams'),
            ),
          ),
        ),
        actions: [
          CupertinoDialogAction(
            child: const Text('Cancel'),
            onPressed: () => Navigator.pop(ctx),
          ),
          CupertinoDialogAction(
            isDefaultAction: true,
            child: const Text('Update'),
            onPressed: () {
              final val = double.tryParse(controller.text);
              if (val != null && val > 0) {
                setState(() => _targetBatchGrams = val);
              }
              Navigator.pop(ctx);
            },
          ),
        ],
      ),
    );
  }

  void _showRecordWeightDialog(
    String itemId,
    String materialName,
    double targetGrams,
    double currentAdded,
  ) {
    final controller = TextEditingController(
        text: currentAdded > 0
            ? currentAdded.toStringAsFixed(3)
            : targetGrams.toStringAsFixed(3));

    showCupertinoModalPopup(
      context: context,
      builder: (ctx) => CupertinoActionSheet(
        title: Text('Record Weight: $materialName'),
        message: Text(
            'Target: ${targetGrams.toStringAsFixed(3)} g\nPlace beaker on scale, tare, and dispense material.'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: CupertinoTextField(
              controller: controller,
              autofocus: true,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              style: AppTypography.precisionNumber(context, fontSize: 26),
              textAlign: TextAlign.center,
            ),
          ),
          CupertinoActionSheetAction(
            child: const Text('Record Scale Weight & Mark Done'),
            onPressed: () async {
              final val = double.tryParse(controller.text) ?? targetGrams;
              await LabHaptics.stepCompleted();
              setState(() {
                _addedWeights[itemId] = val;
                _completedItems.add(itemId);
              });
              if (ctx.mounted) {
                Navigator.pop(ctx);
              }
            },
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          child: const Text('Cancel'),
          onPressed: () => Navigator.pop(ctx),
        ),
      ),
    );
  }

  Future<void> _finishCompounding() async {
    final items = widget.formulaWithMaterials.items;
    final unweighedCount = items.length - _completedItems.length;

    if (unweighedCount > 0) {
      final shouldProceed = await showCupertinoDialog<bool>(
        context: context,
        builder: (ctx) => CupertinoAlertDialog(
          title: const Text('Incomplete Compounding'),
          content: Text(
            '$unweighedCount ingredient(s) have not been checked off on the scale. Finish compounding with only the recorded items and deduct their stock?',
          ),
          actions: [
            CupertinoDialogAction(
              child: const Text('Return to Scale'),
              onPressed: () => Navigator.pop(ctx, false),
            ),
            CupertinoDialogAction(
              isDestructiveAction: true,
              child: const Text('Finish Anyway'),
              onPressed: () => Navigator.pop(ctx, true),
            ),
          ],
        ),
      );
      if (shouldProceed != true) return;
    }

    final repo = ref.read(formulasRepositoryProvider);
    final batchNumber =
        'MAT-${DateTime.now().year}-${DateTime.now().millisecondsSinceEpoch % 10000}';

    // Map weighed grams by material ID
    final weighedByMaterial = <String, double>{};
    for (final row in items) {
      if (_completedItems.contains(row.item.id)) {
        final weighed = _addedWeights[row.item.id] ?? 0.0;
        if (weighed > 0) {
          weighedByMaterial[row.material.id] = weighed;
        }
      }
    }

    final result = await repo.compoundBatchAndDeductStock(
      formulaId: widget.formulaWithMaterials.formula.id,
      formulaName: widget.formulaWithMaterials.formula.name,
      batchNumber: batchNumber,
      targetBatchGrams: _targetBatchGrams,
      weighedGramsByMaterialId: weighedByMaterial,
    );

    await LabHaptics.batchSuccess();

    if (mounted) {
      await showCupertinoModalPopup(
        context: context,
        builder: (ctx) => CompoundingSummarySheet(
          result: result,
          formulaData: widget.formulaWithMaterials,
        ),
      );

      if (mounted) {
        Navigator.pop(context);
      }
    }
  }
}
