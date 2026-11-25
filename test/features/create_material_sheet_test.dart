import 'package:cupertino_ui/cupertino_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:perfumery_lab/core/services/ifra_catalog_service.dart';
import 'package:perfumery_lab/core/services/materials_catalog_service.dart';
import 'package:perfumery_lab/features/materials/presentation/create_material_sheet.dart';
import 'package:perfumery_lab/features/materials/presentation/widgets/ghs_picker.dart';

void main() {
  testWidgets('CreateMaterialSheet renders with form sections and buttons',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(
      const ProviderScope(
        child: CupertinoApp(
          home: CreateMaterialSheet(),
        ),
      ),
    );

    expect(find.text('New Material'), findsOneWidget);
    expect(find.text('Material Name *'), findsOneWidget);
    expect(find.text('CAS Number'), findsOneWidget);
    expect(find.text('ACCORD IDENTITY'), findsOneWidget);
    expect(find.text('Cancel'), findsOneWidget);
    expect(find.text('Save'), findsOneWidget);
  });

  testWidgets(
      'Entering CAS number auto-selects ideal max and GHS safety classification',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);

    final mockMatCatalog = MaterialsCatalogData.parseFromString('''
[
  {
    "cas": "97-54-1",
    "name": "Isoeugenol",
    "haz": ["irritant", "health_hazard"],
    "max": 0.11,
    "mSrc": "ifra",
    "iType": "RESTRICTION",
    "note": "heart",
    "cats": ["Synthetic"]
  }
]
''');
    final mockIfraCatalog = IfraCatalogData.parseFromStrings('[]', '[]');

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          materialsCatalogProvider.overrideWith((ref) async => mockMatCatalog),
          ifraCatalogProvider.overrideWith((ref) async => mockIfraCatalog),
        ],
        child: const CupertinoApp(
          home: CreateMaterialSheet(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    // Enter CAS Number manually (2nd CupertinoTextField in ACCORD IDENTITY)
    final casField = find.byType(CupertinoTextField).at(1);
    await tester.enterText(casField, '97-54-1');
    await tester.pumpAndSettle();

    expect(find.text('DB Match · Isoeugenol'), findsOneWidget);
    expect(find.text('0.11'), findsOneWidget);

    final ghsPicker = tester.widget<GhsPicker>(find.byType(GhsPicker));
    expect(ghsPicker.selected, ['irritant', 'health_hazard']);
  });
}
