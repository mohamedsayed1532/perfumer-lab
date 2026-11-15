import 'package:flutter/cupertino.dart';
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

    // Tap Materials tab
    await tester.tap(find.text('Materials'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));
    expect(find.text('Raw Materials'), findsWidgets);

    // Tap Ready Oils tab
    await tester.tap(find.text('Ready Oils'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));
    expect(find.text('Ready Fragrance Oils'), findsWidgets);

    // Tap Aging tab
    await tester.tap(find.text('Aging'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));
    expect(find.text('Aging & Batches'), findsWidgets);

    // Tap Utilities tab
    await tester.tap(find.text('Utilities'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));
    expect(find.text('Lab Utilities'), findsWidgets);
  });
}
