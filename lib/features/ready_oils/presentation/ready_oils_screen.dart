import 'package:cupertino_ui/cupertino_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:perfumery_lab/core/database/app_database.dart';
import 'package:perfumery_lab/core/theme/app_colors.dart';
import 'package:perfumery_lab/core/theme/app_typography.dart';
import 'package:perfumery_lab/core/theme/liquid_glass.dart';
import '../data/ready_oils_repository.dart';
import 'fo_dilution_calculator_sheet.dart';
import 'create_or_edit_ready_oil_sheet.dart';

class ReadyOilsScreen extends ConsumerWidget {
  const ReadyOilsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final readyOilsAsync = ref.watch(readyOilsStreamProvider);

    return CupertinoPageScaffold(
      backgroundColor: AppColors.systemGroupedBackground.resolveFrom(context),
      child: CustomScrollView(
        slivers: [
          CupertinoSliverNavigationBar(
            largeTitle: const Text('Ready Fragrance Oils'),
            trailing: CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () => _openSheet(context),
              child: const Icon(CupertinoIcons.add, size: 26),
            ),
          ),
          readyOilsAsync.when(
            data: (oils) {
              if (oils.isEmpty) {
                return SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          CupertinoIcons.drop,
                          size: 48,
                          color: AppColors.tertiaryLabel.resolveFrom(context),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'No Fragrance Oils Yet',
                          style: AppTypography.headline(context),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Tap + to add your supplier fragrance oils.',
                          style: AppTypography.subheadline(context),
                        ),
                        const SizedBox(height: 16),
                        CupertinoButton.filled(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          borderRadius: BorderRadius.circular(12),
                          onPressed: () => _openSheet(context),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(CupertinoIcons.add,
                                  size: 18, color: CupertinoColors.white),
                              SizedBox(width: 6),
                              Text(
                                'Add Fragrance Oil',
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
                  ),
                );
              }

              return SliverPadding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final oil = oils[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: GestureDetector(
                          onTap: () => _openSheet(context, existing: oil),
                          child: LiquidGlass(
                            padding: const EdgeInsets.all(16),
                            borderRadius: BorderRadius.circular(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        oil.name,
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.label
                                              .resolveFrom(context),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      '${oil.stockGrams.toStringAsFixed(1)} g',
                                      style: AppTypography.precisionNumber(
                                          context,
                                          fontSize: 17),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Supplier: ${oil.supplier ?? "Generic"} • Lot: ${oil.lotNumber ?? "N/A"}',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: AppColors.secondaryLabel
                                        .resolveFrom(context),
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CupertinoButton(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 6),
                                      color: AppColors
                                          .secondarySystemGroupedBackground
                                          .resolveFrom(context),
                                      borderRadius: BorderRadius.circular(8),
                                      onPressed: () =>
                                          _openSheet(context, existing: oil),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            CupertinoIcons.pencil,
                                            size: 14,
                                            color: AppColors.accent
                                                .resolveFrom(context),
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            'Edit',
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.accent
                                                  .resolveFrom(context),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    CupertinoButton(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 14, vertical: 8),
                                      color:
                                          AppColors.accent.resolveFrom(context),
                                      borderRadius: BorderRadius.circular(10),
                                      onPressed: () {
                                        showCupertinoModalPopup(
                                          context: context,
                                          builder: (ctx) =>
                                              FoDilutionCalculatorSheet(
                                                  selectedOil: oil),
                                        );
                                      },
                                      child: const Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            CupertinoIcons.flame_fill,
                                            size: 14,
                                            color: CupertinoColors.white,
                                          ),
                                          SizedBox(width: 6),
                                          Text(
                                            'Dilute & Bottle (EdP)',
                                            style: TextStyle(
                                              fontSize: 13,
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
                      );
                    },
                    childCount: oils.length,
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

  void _openSheet(BuildContext context, {ReadyOil? existing}) {
    showCupertinoModalPopup(
      context: context,
      builder: (ctx) => CreateOrEditReadyOilSheet(existing: existing),
    );
  }
}
