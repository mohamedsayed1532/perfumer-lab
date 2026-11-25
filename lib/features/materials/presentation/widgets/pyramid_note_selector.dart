import 'package:cupertino_ui/cupertino_ui.dart';
import 'package:perfumery_lab/core/theme/app_colors.dart';

class PyramidNoteSelector extends StatelessWidget {
  final String selectedNote; // 'top', 'heart', 'base'
  final ValueChanged<String> onChanged;

  const PyramidNoteSelector({
    super.key,
    required this.selectedNote,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.secondarySystemGroupedBackground.resolveFrom(context),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.separator.resolveFrom(context),
          width: 0.5,
        ),
      ),
      child: CupertinoSegmentedControl<String>(
        padding: const EdgeInsets.all(4),
        groupValue: selectedNote,
        selectedColor: AppColors.accent.resolveFrom(context),
        unselectedColor: CupertinoColors.transparent,
        borderColor: CupertinoColors.transparent,
        children: {
          'top': _buildSegment(
            context,
            'Top Note',
            CupertinoIcons.triangle,
            selectedNote == 'top',
          ),
          'heart': _buildSegment(
            context,
            'Heart Note',
            CupertinoIcons.triangle_lefthalf_fill,
            selectedNote == 'heart',
          ),
          'base': _buildSegment(
            context,
            'Base Note',
            CupertinoIcons.triangle_fill,
            selectedNote == 'base',
          ),
        },
        onValueChanged: onChanged,
      ),
    );
  }

  Widget _buildSegment(
    BuildContext context,
    String label,
    IconData icon,
    bool isSelected,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 14,
            color: isSelected
                ? AppColors.onAccent(context)
                : AppColors.secondaryLabel.resolveFrom(context),
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              color: isSelected
                  ? AppColors.onAccent(context)
                  : AppColors.label.resolveFrom(context),
            ),
          ),
        ],
      ),
    );
  }
}
