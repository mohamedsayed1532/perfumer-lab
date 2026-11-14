import 'package:cupertino_ui/cupertino_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:perfumery_lab/main.dart';

void main() {
  testWidgets('PerfumeryLabApp loads and presents Liquid Glass tab bar navigation',
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

    // Initial tab is Formulas
    expect(find.text('Formulas Lab'), findsOneWidget);

    // Tap Materials tab
    await tester.tap(find.text('Materials'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));
    expect(find.text('Raw Materials'), findsOneWidget);

    // Tap Ready Oils tab
    await tester.tap(find.text('Ready Oils'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));
    expect(find.text('Ready Fragrance Oils'), findsOneWidget);

    // Tap Aging tab
    await tester.tap(find.text('Aging'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));
    expect(find.text('Aging & Batches'), findsOneWidget);

    // Tap Utilities tab
    await tester.tap(find.text('Utilities'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));
    expect(find.text('Lab Utilities'), findsOneWidget);
  });
}
