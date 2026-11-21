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

class FoDilutionCalculatorSheet extends ConsumerStatefulWidget {
  final ReadyOil? selectedOil;
  const FoDilutionCalculatorSheet({super.key, this.selectedOil});

  @override
  ConsumerState<FoDilutionCalculatorSheet> createState() =>
      _FoDilutionCalculatorSheetState();
}

class _FoDilutionCalculatorSheetState
    extends ConsumerState<FoDilutionCalculatorSheet> {
  late TextEditingController _batchWeightController;
  late TextEditingController _concentrationController;
  late TextEditingController _waterController;
  late TextEditingController _batchNameController;

  @override
  void initState() {
    super.initState();
    _batchWeightController = TextEditingController(text: '100.0'); // 100g
    _concentrationController = TextEditingController(text: '20.0'); // 20% EdP
    _waterController = TextEditingController(text: '3.0'); // 3% Distilled water
    _batchNameController = TextEditingController(
        text: widget.selectedOil != null
            ? '${widget.selectedOil!.name} 20% EdP'
            : 'New Perfume Batch');
  }

  @override
  void dispose() {
    _batchWeightController.dispose();
    _concentrationController.dispose();
    _waterController.dispose();
    _batchNameController.dispose();
    super.dispose();
  }

  Future<void> _startMacerationBatch() async {
    final totalGrams = double.tryParse(_batchWeightController.text) ?? 100.0;
    final concPercent = double.tryParse(_concentrationController.text) ?? 20.0;
    final waterPercent = double.tryParse(_waterController.text) ?? 3.0;

    final db = ref.read(databaseProvider);
    final batchId = const Uuid().v4();
    final batchNumber =
        'MAC-${DateTime.now().year}-${DateTime.now().millisecondsSinceEpoch % 10000}';

    await db.into(db.agingBatches).insert(
          AgingBatchesCompanion.insert(
            id: batchId,
            batchNumber: batchNumber,
            name: _batchNameController.text.trim(),
            sourceType: 'ready_oil',
            sourceId: widget.selectedOil?.id ?? 'custom-fo',
            stage: 'maceration',
            totalWeightGrams: totalGrams,
            concentrationPercent: concPercent,
            waterPercent: drift.Value(waterPercent),
            alcoholType: const drift.Value('96° Perfumer’s Alcohol'),
            startDate: DateTime.now(),
            targetAgingDays: const drift.Value(30),
          ),
        );

    await LabHaptics.stepCompleted();
    if (mounted) {
      Navigator.pop(context);
      showCupertinoDialog(
        context: context,
        builder: (ctx) => CupertinoAlertDialog(
          title: const Text('Maceration Batch Started'),
          content: Text(
              'Batch $batchNumber created! Timer and aging evaluation schedule is now active in Aging & Batches.'),
          actions: [
            CupertinoDialogAction(
              child: const Text('Great'),
              onPressed: () => Navigator.pop(ctx),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final totalGrams = double.tryParse(_batchWeightController.text) ?? 0.0;
    final concPercent = double.tryParse(_concentrationController.text) ?? 0.0;
    final waterPercent = double.tryParse(_waterController.text) ?? 0.0;

    // Calculation:
    // Oil (g) = Total * (Conc% / 100)
    // Water (g) = Total * (Water% / 100)
    // Alcohol (g) = Total - Oil - Water
    final oilGrams = totalGrams * (concPercent / 100.0);
    final waterGrams = totalGrams * (waterPercent / 100.0);
    final alcoholGrams = (totalGrams - oilGrams - waterGrams).clamp(0.0, 999999.0);

    return CupertinoPageScaffold(
      backgroundColor: AppColors.systemGroupedBackground.resolveFrom(context),
      navigationBar: CupertinoNavigationBar(
        middle: Text('FO Dilution Recipe', style: AppTypography.headline(context)),
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
      ),
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          children: [
            if (widget.selectedOil != null) ...[
              LiquidGlass(
                padding: const EdgeInsets.all(14),
                child: Row(
                  children: [
                    const Icon(CupertinoIcons.drop_fill,
                        size: 24, color: CupertinoColors.systemPink),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.selectedOil!.name,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppColors.label.resolveFrom(context),
                            ),
                          ),
                          Text(
                            'Supplier: ${widget.selectedOil!.supplier ?? "In-House"} • Stock: ${widget.selectedOil!.stockGrams.toStringAsFixed(1)}g',
                            style: TextStyle(
                              fontSize: 13,
                              color:
                                  AppColors.secondaryLabel.resolveFrom(context),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],
            Text(
              'BATCH TARGETS',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.secondaryLabel.resolveFrom(context),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: AppColors.secondarySystemGroupedBackground
                    .resolveFrom(context),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: AppColors.separator.resolveFrom(context),
                  width: 0.5,
                ),
              ),
              child: Column(
                children: [
                  _buildInputRow('Batch Name', _batchNameController),
                  _buildDivider(),
                  _buildInputRow('Total Finished Weight (g)', _batchWeightController,
                      keyboardType: const TextInputType.numberWithOptions(
                          decimal: true)),
                  _buildDivider(),
                  _buildInputRow('Concentration (%)', _concentrationController,
                      keyboardType: const TextInputType.numberWithOptions(
                          decimal: true)),
                  _buildDivider(),
                  _buildInputRow('Distilled Water (%)', _waterController,
                      keyboardType: const TextInputType.numberWithOptions(
                          decimal: true)),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'BENCH SCALE WEIGH-IN RECIPE',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.secondaryLabel.resolveFrom(context),
              ),
            ),
            const SizedBox(height: 8),
            LiquidGlass(
              padding: const EdgeInsets.all(18),
              borderRadius: BorderRadius.circular(18),
              child: Column(
                children: [
                  _buildRecipeRow(
                    context,
                    label: 'Fragrance Oil (FO)',
                    grams: oilGrams,
                    percentage: concPercent,
                    color: CupertinoColors.systemPink,
                    icon: CupertinoIcons.drop_fill,
                  ),
                  const SizedBox(height: 12),
                  _buildRecipeRow(
                    context,
                    label: '96° Perfumer’s Alcohol',
                    grams: alcoholGrams,
                    percentage: (alcoholGrams / (totalGrams > 0 ? totalGrams : 1)) *
                        100.0,
                    color: CupertinoColors.systemIndigo,
                    icon: CupertinoIcons.flame_fill,
                  ),
                  const SizedBox(height: 12),
                  _buildRecipeRow(
                    context,
                    label: 'Distilled Water',
                    grams: waterGrams,
                    percentage: waterPercent,
                    color: CupertinoColors.systemTeal,
                    icon: CupertinoIcons.drop,
                  ),
                  const SizedBox(height: 14),
                  Container(
                    height: 0.5,
                    color: AppColors.separator.resolveFrom(context),
                  ),
                  const SizedBox(height: 14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Batch Weight',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.label.resolveFrom(context),
                        ),
                      ),
                      Text(
                        '${totalGrams.toStringAsFixed(2)} g',
                        style: AppTypography.precisionNumber(context, fontSize: 22),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: CupertinoButton.filled(
                borderRadius: BorderRadius.circular(14),
                onPressed: totalGrams > 0 ? _startMacerationBatch : null,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(CupertinoIcons.timer, size: 20),
                    SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        'Start Maceration (30d)',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildInputRow(String label, TextEditingController controller,
      {TextInputType? keyboardType}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 15,
              color: AppColors.label.resolveFrom(context),
            ),
          ),
          SizedBox(
            width: 140,
            child: CupertinoTextField(
              controller: controller,
              textAlign: TextAlign.end,
              keyboardType: keyboardType,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: AppColors.accent.resolveFrom(context),
              ),
              decoration: const BoxDecoration(),
              onChanged: (_) => setState(() {}),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 0.5,
      margin: const EdgeInsets.only(left: 16),
      color: AppColors.separator.resolveFrom(context),
    );
  }

  Widget _buildRecipeRow(
    BuildContext context, {
    required String label,
    required double grams,
    required double percentage,
    required Color color,
    required IconData icon,
  }) {
    return Row(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, size: 18, color: color),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: AppColors.label.resolveFrom(context),
                ),
              ),
              Text(
                '${percentage.toStringAsFixed(1)}% of total solution',
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.secondaryLabel.resolveFrom(context),
                ),
              ),
            ],
          ),
        ),
        Text(
          '${grams.toStringAsFixed(3)} g',
          style: AppTypography.precisionNumber(context, fontSize: 18),
        ),
      ],
    );
  }
}
