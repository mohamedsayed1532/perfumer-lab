import 'package:cupertino_ui/cupertino_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:drift/drift.dart' as drift;
import 'package:perfumery_lab/core/database/app_database.dart';
import 'package:perfumery_lab/core/theme/app_colors.dart';
import 'package:perfumery_lab/core/theme/app_typography.dart';
import 'package:perfumery_lab/core/theme/liquid_glass.dart';
import 'package:perfumery_lab/core/utils/haptics.dart';
import 'package:perfumery_lab/features/materials/data/materials_repository.dart';
import '../data/formulas_repository.dart';

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

    return CupertinoPageScaffold(
      backgroundColor: AppColors.systemGroupedBackground.resolveFrom(context),
      navigationBar: CupertinoNavigationBar(
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
                              'SCALE DISPENSE PROGRESS',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: AppColors.secondaryLabel.resolveFrom(context),
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
                              'BATCH GOAL',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: AppColors.secondaryLabel.resolveFrom(context),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${_targetBatchGrams.toStringAsFixed(3)} g',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                fontFeatures: const [FontFeature.tabularFigures()],
                                color: AppColors.accent.resolveFrom(context),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    // Progress Bar
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Container(
                        height: 8,
                        color: AppColors.separator.resolveFrom(context),
                        child: FractionallySizedBox(
                          alignment: Alignment.centerLeft,
                          widthFactor: progressPercent,
                          child: Container(
                            color: progressPercent >= 1.0
                                ? CupertinoColors.systemGreen
                                : AppColors.accent.resolveFrom(context),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Ingredient tare & weigh checklist
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                itemCount: items.length,
                separatorBuilder: (_, _) => const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final row = items[index];
                  final mat = row.material;
                  final item = row.item;

                  // Target grams = targetBatch * (item.ppt / totalPpt)
                  final targetGrams =
                      _targetBatchGrams * (item.partsPerThousand / totalPpt);

                  // Dilution compensation check
                  // If formula calls for 100% neat, but stock is 10%, scale weight needs adjustment
                  final formulaDil = item.specifiedDilutionPercent;
                  final stockDil = mat.dilutionPercent;
                  final isDilutionCompensated =
                      (formulaDil != stockDil) && stockDil > 0;
                  final requiredScaleWeight = isDilutionCompensated
                      ? targetGrams * (formulaDil / stockDil)
                      : targetGrams;

                  final isDone = _completedItems.contains(item.id);
                  final addedWeight = _addedWeights[item.id] ?? 0.0;

                  return GestureDetector(
                    onTap: () => _showWeighInputModal(
                        item.id, mat.name, requiredScaleWeight),
                    child: LiquidGlass(
                      padding: const EdgeInsets.all(14),
                      borderRadius: BorderRadius.circular(16),
                      borderColor: isDone
                          ? CupertinoColors.systemGreen
                          : AppColors.liquidGlassBorder.resolveFrom(context),
                      borderWidth: isDone ? 1.5 : 0.5,
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () async {
                              await LabHaptics.stepCompleted();
                              setState(() {
                                if (isDone) {
                                  _completedItems.remove(item.id);
                                } else {
                                  _completedItems.add(item.id);
                                  _addedWeights[item.id] = requiredScaleWeight;
                                }
                              });
                            },
                            child: Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: isDone
                                    ? CupertinoColors.systemGreen
                                    : AppColors.secondarySystemGroupedBackground
                                        .resolveFrom(context),
                                border: Border.all(
                                  color: isDone
                                      ? CupertinoColors.systemGreen
                                      : AppColors.separator.resolveFrom(context),
                                  width: 1.5,
                                ),
                              ),
                              child: isDone
                                  ? const Icon(CupertinoIcons.checkmark,
                                      size: 18, color: CupertinoColors.white)
                                  : null,
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  mat.name,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: isDone
                                        ? AppColors.secondaryLabel.resolveFrom(context)
                                        : AppColors.label.resolveFrom(context),
                                    decoration: isDone
                                        ? TextDecoration.lineThrough
                                        : null,
                                  ),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  isDilutionCompensated
                                      ? 'Stock: ${stockDil.toStringAsFixed(0)}% in ${mat.defaultSolvent ?? "Solvent"} (Compensated from ${formulaDil.toStringAsFixed(0)}%)'
                                      : 'Stock: ${stockDil.toStringAsFixed(0)}% • ${item.partsPerThousand.toStringAsFixed(1)} ppt',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: isDilutionCompensated
                                        ? CupertinoColors.systemOrange
                                        : AppColors.secondaryLabel.resolveFrom(context),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '${requiredScaleWeight.toStringAsFixed(3)} g',
                                style: AppTypography.precisionNumber(context,
                                    fontSize: 16),
                              ),
                              Text(
                                addedWeight > 0
                                    ? 'Added: ${addedWeight.toStringAsFixed(3)}g'
                                    : 'Pending tare',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: addedWeight > 0
                                      ? CupertinoColors.systemGreen
                                      : AppColors.tertiaryLabel.resolveFrom(context),
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
            // Finish Compounding Button
            Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: CupertinoButton.filled(
                  borderRadius: BorderRadius.circular(16),
                  onPressed: _completedItems.length == items.length
                      ? _finishCompounding
                      : null,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(CupertinoIcons.checkmark_seal_fill, size: 20),
                      const SizedBox(width: 8),
                      Text(
                        _completedItems.length == items.length
                            ? 'Complete & Send to Maturation'
                            : '${_completedItems.length}/${items.length} Dispensed',
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showTargetBatchDialog() {
    final controller =
        TextEditingController(text: _targetBatchGrams.toStringAsFixed(1));
    showCupertinoDialog(
      context: context,
      builder: (ctx) => CupertinoAlertDialog(
        title: const Text('Target Batch Weight'),
        content: Padding(
          padding: const EdgeInsets.only(top: 12),
          child: CupertinoTextField(
            controller: controller,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            placeholder: 'Batch weight in grams (e.g. 50.0)',
          ),
        ),
        actions: [
          CupertinoDialogAction(
            child: const Text('Cancel'),
            onPressed: () => Navigator.pop(ctx),
          ),
          CupertinoDialogAction(
            isDefaultAction: true,
            child: const Text('Set Weight'),
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

  void _showWeighInputModal(
      String itemId, String materialName, double targetGrams) {
    final controller =
        TextEditingController(text: targetGrams.toStringAsFixed(3));
    showCupertinoModalPopup(
      context: context,
      builder: (ctx) => CupertinoActionSheet(
        title: Text('Weigh-In: $materialName'),
        message: Text(
            'Target scale weight is ${targetGrams.toStringAsFixed(3)} g. Enter actual poured scale reading:'),
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
              Navigator.pop(ctx);
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
    final db = ref.read(databaseProvider);
    final batchId = const Uuid().v4();
    final batchNumber =
        'MAT-${DateTime.now().year}-${DateTime.now().millisecondsSinceEpoch % 10000}';

    await db.into(db.agingBatches).insert(
          AgingBatchesCompanion.insert(
            id: batchId,
            batchNumber: batchNumber,
            name: '${widget.formulaWithMaterials.formula.name} Concentrate',
            sourceType: 'formula',
            sourceId: widget.formulaWithMaterials.formula.id,
            stage: 'maturation',
            totalWeightGrams: _targetBatchGrams,
            concentrationPercent: 100.0, // Pure concentrate oil
            startDate: DateTime.now(),
            targetAgingDays: const drift.Value(14), // Default 14 days maturation
          ),
        );

    await LabHaptics.batchSuccess();
    if (mounted) {
      Navigator.pop(context);
      showCupertinoDialog(
        context: context,
        builder: (ctx) => CupertinoAlertDialog(
          title: const Text('Compounding Complete!'),
          content: Text(
              'Batch $batchNumber created and added to Maturation Aging Tracker.'),
          actions: [
            CupertinoDialogAction(
              child: const Text('View Aging Tracker'),
              onPressed: () => Navigator.pop(ctx),
            ),
          ],
        ),
      );
    }
  }
}
