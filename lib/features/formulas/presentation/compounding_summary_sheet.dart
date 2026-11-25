import 'package:cupertino_ui/cupertino_ui.dart';
import 'package:share_plus/share_plus.dart';
import 'package:perfumery_lab/core/theme/app_colors.dart';
import 'package:perfumery_lab/core/theme/liquid_glass.dart';
import 'package:perfumery_lab/core/utils/haptics.dart';
import '../data/formulas_repository.dart';

class CompoundingSummarySheet extends StatelessWidget {
  final CompoundingExecutionResult result;
  final FormulaWithMaterials formulaData;

  const CompoundingSummarySheet({
    super.key,
    required this.result,
    required this.formulaData,
  });

  @override
  Widget build(BuildContext context) {
    return LiquidGlassBackground(
      child: CupertinoPopupSurface(
        child: SafeArea(
          top: false,
          child: Container(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.85,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Grabber & Title
                Center(
                  child: Container(
                    width: 36,
                    height: 4,
                    decoration: BoxDecoration(
                      color: AppColors.tertiaryLabel.resolveFrom(context),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 14),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: CupertinoColors.systemGreen
                                .withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            CupertinoIcons.checkmark_alt,
                            color: CupertinoColors.systemGreen,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Compounding Complete',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              'Batch ${result.batchNumber}',
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.secondaryLabel
                                    .resolveFrom(context),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      child: const Text('Done'),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Metrics highlight card
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: const Color(0x1AFFFFFF),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: const Color(0x2AFFFFFF),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildMetric(
                        context,
                        label: 'YIELD WEIGHED',
                        value: '${result.totalWeighedGrams.toStringAsFixed(2)} g',
                      ),
                      Container(
                        width: 1,
                        height: 30,
                        color: const Color(0x2AFFFFFF),
                      ),
                      _buildMetric(
                        context,
                        label: 'AGING STAGE',
                        value: 'Maturation (14d)',
                      ),
                      Container(
                        width: 1,
                        height: 30,
                        color: const Color(0x2AFFFFFF),
                      ),
                      _buildMetric(
                        context,
                        label: 'INVENTORY',
                        value: '${result.itemResults.length} Deducted',
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                Text(
                  'STOCK DEDUCTION SUMMARY',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                    color: AppColors.secondaryLabel.resolveFrom(context),
                  ),
                ),
                const SizedBox(height: 8),

                // Deducted Items List
                Flexible(
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: result.itemResults.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 8),
                    itemBuilder: (ctx, index) {
                      final item = result.itemResults[index];
                      final isLow = item.remainingStockGrams < 10.0 &&
                          item.remainingStockGrams >= 0.0;
                      final isDeficit = item.remainingStockGrams < 0.0;

                      return Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 10),
                        decoration: BoxDecoration(
                          color: const Color(0x12FFFFFF),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isDeficit
                                ? const Color(0x4DFF3B30)
                                : isLow
                                    ? const Color(0x4DFF9500)
                                    : const Color(0x1FFFFFFF),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.materialName,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    'Deducted: ${item.weighedGrams.toStringAsFixed(3)} g',
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
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  '${item.remainingStockGrams.toStringAsFixed(1)} g left',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: isDeficit
                                        ? CupertinoColors.systemRed
                                        : isLow
                                            ? CupertinoColors.systemOrange
                                            : AppColors.label
                                                .resolveFrom(context),
                                  ),
                                ),
                                if (isDeficit)
                                  const Text(
                                    'Depleted Deficit',
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                      color: CupertinoColors.systemRed,
                                    ),
                                  )
                                else if (isLow)
                                  const Text(
                                    'Low Stock Alert',
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                      color: CupertinoColors.systemOrange,
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 16),

                // Primary Action: Export Lab Binder Worksheet
                CupertinoButton.filled(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  borderRadius: BorderRadius.circular(14),
                  onPressed: () async {
                    await LabHaptics.selection();
                    await _exportBatchWorksheet();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(CupertinoIcons.square_arrow_up,
                          size: 18, color: AppColors.onAccent(context)),
                      const SizedBox(width: 8),
                      Text(
                        'Export Lab Batch Sheet (Print / Share)',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: AppColors.onAccent(context),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMetric(BuildContext context,
      {required String label, required String value}) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 9,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
            color: AppColors.secondaryLabel.resolveFrom(context),
          ),
        ),
        const SizedBox(height: 3),
        Text(
          value,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  Future<void> _exportBatchWorksheet() async {
    final buffer = StringBuffer();
    final now = DateTime.now();
    final dateStr =
        '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';

    buffer.writeln('====================================================');
    buffer.writeln('       PERFUMERY LABORATORY - COMPOUNDING SHEET     ');
    buffer.writeln('====================================================');
    buffer.writeln('Batch Number : ${result.batchNumber}');
    buffer.writeln('Formula Name : ${formulaData.formula.name} (${formulaData.formula.version})');
    buffer.writeln('Date & Time  : $dateStr ${now.hour}:${now.minute.toString().padLeft(2, '0')}');
    buffer.writeln('Total Yield  : ${result.totalWeighedGrams.toStringAsFixed(3)} g');
    buffer.writeln('Stage        : Concentrate Maturation (14 Days Target)');
    buffer.writeln('----------------------------------------------------');
    buffer.writeln('DISPENSED RAW MATERIALS (SCALE RECORD):');
    buffer.writeln('');

    int idx = 1;
    for (final item in result.itemResults) {
      buffer.writeln(
        '${idx.toString().padLeft(2, '0')}. [X] ${item.materialName.padRight(28)} : ${item.weighedGrams.toStringAsFixed(3)} g (Remaining: ${item.remainingStockGrams.toStringAsFixed(1)} g)',
      );
      idx++;
    }

    buffer.writeln('');
    buffer.writeln('----------------------------------------------------');
    buffer.writeln('OPERATIONAL NOTES & LAB VERIFICATION:');
    buffer.writeln('Scale Model / Tolerance : 0.001 g Laboratory Balance');
    buffer.writeln('Storage Vessel          : Amber Glass Flacon');
    buffer.writeln('Compounded By           : ___________________________');
    buffer.writeln('Verification Sign-off   : ___________________________');
    buffer.writeln('====================================================');

    await SharePlus.instance.share(
      ShareParams(
        text: buffer.toString(),
        subject: 'Batch Worksheet - ${result.batchNumber}',
      ),
    );
  }
}
