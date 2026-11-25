import 'package:cupertino_ui/cupertino_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:perfumery_lab/core/database/app_database.dart';
import 'package:perfumery_lab/core/theme/app_colors.dart';
import 'package:perfumery_lab/core/theme/app_typography.dart';
import 'package:perfumery_lab/core/theme/liquid_glass.dart';
import '../data/aging_repository.dart';
import 'add_evaluation_sheet.dart';
import 'edit_aging_batch_sheet.dart';

class AgingDashboardScreen extends ConsumerStatefulWidget {
  const AgingDashboardScreen({super.key});

  @override
  ConsumerState<AgingDashboardScreen> createState() =>
      _AgingDashboardScreenState();
}

class _AgingDashboardScreenState extends ConsumerState<AgingDashboardScreen> {
  String _selectedStage = 'all';

  @override
  Widget build(BuildContext context) {
    final batchesAsync = ref.watch(activeAgingBatchesStreamProvider);

    return LiquidGlassBackground(
      child: CupertinoPageScaffold(
        backgroundColor: CupertinoColors.transparent,
        child: CustomScrollView(
          slivers: [
            CupertinoSliverNavigationBar(
              backgroundColor: AppColors.liquidGlassBg.resolveFrom(context),
              largeTitle: const Text('Aging & Batches'),
            ),
          SliverToBoxAdapter(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: SizedBox(
                width: double.infinity,
                child: CupertinoSlidingSegmentedControl<String>(
                  groupValue: _selectedStage,
                  thumbColor: AppColors.accent.resolveFrom(context),
                  backgroundColor: AppColors.secondarySystemGroupedBackground
                      .resolveFrom(context),
                  children: {
                    'all': _buildSegmentLabel('All', _selectedStage == 'all'),
                    'maturation': _buildSegmentLabel(
                        'Maturation', _selectedStage == 'maturation'),
                    'maceration': _buildSegmentLabel(
                        'Maceration', _selectedStage == 'maceration'),
                  },
                  onValueChanged: (val) {
                    if (val != null) setState(() => _selectedStage = val);
                  },
                ),
              ),
            ),
          ),
          batchesAsync.when(
            data: (batches) {
              final filtered = batches.where((b) {
                if (_selectedStage == 'all') return true;
                return b.stage.toLowerCase() == _selectedStage;
              }).toList();

              if (filtered.isEmpty) {
                return SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
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
                  ),
                );
              }

              return SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final batch = filtered[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 14),
                        child: _buildBatchCard(context, batch),
                      );
                    },
                    childCount: filtered.length,
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

  Widget _buildSegmentLabel(String text, bool isSelected) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 13,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
          color: isSelected
              ? AppColors.onAccent(context)
              : AppColors.label.resolveFrom(context),
        ),
      ),
    );
  }

  Widget _buildBatchCard(BuildContext context, AgingBatche batch) {
    final daysElapsed = DateTime.now().difference(batch.startDate).inDays;
    final targetDays = batch.targetAgingDays;
    final progress =
        (targetDays > 0) ? (daysElapsed / targetDays).clamp(0.0, 1.0) : 1.0;
    final isMaturation = batch.stage == 'maturation';
    final stageColor = isMaturation
        ? AppColors.naturalGreen.resolveFrom(context)
        : AppColors.accent.resolveFrom(context);

    return GestureDetector(
      onTap: () => _openEditSheet(context, batch),
      child: LiquidGlass(
        padding: const EdgeInsets.all(16),
        borderRadius: BorderRadius.circular(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 7,
                      height: 7,
                      decoration: BoxDecoration(
                        color: stageColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 7),
                    Text(
                      isMaturation
                          ? 'Maturation • Oil'
                          : 'Maceration • Perfume',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: stageColor,
                      ),
                    ),
                  ],
                ),
                Text(
                  batch.batchNumber,
                  style: TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.3,
                    color: AppColors.secondaryLabel.resolveFrom(context),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              batch.name,
              style: AppTypography.atelierCardTitle(context, fontSize: 18),
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
                width: double.infinity,
                height: 6,
                color: AppColors.cardBorder.resolveFrom(context),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: progress,
                  child: Container(
                    decoration: BoxDecoration(
                      color: progress >= 1.0
                          ? AppColors.naturalGreen.resolveFrom(context)
                          : stageColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 14),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.accent.resolveFrom(context).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: AppColors.accent.resolveFrom(context).withValues(alpha: 0.22),
                      width: 0.5,
                    ),
                  ),
                  child: CupertinoButton(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                    minimumSize: Size.zero,
                    onPressed: () => _openEditSheet(context, batch),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          CupertinoIcons.pencil,
                          size: 14,
                          color: AppColors.accent.resolveFrom(context),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          'Edit Batch',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppColors.accent.resolveFrom(context),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.accent.resolveFrom(context).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: AppColors.accent.resolveFrom(context).withValues(alpha: 0.22),
                      width: 0.5,
                    ),
                  ),
                  child: CupertinoButton(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                    minimumSize: Size.zero,
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
                          size: 14,
                          color: AppColors.accent.resolveFrom(context),
                        ),
                        const SizedBox(width: 5),
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
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _openEditSheet(BuildContext context, AgingBatche batch) {
    showCupertinoModalPopup(
      context: context,
      builder: (ctx) => EditAgingBatchSheet(batch: batch),
    );
  }
}
