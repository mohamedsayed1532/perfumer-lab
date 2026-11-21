import 'package:cupertino_ui/cupertino_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:perfumery_lab/features/materials/presentation/create_material_sheet.dart';

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
}
