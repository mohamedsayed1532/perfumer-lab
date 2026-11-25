import 'dart:ui';
import 'package:cupertino_ui/cupertino_ui.dart';
import 'package:perfumery_lab/core/theme/app_colors.dart';
import 'package:perfumery_lab/core/utils/haptics.dart';
import 'package:perfumery_lab/features/formulas/presentation/formulas_list_screen.dart';
import 'package:perfumery_lab/features/materials/presentation/materials_list_screen.dart';
import 'package:perfumery_lab/features/ready_oils/presentation/ready_oils_screen.dart';
import 'package:perfumery_lab/features/aging/presentation/aging_dashboard_screen.dart';
import 'package:perfumery_lab/features/utilities/presentation/lab_utilities_screen.dart';

class AppTabScaffold extends StatefulWidget {
  const AppTabScaffold({super.key});

  @override
  State<AppTabScaffold> createState() => _AppTabScaffoldState();
}

class _AppTabScaffoldState extends State<AppTabScaffold> {
  int _currentIndex = 0;

  static const List<Widget> _screens = [
    FormulasListScreen(),
    MaterialsListScreen(),
    ReadyOilsScreen(),
    AgingDashboardScreen(),
    LabUtilitiesScreen(),
  ];

  static const List<_TabItemData> _tabs = [
    _TabItemData(
      icon: CupertinoIcons.lab_flask,
      activeIcon: CupertinoIcons.lab_flask_solid,
      label: 'Formulas',
    ),
    _TabItemData(
      icon: CupertinoIcons.circle_grid_hex,
      activeIcon: CupertinoIcons.circle_grid_hex_fill,
      label: 'Materials',
    ),
    _TabItemData(
      icon: CupertinoIcons.drop,
      activeIcon: CupertinoIcons.drop_fill,
      label: 'Ready Oils',
    ),
    _TabItemData(
      icon: CupertinoIcons.hourglass,
      activeIcon: CupertinoIcons.hourglass_bottomhalf_fill,
      label: 'Aging',
    ),
    _TabItemData(
      icon: CupertinoIcons.slider_horizontal_3,
      activeIcon: CupertinoIcons.slider_horizontal_below_rectangle,
      label: 'Utilities',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = CupertinoTheme.brightnessOf(context) == Brightness.dark;
    final bottomPadding = MediaQuery.paddingOf(context).bottom;

    return CupertinoPageScaffold(
      resizeToAvoidBottomInset: false,
      child: Stack(
        children: [
          // Screen content with IndexedStack for preserving state
          Positioned.fill(
            child: IndexedStack(
              index: _currentIndex,
              children: _screens,
            ),
          ),

          // Anchored Analytical Lab Tab Bar
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: _buildBottomBar(context, isDark, bottomPadding),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar(
    BuildContext context,
    bool isDark,
    double bottomPadding,
  ) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
        child: Container(
          padding: EdgeInsets.only(
            left: 8,
            right: 8,
            top: 8,
            bottom: bottomPadding > 0 ? bottomPadding : 10,
          ),
          decoration: BoxDecoration(
            color: isDark
                ? const Color(0xEB0F141A)
                : const Color(0xEBFFFFFF),
            border: Border(
              top: BorderSide(
                color: AppColors.separator.resolveFrom(context),
                width: 0.75,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(_tabs.length, (index) {
              final tab = _tabs[index];
              final isSelected = _currentIndex == index;
              return Expanded(
                child: CupertinoButton(
                  key: ValueKey('tab_${tab.label}'),
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                  onPressed: () {
                    if (_currentIndex != index) {
                      LabHaptics.selection();
                      setState(() => _currentIndex = index);
                    }
                  },
                  child: _buildTabButton(context, tab, isSelected, isDark),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget _buildTabButton(
    BuildContext context,
    _TabItemData tab,
    bool isSelected,
    bool isDark,
  ) {
    final activeColor = AppColors.accent.resolveFrom(context);
    final inactiveColor = AppColors.tertiaryLabel.resolveFrom(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            isSelected ? tab.activeIcon : tab.icon,
            size: 21,
            color: isSelected ? activeColor : inactiveColor,
          ),
          const SizedBox(height: 4),
          Text(
            tab.label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 11,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              color: isSelected ? activeColor : inactiveColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _TabItemData {
  final IconData icon;
  final IconData activeIcon;
  final String label;

  const _TabItemData({
    required this.icon,
    required this.activeIcon,
    required this.label,
  });
}
