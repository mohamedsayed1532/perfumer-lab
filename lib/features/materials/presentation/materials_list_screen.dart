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
                child: const Icon(
                  CupertinoIcons.add,
                  size: 26,
                  color: CupertinoColors.activeBlue,
                ),
              ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: CupertinoSearchTextField(
                placeholder: 'Search by material, CAS, botanical...',
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

              return SliverPadding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 13,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
          color: isSelected
              ? CupertinoColors.white
              : AppColors.label.resolveFrom(context),
        ),
      ),
    );
  }

  Widget _buildMaterialCard(BuildContext context, Material item) {
    // Pyramid note identity — icon + color per note classification
    IconData noteIcon;
    Color noteColor;
    String noteLabel;
    switch (item.pyramidNote.toLowerCase()) {
      case 'top':
        noteIcon = CupertinoIcons.triangle;
        noteColor = CupertinoColors.systemYellow;
        noteLabel = 'T';
        break;
      case 'heart':
        noteIcon = CupertinoIcons.heart_fill;
        noteColor = CupertinoColors.systemPink;
        noteLabel = 'H';
        break;
      case 'base':
      default:
        noteIcon = CupertinoIcons.triangle_fill;
        noteColor = CupertinoColors.systemPurple;
        noteLabel = 'B';
        break;
    }

    return GestureDetector(
      onTap: () {
        showCupertinoModalPopup(
          context: context,
          builder: (ctx) => MaterialDetailSheet(material: item),
        );
      },
      child: LiquidGlass(
        padding: const EdgeInsets.all(14),
        borderRadius: BorderRadius.circular(16),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: noteColor.withValues(alpha: 0.22),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(noteIcon, size: 18, color: noteColor),
                    Text(
                      noteLabel,
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.w700,
                        color: noteColor,
                        height: 1.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.label.resolveFrom(context),
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    '${item.pyramidNote.toUpperCase()} • ${item.dilutionPercent.toStringAsFixed(0)}% in ${item.defaultSolvent ?? "Neat"}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13,
                      color: AppColors.secondaryLabel.resolveFrom(context),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${item.stockGrams.toStringAsFixed(1)} g',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    fontFeatures: const [FontFeature.tabularFigures()],
                    color: item.stockGrams > 0
                        ? AppColors.label.resolveFrom(context)
                        : CupertinoColors.systemRed,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  item.casNumber ?? 'No CAS',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.tertiaryLabel.resolveFrom(context),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
