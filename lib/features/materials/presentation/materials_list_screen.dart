import 'package:cupertino_ui/cupertino_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:perfumery_lab/core/database/app_database.dart';
import 'package:perfumery_lab/core/theme/app_colors.dart';
import 'package:perfumery_lab/core/theme/app_typography.dart';
import 'package:perfumery_lab/core/theme/liquid_glass.dart';
import '../data/materials_repository.dart';
import 'create_material_sheet.dart';
import 'material_detail_sheet.dart';

class MaterialsListScreen extends ConsumerStatefulWidget {
  const MaterialsListScreen({super.key});

  @override
  ConsumerState<MaterialsListScreen> createState() =>
      _MaterialsListScreenState();
}

class _MaterialsListScreenState extends ConsumerState<MaterialsListScreen> {
  String _searchQuery = '';
  String _selectedFilter = 'all';
  late final FocusNode _searchFocusNode;

  @override
  void initState() {
    super.initState();
    _searchFocusNode = FocusNode();
    _searchFocusNode.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final materialsAsync = ref.watch(materialsStreamProvider);

    return LiquidGlassBackground(
      child: CupertinoPageScaffold(
        backgroundColor: CupertinoColors.transparent,
        child: CustomScrollView(
          slivers: [
            CupertinoSliverNavigationBar(
              backgroundColor: AppColors.liquidGlassBg.resolveFrom(context),
              largeTitle: const Text('Raw Materials'),
              trailing: CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  showCupertinoModalPopup(
                    context: context,
                    builder: (ctx) => const CreateMaterialSheet(),
                  );
                },
                child: Icon(
                  CupertinoIcons.add,
                  size: 26,
                  color: AppColors.accent.resolveFrom(context),
                ),
              ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: CupertinoSearchTextField(
                focusNode: _searchFocusNode,
                placeholder: 'Search raw materials',
                placeholderStyle: TextStyle(
                  color: AppColors.tertiaryLabel.resolveFrom(context),
                  fontSize: 14.5,
                ),
                style: TextStyle(
                  color: AppColors.label.resolveFrom(context),
                  fontSize: 14.5,
                ),
                itemColor: AppColors.accent.resolveFrom(context),
                cursorColor: AppColors.accent.resolveFrom(context),
                decoration: BoxDecoration(
                  color: AppColors.secondarySystemGroupedBackground
                      .resolveFrom(context),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: _searchFocusNode.hasFocus
                        ? AppColors.accent.resolveFrom(context)
                        : AppColors.cardBorder.resolveFrom(context),
                    width: _searchFocusNode.hasFocus ? 1.25 : 0.75,
                  ),
                ),
                padding: const EdgeInsetsDirectional.fromSTEB(6, 10, 6, 10),
                prefixInsets:
                    const EdgeInsetsDirectional.fromSTEB(10, 10, 6, 10),
                onChanged: (val) =>
                    setState(() => _searchQuery = val.toLowerCase()),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              child: SizedBox(
                width: double.infinity,
                child: CupertinoSlidingSegmentedControl<String>(
                  groupValue: _selectedFilter,
                  thumbColor: AppColors.accent.resolveFrom(context),
                  backgroundColor: AppColors.secondarySystemGroupedBackground
                      .resolveFrom(context),
                  children: {
                    'all': _buildSegmentLabel('All', _selectedFilter == 'all'),
                    'top': _buildSegmentLabel('Top', _selectedFilter == 'top'),
                    'heart':
                        _buildSegmentLabel('Heart', _selectedFilter == 'heart'),
                    'base':
                        _buildSegmentLabel('Base', _selectedFilter == 'base'),
                  },
                  onValueChanged: (val) {
                    if (val != null) setState(() => _selectedFilter = val);
                  },
                ),
              ),
            ),
          ),
          materialsAsync.when(
            data: (materials) {
              final lowStockCount =
                  materials.where((m) => m.stockGrams <= 0.5).length;
              final inStockCount = materials.length - lowStockCount;
              final filtered = materials.where((m) {
                final matchesQuery = _searchQuery.isEmpty ||
                    m.name.toLowerCase().contains(_searchQuery) ||
                    (m.casNumber?.toLowerCase().contains(_searchQuery) ?? false) ||
                    (m.botanicalName?.toLowerCase().contains(_searchQuery) ??
                        false);
                final matchesFilter = _selectedFilter == 'all' ||
                    m.pyramidNote.toLowerCase() == _selectedFilter;
                return matchesQuery && matchesFilter;
              }).toList();

              if (filtered.isEmpty) {
                return SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          CupertinoIcons.square_stack_3d_up_slash,
                          size: 48,
                          color: AppColors.tertiaryLabel.resolveFrom(context),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          materials.isEmpty
                              ? 'No Raw Materials Yet'
                              : 'No Matching Materials',
                          style: AppTypography.headline(context),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          materials.isEmpty
                              ? 'Tap + to catalog your first aroma chemical.'
                              : 'Try adjusting your search or filter.',
                          style: AppTypography.subheadline(context),
                        ),
                      ],
                    ),
                  ),
                );
              }

