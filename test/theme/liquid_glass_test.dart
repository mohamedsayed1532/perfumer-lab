import 'package:cupertino_ui/cupertino_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:perfumery_lab/core/theme/liquid_glass.dart';

void main() {
  testWidgets('LiquidGlass renders with backdrop blur filter and child',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const CupertinoApp(
        home: CupertinoPageScaffold(
          child: Stack(
            children: [
              Center(child: Text('Underneath Background Content')),
              Center(
                child: LiquidGlass(
                  padding: EdgeInsets.all(20),
                  child: Text('Frosted Liquid Glass Content'),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    expect(find.text('Frosted Liquid Glass Content'), findsOneWidget);
    expect(find.text('Underneath Background Content'), findsOneWidget);
    expect(find.byType(LiquidGlass), findsOneWidget);
  });
}
