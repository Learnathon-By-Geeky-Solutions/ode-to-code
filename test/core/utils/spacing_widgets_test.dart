import 'package:edu_bridge_app/core/resources/export.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Spacing Widgets', () {
    testWidgets('VerticalSpacing renders with correct height',
        (WidgetTester tester) async {
      const double testHeight = 20.0;

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: VerticalSpacing(testHeight),
          ),
        ),
      );

      final sizedBoxFinder = find.byType(SizedBox);
      expect(sizedBoxFinder, findsOneWidget);

      final SizedBox box = tester.widget(sizedBoxFinder);
      expect(box.height, testHeight);
      expect(box.width, isNull);
    });

    testWidgets('HorizontalSpacing renders with correct width',
        (WidgetTester tester) async {
      const double testWidth = 30.0;

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: HorizontalSpacing(testWidth),
          ),
        ),
      );

      final sizedBoxFinder = find.byType(SizedBox);
      expect(sizedBoxFinder, findsOneWidget);

      final SizedBox box = tester.widget(sizedBoxFinder);
      expect(box.width, testWidth);
      expect(box.height, isNull);
    });
  });
}
