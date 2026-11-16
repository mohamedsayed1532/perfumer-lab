import 'package:cupertino_ui/cupertino_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:perfumery_lab/core/presentation/app_tab_scaffold.dart';
import 'package:perfumery_lab/core/theme/app_colors.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const ProviderScope(
      child: PerfumeryLabApp(),
    ),
  );
}

class PerfumeryLabApp extends StatelessWidget {
  const PerfumeryLabApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      title: 'Perfumery Lab',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        DefaultCupertinoLocalizations.delegate,
      ],
      theme: CupertinoThemeData(
        brightness: Brightness.dark, // Default dark lab appearance
        primaryColor: AppColors.accent,
        scaffoldBackgroundColor: AppColors.systemBackground,
        barBackgroundColor: AppColors.liquidGlassBg,
      ),
      home: AppTabScaffold(),
    );
  }
}
