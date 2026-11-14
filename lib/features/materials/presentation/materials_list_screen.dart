import 'package:cupertino_ui/cupertino_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:perfumery_lab/core/database/app_database.dart';
import 'package:perfumery_lab/core/theme/app_colors.dart';
import 'package:perfumery_lab/core/theme/app_typography.dart';
import 'package:perfumery_lab/core/theme/liquid_glass.dart';
import '../data/materials_repository.dart';
import 'create_material_sheet.dart';

class MaterialsListScreen extends ConsumerStatefulWidget {
  const MaterialsListScreen({super.key});

  @override
  ConsumerState<MaterialsListScreen> createState() => _MaterialsListScreenState();
}

class _MaterialsListScreenState extends ConsumerState<MaterialsListScreen> {
  String _searchQuery = '';
  String _selectedFilter = 'all'; // 'all', 'top', 'heart', 'base'

  @override
  Widget build(BuildContext context) {
    final materialsAsync = ref.watch(materialsStreamProvider);

    return CupertinoPageScaffold(
      backgroundColor: AppColors.systemGroupedBackground.resolveFrom(context),
      navigationBar: CupertinoNavigationBar(
        middle: Text('Raw Materials', style: AppTypography.headline(context)),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            showCupertinoModalPopup(
              context: context,
              builder: (ctx) => const CreateMaterialSheet(),
            );
          },
          child: const Icon(CupertinoIcons.add_circled_solid, size: 28),
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: CupertinoSearchTextField(
                placeholder: 'Search by material name, CAS, botanical...',
                onChanged: (val) => setState(() => _searchQuery = val.toLowerCase()),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: SizedBox(
                width: double.infinity,
                child: CupertinoSegmentedControl<String>(
                  groupValue: _selectedFilter,
                  selectedColor: AppColors.accent.resolveFrom(context),
                  unselectedColor: CupertinoColors.transparent,
                  borderColor: AppColors.separator.resolveFrom(context),
                  children: const {
                    'all': Padding(
                      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                      child: Text('All'),
                    ),
                    'top': Padding(
                      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                      child: Text('Top'),
                    ),
                    'heart': Padding(
                      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                      child: Text('Heart'),
                    ),
                    'base': Padding(
                      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                      child: Text('Base'),
                    ),
                  },
                  onValueChanged: (val) => setState(() => _selectedFilter = val),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: materialsAsync.when(
                data: (materials) {
                  final filtered = materials.where((m) {
                    final matchesQuery = _searchQuery.isEmpty ||
                        m.name.toLowerCase().contains(_searchQuery) ||
                        (m.casNumber?.toLowerCase().contains(_searchQuery) ?? false) ||
                        (m.botanicalName?.toLowerCase().contains(_searchQuery) ?? false);
                    final matchesFilter = _selectedFilter == 'all' ||
                        m.pyramidNote.toLowerCase() == _selectedFilter;
                    return matchesQuery && matchesFilter;
                  }).toList();

                  if (filtered.isEmpty) {
                    return Center(
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
                                ? 'Tap + to catalog your first aroma chemical or natural.'
                                : 'Try adjusting your search terms or filter.',
                            style: AppTypography.subheadline(context),
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    itemCount: filtered.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      final item = filtered[index];
                      return _buildMaterialCard(context, item);
                    },
                  );
                },
                loading: () => const Center(child: CupertinoActivityIndicator()),
                error: (err, _) => Center(child: Text('Error loading: $err')),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMaterialCard(BuildContext context, Material item) {
    IconData noteIcon;
    Color noteColor;
    switch (item.pyramidNote.toLowerCase()) {
      case 'top':
        noteIcon = CupertinoIcons.triangle;
        noteColor = CupertinoColors.systemYellow;
        break;
      case 'heart':
        noteIcon = CupertinoIcons.triangle_lefthalf_fill;
        noteColor = CupertinoColors.systemPink;
        break;
      case 'base':
      default:
        noteIcon = CupertinoIcons.triangle_fill;
        noteColor = CupertinoColors.systemPurple;
        break;
    }

    return GestureDetector(
      onTap: () {
        showCupertinoModalPopup(
          context: context,
          builder: (ctx) => CreateMaterialSheet(existing: item),
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
                color: noteColor.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(noteIcon, size: 20, color: noteColor),
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
