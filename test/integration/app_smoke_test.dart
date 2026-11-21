import 'package:cupertino_ui/cupertino_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:perfumery_lab/main.dart';

void main() {
  testWidgets(
      'PerfumeryLabApp loads and presents Liquid Glass tab bar navigation with Large Titles',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(
      const ProviderScope(
        child: PerfumeryLabApp(),
      ),
    );

    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    // Verify Tab Bar items
    expect(find.text('Formulas'), findsWidgets);
    expect(find.text('Materials'), findsWidgets);
    expect(find.text('Ready Oils'), findsWidgets);
    expect(find.text('Aging'), findsWidgets);
    expect(find.text('Utilities'), findsWidgets);

    // Initial tab is Formulas (CupertinoSliverNavigationBar creates a large title and a collapsed title)
    expect(find.text('Formulas Lab'), findsWidgets);

    // Tap + button on Formulas Lab (opens CreateFormulaSheet)
    await tester.tap(find.byIcon(CupertinoIcons.add).first);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    expect(find.text('New Formula'), findsOneWidget);

    // Dismiss sheet
    await tester.tap(find.text('Cancel'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    // Tap Materials tab (find by ValueKey)
    await tester.tap(find.byKey(const ValueKey('tab_Materials')));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    expect(find.text('Raw Materials'), findsWidgets);

    // Tap Ready Oils tab
    await tester.tap(find.byKey(const ValueKey('tab_Ready Oils')));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    expect(find.text('Ready Fragrance Oils'), findsWidgets);

    // Tap Aging tab
    await tester.tap(find.byKey(const ValueKey('tab_Aging')));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    expect(find.text('Aging & Batches'), findsWidgets);

    // Tap Utilities tab
    await tester.tap(find.byKey(const ValueKey('tab_Utilities')));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    expect(find.text('Lab Utilities'), findsWidgets);
  });
}
