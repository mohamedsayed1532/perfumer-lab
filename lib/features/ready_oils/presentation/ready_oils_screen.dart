import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:drift/drift.dart' as drift;
import 'package:perfumery_lab/core/database/app_database.dart';
import 'package:perfumery_lab/core/theme/app_colors.dart';
import 'package:perfumery_lab/core/theme/app_typography.dart';
import 'package:perfumery_lab/core/theme/liquid_glass.dart';
import '../data/ready_oils_repository.dart';
import 'fo_dilution_calculator_sheet.dart';

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
              onPressed: () => _showCreateOilSheet(context, ref),
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
                                        color:
                                            AppColors.label.resolveFrom(context),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    '${oil.stockGrams.toStringAsFixed(1)} g',
                                    style: AppTypography.precisionNumber(context,
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
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
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

  void _showCreateOilSheet(BuildContext context, WidgetRef ref) {
    final nameController = TextEditingController();
    final supplierController = TextEditingController();
    final stockController = TextEditingController(text: '100.0');

    showCupertinoModalPopup(
      context: context,
      builder: (ctx) => CupertinoPageScaffold(
        backgroundColor:
            AppColors.systemGroupedBackground.resolveFrom(context),
        navigationBar: CupertinoNavigationBar(
          middle: Text('Add Fragrance Oil',
              style: AppTypography.headline(context)),
          leading: CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          trailing: CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () async {
              if (nameController.text.trim().isEmpty) return;
              final repo = ref.read(readyOilsRepositoryProvider);
              await repo.createOrUpdateReadyOil(
                ReadyOilsCompanion.insert(
                  id: const Uuid().v4(),
                  name: nameController.text.trim(),
                  supplier: drift.Value(supplierController.text.trim()),
                  stockGrams: drift.Value(
                      double.tryParse(stockController.text) ?? 100.0),
                ),
              );
              Navigator.pop(ctx);
            },
            child: const Text('Save',
                style: TextStyle(fontWeight: FontWeight.w600)),
          ),
        ),
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8, bottom: 8),
                child: Text(
                  'OIL DETAILS',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                    color: AppColors.secondaryLabel.resolveFrom(context),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.secondarySystemGroupedBackground
                      .resolveFrom(context),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(
                  children: [
                    _buildModalRow(
                      context,
                      'Oil Name *',
                      nameController,
                      placeholder: 'e.g. Aventus Type, Amber Vanilla FO',
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 16),
                      height: 0.5,
                      color: AppColors.separator.resolveFrom(context),
                    ),
                    _buildModalRow(
                      context,
                      'Supplier',
                      supplierController,
                      placeholder: 'e.g. Luzi, Expressions Parfumées',
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 16),
                      height: 0.5,
                      color: AppColors.separator.resolveFrom(context),
                    ),
                    _buildModalRow(
                      context,
                      'Stock (g)',
                      stockController,
                      placeholder: '100.0',
                      keyboardType: const TextInputType.numberWithOptions(
                          decimal: true),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  'Ready fragrance oils are pre-compounded concentrate blends ready for direct dilution with perfumer alcohol.',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.secondaryLabel.resolveFrom(context),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildModalRow(
    BuildContext context,
    String label,
    TextEditingController controller, {
    String? placeholder,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: AppColors.label.resolveFrom(context),
              ),
            ),
          ),
          Expanded(
            child: CupertinoTextField(
              controller: controller,
              placeholder: placeholder,
              placeholderStyle: TextStyle(
                color: AppColors.tertiaryLabel.resolveFrom(context),
                fontSize: 15,
              ),
              style: TextStyle(
                color: AppColors.label.resolveFrom(context),
                fontSize: 15,
              ),
              decoration: null,
              keyboardType: keyboardType,
            ),
          ),
        ],
      ),
    );
  }
}
