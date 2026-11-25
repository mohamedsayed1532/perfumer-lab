import 'package:cupertino_ui/cupertino_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:perfumery_lab/core/services/ifra_catalog_service.dart';
import 'package:perfumery_lab/core/services/ifra_safety_service.dart';
import 'package:perfumery_lab/core/theme/app_colors.dart';
import 'package:perfumery_lab/core/theme/app_typography.dart';
import 'package:perfumery_lab/core/theme/liquid_glass.dart';
import '../data/formulas_repository.dart';
import 'bench_compounding_screen.dart';
import 'create_formula_sheet.dart';
import 'formula_detail_screen.dart';

class FormulasListScreen extends ConsumerStatefulWidget {
  const FormulasListScreen({super.key});

  @override
  ConsumerState<FormulasListScreen> createState() => _FormulasListScreenState();
}

class _FormulasListScreenState extends ConsumerState<FormulasListScreen> {
  String _filter = 'all';

  @override
  Widget build(BuildContext context) {
    final formulasAsync = ref.watch(formulasWithItemsStreamProvider);
    final catalog = ref.watch(ifraCatalogProvider).value;

    return LiquidGlassBackground(
      child: CupertinoPageScaffold(
        backgroundColor: CupertinoColors.transparent,
        child: CustomScrollView(
          slivers: [
            CupertinoSliverNavigationBar(
              backgroundColor: AppColors.liquidGlassBg.resolveFrom(context),
              largeTitle: const Text('Formulas Lab'),
              trailing: CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () => _openCreateFormula(context),
                child: Icon(
                  CupertinoIcons.add,
                  size: 26,
                  color: AppColors.accent.resolveFrom(context),
                ),
              ),
            ),
            formulasAsync.when(
              data: (allFormulas) {
                if (allFormulas.isEmpty) {
                  return SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              CupertinoIcons.lab_flask,
                              size: 48,
                              color: AppColors.tertiaryLabel.resolveFrom(context),
                            ),
                            const SizedBox(height: 12),
                            Text('No Formulas Created Yet',
                                style: AppTypography.headline(context)),
                            const SizedBox(height: 6),
                            Text(
                              'Tap + to create your first fragrance formula.',
                              textAlign: TextAlign.center,
                              style: AppTypography.subheadline(context),
                            ),
                            const SizedBox(height: 20),
                            CupertinoButton.filled(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 12),
                              borderRadius: BorderRadius.circular(12),
                              onPressed: () => _openCreateFormula(context),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(CupertinoIcons.add,
                                      size: 18,
                                      color: AppColors.onAccent(context)),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Create Formula',
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
                      ),
                    ),
                  );
                }

                const ifraService = IfraSafetyService();
                int compliantCount = 0;
                for (final f in allFormulas) {
                  final eval = _evaluateIfra(ifraService, f, catalog);
                  if (eval.isCompliant) compliantCount++;
                }

                final filtered = allFormulas.where((data) {
                  final conc = data.formula.targetConcentrationPercent;
                  switch (_filter) {
                    case 'conc':
                      return conc >= 99.5;
                    case 'edp':
                      return conc >= 16.0 && conc < 99.5;
                    case 'edt':
                      return conc < 16.0;
                    case 'all':
                    default:
                      return true;
                  }
                }).toList();

                return SliverMainAxisGroup(
                  slivers: [
                    // Studio Telemetry Summary Strip
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                        child: LiquidGlass(
                          padding: const EdgeInsets.all(14),
                          borderRadius: BorderRadius.circular(14),
                          child: Row(
                            children: [
                              Expanded(
                                child: _buildTelemetryTile(
                                  context,
                                  label: 'Active Trials',
                                  value: '${allFormulas.length}',
                                  sub: 'formulations',
                                  valueColor: AppColors.label.resolveFrom(context),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: _buildTelemetryTile(
                                  context,
                                  label: 'IFRA 51st',
                                  value: '$compliantCount/${allFormulas.length}',
                                  sub: 'compliant',
                                  valueColor: AppColors.naturalGreen
                                      .resolveFrom(context),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: _buildTelemetryTile(
                                  context,
                                  label: 'Ready',
                                  value:
                                      '${allFormulas.where((f) => f.totalPpt >= 950).length}',
                                  sub: 'balanced',
                                  valueColor:
                                      AppColors.accentInk.resolveFrom(context),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Filter Segment Bar
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(16, 2, 16, 8),
                        child: SizedBox(
                          width: double.infinity,
                          child: CupertinoSlidingSegmentedControl<String>(
                            groupValue: _filter,
                            thumbColor: AppColors.accent.resolveFrom(context),
                            backgroundColor: AppColors
                                .secondarySystemGroupedBackground
                                .resolveFrom(context),
                            children: {
                              'all': _buildFilterTab(
                                  context, 'All (${allFormulas.length})', _filter == 'all'),
                              'conc': _buildFilterTab(
                                  context, 'Concentrate', _filter == 'conc'),
                              'edp': _buildFilterTab(
                                  context, 'EdP', _filter == 'edp'),
                              'edt': _buildFilterTab(
                                  context, 'EdT', _filter == 'edt'),
                            },
                            onValueChanged: (v) {
                              if (v != null) setState(() => _filter = v);
                            },
                          ),
                        ),
                      ),
                    ),

                    // Formula Cards
                    SliverPadding(
                      padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final data = filtered[index];
                            final eval = _evaluateIfra(ifraService, data, catalog);
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: _buildFormulaCard(
                                context,
                                data: data,
                                isCompliant: eval.isCompliant,
                              ),
                            );
                          },
                          childCount: filtered.length,
                        ),
                      ),
                    ),
                  ],
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

  IfraFormulaEvaluation _evaluateIfra(IfraSafetyService service,
      FormulaWithMaterials data, IfraCatalogData? catalog) {
    final inputs = data.items.map((i) {
      final std = catalog?.findStandardForMaterial(
        casNumber: i.material.casNumber,
        name: i.material.name,
      );
      final officialLimit = std?.numericLimitFor('Cat 4');
      final isProhibited = std?.type == 'PROHIBITION';
      return FormulaItemSafetyInput(
        id: i.item.id,
        name: i.material.name,
        partsPerThousand: i.item.partsPerThousand,
        specifiedDilutionPercent: i.item.specifiedDilutionPercent,
        idealMaxPercent: officialLimit ?? i.material.idealMaxPercent,
        isProhibited: isProhibited,
      );
    }).toList();
    return service.evaluateFormulaSafety(
      targetConcentrationPercent: data.formula.targetConcentrationPercent,
      items: inputs,
    );
  }

  Widget _buildTelemetryTile(
    BuildContext context, {
    required String label,
    required String value,
    required String sub,
    required Color valueColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
      decoration: BoxDecoration(
        color: AppColors.recessedWell.resolveFrom(context),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
            color: AppColors.cardBorder.resolveFrom(context), width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 11,
              color: AppColors.tertiaryLabel.resolveFrom(context),
            ),
          ),
          const SizedBox(height: 3),
          Text(
            value,
            style: AppTypography.precisionNumber(context, fontSize: 18)
                .copyWith(color: valueColor),
          ),
          Text(
            sub,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 10.5,
              color: AppColors.secondaryLabel.resolveFrom(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterTab(BuildContext context, String label, bool isSelected) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Text(
        label,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
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

  Widget _buildFormulaCard(
    BuildContext context, {
    required FormulaWithMaterials data,
    required bool isCompliant,
  }) {
    final formula = data.formula;
    final items = data.items;
    final totalPpt = data.totalPpt;

    double topPpt = 0;
    double heartPpt = 0;
    double basePpt = 0;
    for (final row in items) {
      final n = row.material.pyramidNote.toLowerCase().trim();
      if (n == 'top') {
        topPpt += row.item.partsPerThousand;
      } else if (n == 'heart' || n == 'middle') {
        heartPpt += row.item.partsPerThousand;
      } else {
        basePpt += row.item.partsPerThousand;
      }
    }
    final tPct = totalPpt > 0 ? (topPpt / totalPpt * 100).round() : 0;
    final hPct = totalPpt > 0 ? (heartPpt / totalPpt * 100).round() : 0;
    final bPct = totalPpt > 0 ? (basePpt / totalPpt * 100).round() : 0;

    final statusColor = isCompliant
        ? AppColors.naturalGreen.resolveFrom(context)
        : CupertinoColors.systemRed;

    final concText = formula.targetConcentrationPercent >= 99.5
        ? 'Pure Concentrate • 100%'
        : 'Eau de Parfum • ${formula.targetConcentrationPercent.toStringAsFixed(0)}%';

    return GestureDetector(
      onTap: () => _openDetail(context, formula.id),
      child: LiquidGlass(
        padding: const EdgeInsets.all(16),
        borderRadius: BorderRadius.circular(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title + Version + IFRA Status
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              formula.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTypography.atelierCardTitle(context,
                                  fontSize: 19),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: AppColors.recessedWell.resolveFrom(context),
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                  color: AppColors.cardBorder.resolveFrom(context),
                                  width: 0.5),
                            ),
                            child: Text(
                              formula.version.startsWith('v')
                                  ? formula.version
                                  : 'v${formula.version}',
                              style: AppTypography.monoData(
                                context,
                                fontSize: 10.5,
                                color: AppColors.accentInk.resolveFrom(context),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 3),
                      Text(
                        concText,
                        style: TextStyle(
                          fontSize: 13,
                          color: AppColors.secondaryLabel.resolveFrom(context),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: statusColor.withValues(alpha: 0.14),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: statusColor.withValues(alpha: 0.35),
                          width: 0.6,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            isCompliant
                                ? CupertinoIcons.checkmark_shield_fill
                                : CupertinoIcons.exclamationmark_triangle_fill,
                            size: 11,
                            color: statusColor,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            isCompliant ? 'IFRA 51 Pass' : 'IFRA Alert',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: statusColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '${totalPpt.toStringAsFixed(1)} ppt',
                      style: AppTypography.monoData(
                        context,
                        fontSize: 12,
                        color: AppColors.label.resolveFrom(context),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 14),

            // Volatility Profile Bar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Volatility profile',
                  style: TextStyle(
                    fontSize: 11.5,
                    color: AppColors.tertiaryLabel.resolveFrom(context),
                  ),
                ),
                Text(
                  '${tPct}T / ${hPct}H / ${bPct}B',
                  style: AppTypography.monoData(
                    context,
                    fontSize: 11,
                    color: AppColors.secondaryLabel.resolveFrom(context),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            ClipRRect(
              borderRadius: BorderRadius.circular(3),
              child: SizedBox(
                height: 6,
                child: totalPpt <= 0
                    ? Container(color: AppColors.recessedWell.resolveFrom(context))
                    : Row(
                        children: [
                          if (tPct > 0)
                            Expanded(
                              flex: tPct,
                              child: Container(
                                  color: AppColors.accent.resolveFrom(context)),
                            ),
                          if (hPct > 0)
                            Expanded(
                              flex: hPct,
                              child: Container(
                                  color: AppColors.secondaryLabel
                                      .resolveFrom(context)),
                            ),
                          if (bPct > 0)
                            Expanded(
                              flex: bPct,
                              child: Container(
                                  color: AppColors.naturalGreen
                                      .resolveFrom(context)),
                            ),
                        ],
                      ),
              ),
            ),

            const SizedBox(height: 12),

            // Footer Metadata + Quick Actions
            Row(
              children: [
                Icon(CupertinoIcons.lab_flask,
                    size: 13, color: AppColors.tertiaryLabel.resolveFrom(context)),
                const SizedBox(width: 5),
                Text(
                  '${items.length} ${items.length == 1 ? 'material' : 'materials'}',
                  style: AppTypography.monoData(context, fontSize: 11.5),
                ),
                const Spacer(),
                CupertinoButton(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                  minimumSize: Size.zero,
                  color: AppColors.tertiarySystemGroupedBackground
                      .resolveFrom(context),
                  borderRadius: BorderRadius.circular(8),
                  onPressed: () => _openDetail(context, formula.id),
                  child: Text(
                    'Inspector',
                    style: TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w600,
                      color: AppColors.label.resolveFrom(context),
                    ),
                  ),
                ),
                if (items.isNotEmpty) ...[
                  const SizedBox(width: 8),
                  CupertinoButton(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                    minimumSize: Size.zero,
                    color: AppColors.accent.resolveFrom(context),
                    borderRadius: BorderRadius.circular(8),
                    onPressed: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (_) =>
                              BenchCompoundingScreen(formulaWithMaterials: data),
                        ),
                      );
                    },
                    child: Text(
                      'Compound',
                      style: TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w600,
                        color: AppColors.onAccent(context),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _openDetail(BuildContext context, String formulaId) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (_) => FormulaDetailScreen(formulaId: formulaId),
      ),
    );
  }

  void _openCreateFormula(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (ctx) => const CreateFormulaSheet(),
    );
  }
}
