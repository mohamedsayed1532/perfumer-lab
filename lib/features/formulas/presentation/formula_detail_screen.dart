import 'package:cupertino_ui/cupertino_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:perfumery_lab/core/database/app_database.dart';
import 'package:perfumery_lab/core/theme/app_colors.dart';
import 'package:perfumery_lab/core/theme/app_typography.dart';
import 'package:perfumery_lab/core/theme/liquid_glass.dart';
import 'package:perfumery_lab/features/materials/data/materials_repository.dart';
import '../data/formulas_repository.dart';
import 'bench_compounding_screen.dart';

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

        return CupertinoPageScaffold(
          backgroundColor:
              AppColors.systemGroupedBackground.resolveFrom(context),
          navigationBar: CupertinoNavigationBar(
            middle: Text(formula.name, style: AppTypography.headline(context)),
            trailing: CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () => _showAddItemSheet(context, ref, formula.id),
              child: const Icon(CupertinoIcons.add_circled_solid, size: 28),
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                // Top Summary Card
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: LiquidGlass(
                    padding: const EdgeInsets.all(16),
                    borderRadius: BorderRadius.circular(18),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'FORMULA TOTAL',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.secondaryLabel
                                        .resolveFrom(context),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${totalPpt.toStringAsFixed(1)} / 1000 ppt',
                                  style: AppTypography.precisionNumber(context,
                                      fontSize: 22),
                                ),
                              ],
                            ),
                            CupertinoButton.filled(
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
                                children: [
                                  Icon(CupertinoIcons.circle_grid_hex_fill,
                                      size: 16),
                                  SizedBox(width: 6),
                                  Text(
                                    'Compound',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
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
                Expanded(
                  child: items.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                CupertinoIcons.list_bullet_indent,
                                size: 48,
                                color:
                                    AppColors.tertiaryLabel.resolveFrom(context),
                              ),
                              const SizedBox(height: 12),
                              Text('No Ingredients Added Yet',
                                  style: AppTypography.headline(context)),
                              const SizedBox(height: 4),
                              Text('Tap + in top bar to add aroma chemicals.',
                                  style: AppTypography.subheadline(context)),
                            ],
                          ),
                        )
                      : ListView.separated(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: items.length,
                          separatorBuilder: (_, _) =>
                              const SizedBox(height: 10),
                          itemBuilder: (context, index) {
                            final row = items[index];
                            final mat = row.material;
                            final item = row.item;

                            return LiquidGlass(
                              padding: const EdgeInsets.all(14),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        mat.name,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.label
                                              .resolveFrom(context),
                                        ),
                                      ),
                                      const SizedBox(height: 3),
                                      Text(
                                        '${mat.pyramidNote.toUpperCase()} • ${item.specifiedDilutionPercent.toStringAsFixed(0)}% dilution',
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: AppColors.secondaryLabel
                                              .resolveFrom(context),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    '${item.partsPerThousand.toStringAsFixed(1)} ppt',
                                    style: AppTypography.precisionNumber(context,
                                        fontSize: 18),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showAddItemSheet(
      BuildContext context, WidgetRef ref, String formulaId) async {
    final materialsRepo = ref.read(materialsRepositoryProvider);
    final materials = await materialsRepo.watchAllMaterials().first;

    if (materials.isEmpty) {
      showCupertinoDialog(
        context: context,
        builder: (ctx) => CupertinoAlertDialog(
          title: const Text('No Materials Available'),
          content: const Text(
              'Please add at least one material to your Materials catalog before adding to formulas.'),
          actions: [
            CupertinoDialogAction(
              child: const Text('OK'),
              onPressed: () => Navigator.pop(ctx),
            ),
          ],
        ),
      );
      return;
    }

    String selectedMaterialId = materials.first.id;
    final pptController = TextEditingController(text: '10.0');

    showCupertinoModalPopup(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setState) {
          return CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              middle: const Text('Add Ingredient'),
              leading: CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () => Navigator.pop(ctx),
                child: const Text('Cancel'),
              ),
              trailing: CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () async {
                  final ppt = double.tryParse(pptController.text) ?? 10.0;
                  final repo = ref.read(formulasRepositoryProvider);
                  await repo.addOrUpdateItem(
                    FormulaItemsCompanion.insert(
                      id: const Uuid().v4(),
                      formulaId: formulaId,
                      materialId: selectedMaterialId,
                      partsPerThousand: ppt,
                    ),
                  );
                  Navigator.pop(ctx);
                },
                child: const Text('Add'),
              ),
            ),
            child: SafeArea(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  const Text('Select Material:'),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 180,
                    child: CupertinoPicker(
                      itemExtent: 36,
                      onSelectedItemChanged: (index) {
                        setState(
                            () => selectedMaterialId = materials[index].id);
                      },
                      children: materials.map((m) => Text(m.name)).toList(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  CupertinoTextField(
                    controller: pptController,
                    placeholder: 'Parts per Thousand (ppt)',
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    padding: const EdgeInsets.all(14),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
