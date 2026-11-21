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

          // Floating Island Tab Bar
          Positioned(
            left: 16,
            right: 16,
            bottom: bottomPadding > 0 ? bottomPadding : 16,
            child: _buildFloatingIsland(context, isDark),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingIsland(BuildContext context, bool isDark) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? const Color(0x66000000)
                : const Color(0x26000000),
            blurRadius: 28,
            offset: const Offset(0, 10),
            spreadRadius: -2,
          ),
          BoxShadow(
            color: AppColors.accent
                .resolveFrom(context)
                .withValues(alpha: isDark ? 0.08 : 0.04),
            blurRadius: 24,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
          child: Container(
            height: 68,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              color: isDark
                  ? const Color(0xD0171825) // Translucent deep midnight glass
                  : const Color(0xE8FFFFFF), // Frosted white glass
              border: Border.all(
                color: isDark
                    ? const Color(0x38FFFFFF)
                    : const Color(0x60FFFFFF),
                width: 0.6,
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

    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOutCubic,
      padding: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: isSelected
            ? (isDark
                ? activeColor.withValues(alpha: 0.22)
                : activeColor.withValues(alpha: 0.12))
            : CupertinoColors.transparent,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            isSelected ? tab.activeIcon : tab.icon,
            size: isSelected ? 23 : 21,
            color: isSelected
                ? activeColor
                : (isDark
                    ? const Color(0x8AFFFFFF)
                    : const Color(0x8A000000)),
          ),
          const SizedBox(height: 3),
          Text(
            tab.label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 10.5,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              color: isSelected
                  ? activeColor
                  : (isDark
                      ? const Color(0x8AFFFFFF)
                      : const Color(0x8A000000)),
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
