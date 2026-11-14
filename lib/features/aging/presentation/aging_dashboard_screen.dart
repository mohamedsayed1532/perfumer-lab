import 'package:cupertino_ui/cupertino_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:perfumery_lab/core/database/app_database.dart';
import 'package:perfumery_lab/core/theme/app_colors.dart';
import 'package:perfumery_lab/core/theme/app_typography.dart';
import 'package:perfumery_lab/core/theme/liquid_glass.dart';
import '../data/aging_repository.dart';
import 'add_evaluation_sheet.dart';

class AgingDashboardScreen extends ConsumerStatefulWidget {
  const AgingDashboardScreen({super.key});

  @override
  ConsumerState<AgingDashboardScreen> createState() =>
      _AgingDashboardScreenState();
}

class _AgingDashboardScreenState extends ConsumerState<AgingDashboardScreen> {
  String _selectedStage = 'all'; // 'all', 'maturation', 'maceration'

  @override
  Widget build(BuildContext context) {
    final batchesAsync = ref.watch(activeAgingBatchesStreamProvider);

    return CupertinoPageScaffold(
      backgroundColor: AppColors.systemGroupedBackground.resolveFrom(context),
      navigationBar: CupertinoNavigationBar(
        middle: Text('Aging & Batches', style: AppTypography.headline(context)),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: SizedBox(
                width: double.infinity,
                child: CupertinoSegmentedControl<String>(
                  groupValue: _selectedStage,
                  selectedColor: AppColors.accent.resolveFrom(context),
                  unselectedColor: CupertinoColors.transparent,
                  borderColor: AppColors.separator.resolveFrom(context),
                  children: const {
                    'all': Padding(
                      padding: EdgeInsets.symmetric(vertical: 6),
                      child: Text('All Batches'),
                    ),
                    'maturation': Padding(
                      padding: EdgeInsets.symmetric(vertical: 6),
                      child: Text('Maturation (Oils)'),
                    ),
                    'maceration': Padding(
                      padding: EdgeInsets.symmetric(vertical: 6),
                      child: Text('Maceration (Perfumes)'),
                    ),
                  },
                  onValueChanged: (val) => setState(() => _selectedStage = val),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: batchesAsync.when(
                data: (batches) {
                  final filtered = batches.where((b) {
                    if (_selectedStage == 'all') return true;
                    return b.stage.toLowerCase() == _selectedStage;
                  }).toList();

                  if (filtered.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            CupertinoIcons.hourglass,
                            size: 48,
                            color: AppColors.tertiaryLabel.resolveFrom(context),
                          ),
                          const SizedBox(height: 12),
                          Text('No Active Aging Batches',
                              style: AppTypography.headline(context)),
                          const SizedBox(height: 6),
                          Text(
                            'Compound a formula or dilute an FO to start tracking aging.',
                            style: AppTypography.subheadline(context),
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: filtered.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 14),
                    itemBuilder: (context, index) {
                      final batch = filtered[index];
                      return _buildBatchCard(context, batch);
                    },
                  );
                },
                loading: () =>
                    const Center(child: CupertinoActivityIndicator()),
                error: (err, _) => Center(child: Text('Error: $err')),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBatchCard(BuildContext context, AgingBatche batch) {
    final daysElapsed = DateTime.now().difference(batch.startDate).inDays;
    final targetDays = batch.targetAgingDays;
    final progress = (targetDays > 0)
        ? (daysElapsed / targetDays).clamp(0.0, 1.0)
        : 1.0;
    final isMaturation = batch.stage == 'maturation';

    return LiquidGlass(
      padding: const EdgeInsets.all(16),
      borderRadius: BorderRadius.circular(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: isMaturation
                      ? CupertinoColors.systemPurple.withValues(alpha: 0.18)
                      : CupertinoColors.systemTeal.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  isMaturation
                      ? 'MATURATION (OIL)'
                      : 'MACERATION (PERFUME)',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: isMaturation
                        ? CupertinoColors.systemPurple
                        : CupertinoColors.systemTeal,
                  ),
                ),
              ),
              Text(
                batch.batchNumber,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.secondaryLabel.resolveFrom(context),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            batch.name,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.label.resolveFrom(context),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Batch: ${batch.totalWeightGrams.toStringAsFixed(1)}g • Concentration: ${batch.concentrationPercent.toStringAsFixed(0)}%',
            style: TextStyle(
              fontSize: 13,
              color: AppColors.secondaryLabel.resolveFrom(context),
            ),
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Day $daysElapsed of $targetDays',
                style: AppTypography.precisionNumber(context, fontSize: 16),
              ),
              Text(
                daysElapsed >= targetDays
                    ? 'Maturity Target Reached!'
                    : '${targetDays - daysElapsed} days remaining',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: daysElapsed >= targetDays
                      ? CupertinoColors.systemGreen
                      : AppColors.accent.resolveFrom(context),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Container(
              height: 6,
              color: AppColors.separator.resolveFrom(context),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: progress,
                child: Container(
                  color: progress >= 1.0
                      ? CupertinoColors.systemGreen
                      : AppColors.accent.resolveFrom(context),
                ),
              ),
            ),
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CupertinoButton(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                color: AppColors.secondarySystemGroupedBackground
                    .resolveFrom(context),
                borderRadius: BorderRadius.circular(10),
                onPressed: () {
                  showCupertinoModalPopup(
                    context: context,
                    builder: (ctx) => AddEvaluationSheet(batch: batch),
                  );
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      CupertinoIcons.pencil_ellipsis_rectangle,
                      size: 15,
                      color: AppColors.accent.resolveFrom(context),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'Log Sensory Check',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.accent.resolveFrom(context),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