              return SliverMainAxisGroup(
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 4, 16, 6),
                      child: LiquidGlass(
                        padding: const EdgeInsets.all(12),
                        borderRadius: BorderRadius.circular(14),
                        child: Row(
                          children: [
                            Expanded(
                              child: _buildOrganStatTile(
                                context,
                                label: 'Vessels',
                                value: '${materials.length}',
                                color: AppColors.label.resolveFrom(context),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: _buildOrganStatTile(
                                context,
                                label: 'In stock',
                                value: '$inStockCount',
                                color:
                                    AppColors.naturalGreen.resolveFrom(context),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: _buildOrganStatTile(
                                context,
                                label: 'Low stock',
                                value: '$lowStockCount',
                                color: lowStockCount > 0
                                    ? CupertinoColors.systemRed
                                    : AppColors.secondaryLabel
                                        .resolveFrom(context),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final item = filtered[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: _buildMaterialCard(context, item),
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

  Widget _buildOrganStatTile(
    BuildContext context, {
    required String label,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
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
            style: TextStyle(
              fontSize: 11,
              color: AppColors.tertiaryLabel.resolveFrom(context),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: AppTypography.precisionNumber(context, fontSize: 17)
                .copyWith(color: color),
          ),
        ],
      ),
    );
  }

  Widget _buildMaterialCard(BuildContext context, Material item) {
    IconData noteIcon;
    Color noteColor;
    String noteTitle;
    switch (item.pyramidNote.toLowerCase()) {
      case 'top':
        noteIcon = CupertinoIcons.sparkles;
        noteColor = AppColors.accent.resolveFrom(context);
        noteTitle = 'Top note';
        break;
      case 'heart':
        noteIcon = CupertinoIcons.heart_fill;
        noteColor = AppColors.naturalGreen.resolveFrom(context);
        noteTitle = 'Heart note';
        break;
      case 'base':
      default:
        noteIcon = CupertinoIcons.shield_fill;
        noteColor = AppColors.secondaryLabel.resolveFrom(context);
        noteTitle = 'Base note';
        break;
    }

    final solventName = item.defaultSolvent?.split(' ')[0] ?? 'Neat';

    return GestureDetector(
      onTap: () {
        showCupertinoModalPopup(
          context: context,
          builder: (ctx) => MaterialDetailSheet(material: item),
        );
      },
      child: LiquidGlass(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
        borderRadius: BorderRadius.circular(16),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: noteColor.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: noteColor.withValues(alpha: 0.28),
                  width: 0.75,
                ),
              ),
              child: Center(
                child: Icon(noteIcon, size: 16, color: noteColor),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.atelierCardTitle(context, fontSize: 16),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    '$noteTitle • ${item.dilutionPercent.toStringAsFixed(0)}% in $solventName',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w400,
                      color: AppColors.secondaryLabel.resolveFrom(context),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${item.stockGrams.toStringAsFixed(1)} g',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      fontFeatures: const [FontFeature.tabularFigures()],
                      color: item.stockGrams > 0
                          ? AppColors.label.resolveFrom(context)
                          : AppColors.tertiaryLabel.resolveFrom(context),
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    item.casNumber != null && item.casNumber!.isNotEmpty
                        ? item.casNumber!
                        : '—',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.2,
                      fontFamily: 'monospace',
                      fontFeatures: const [FontFeature.tabularFigures()],
                      color: AppColors.tertiaryLabel.resolveFrom(context),
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
}
