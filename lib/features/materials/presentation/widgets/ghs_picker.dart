import 'package:cupertino_ui/cupertino_ui.dart';
import 'package:perfumery_lab/core/theme/app_colors.dart';

class GhsPicker extends StatelessWidget {
  final List<String> selected;
  final ValueChanged<List<String>> onChanged;

  const GhsPicker({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  static const List<Map<String, dynamic>> pictograms = [
    {
      'id': 'flammable',
      'label': 'Flammable',
      'icon': CupertinoIcons.flame_fill,
      'color': CupertinoColors.systemRed,
    },
    {
      'id': 'irritant',
      'label': 'Irritant',
      'icon': CupertinoIcons.exclamationmark_triangle_fill,
      'color': CupertinoColors.systemOrange,
    },
    {
      'id': 'health_hazard',
      'label': 'Health Hazard',
      'icon': CupertinoIcons.person_crop_circle_badge_exclam,
      'color': CupertinoColors.systemBlue,
    },
    {
      'id': 'environmental',
      'label': 'Environmental',
      'icon': CupertinoIcons.leaf_arrow_circlepath,
      'color': CupertinoColors.systemGreen,
    },
    {
      'id': 'corrosive',
      'label': 'Corrosive',
      'icon': CupertinoIcons.drop_triangle_fill,
      'color': CupertinoColors.systemYellow,
    },
    {
      'id': 'acute_toxic',
      'label': 'Acute Toxic',
      'icon': CupertinoIcons.ant_fill,
      'color': CupertinoColors.systemPurple,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: pictograms.map((item) {
        final id = item['id'] as String;
        final label = item['label'] as String;
        final icon = item['icon'] as IconData;
        final itemColor = item['color'] as Color;
        final isSelected = selected.contains(id);

        return GestureDetector(
          onTap: () {
            final next = List<String>.from(selected);
            if (isSelected) {
              next.remove(id);
            } else {
              next.add(id);
            }
            onChanged(next);
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: isSelected
                  ? itemColor.withValues(alpha: 0.2)
                  : AppColors.secondarySystemGroupedBackground.resolveFrom(context),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: isSelected
                    ? itemColor
                    : AppColors.separator.resolveFrom(context),
                width: isSelected ? 1.5 : 0.5,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  size: 16,
                  color: isSelected
                      ? itemColor
                      : AppColors.secondaryLabel.resolveFrom(context),
                ),
                const SizedBox(width: 6),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                    color: isSelected
                        ? AppColors.label.resolveFrom(context)
                        : AppColors.secondaryLabel.resolveFrom(context),
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
