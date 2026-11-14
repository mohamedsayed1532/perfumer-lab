import 'package:cupertino_ui/cupertino_ui.dart';
import 'package:perfumery_lab/core/theme/app_colors.dart';
import 'package:perfumery_lab/features/formulas/presentation/formulas_list_screen.dart';
import 'package:perfumery_lab/features/materials/presentation/materials_list_screen.dart';
import 'package:perfumery_lab/features/ready_oils/presentation/ready_oils_screen.dart';
import 'package:perfumery_lab/features/aging/presentation/aging_dashboard_screen.dart';
import 'package:perfumery_lab/features/utilities/presentation/lab_utilities_screen.dart';

class AppTabScaffold extends StatelessWidget {
  const AppTabScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        backgroundColor: AppColors.liquidGlassBg.resolveFrom(context),
        activeColor: AppColors.accent.resolveFrom(context),
        inactiveColor: AppColors.secondaryLabel.resolveFrom(context),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.lab_flask),
            activeIcon: Icon(CupertinoIcons.lab_flask_solid),
            label: 'Formulas',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.circle_grid_hex),
            activeIcon: Icon(CupertinoIcons.circle_grid_hex_fill),
            label: 'Materials',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.drop),
            activeIcon: Icon(CupertinoIcons.drop_fill),
            label: 'Ready Oils',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.hourglass),
            activeIcon: Icon(CupertinoIcons.hourglass_bottomhalf_fill),
            label: 'Aging',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.slider_horizontal_3),
            activeIcon: Icon(CupertinoIcons.slider_horizontal_below_rectangle),
            label: 'Utilities',
          ),
        ],
      ),
      tabBuilder: (context, index) {
        switch (index) {
          case 0:
            return const FormulasListScreen();
          case 1:
            return const MaterialsListScreen();
          case 2:
            return const ReadyOilsScreen();
          case 3:
            return const AgingDashboardScreen();
          case 4:
          default:
            return const LabUtilitiesScreen();
        }
      },
    );
  }
}
