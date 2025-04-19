import 'package:edu_bridge_app/core/resources/export.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CustomText Widget Tests', () {
    testWidgets('renders text with default style', (WidgetTester tester) async {
      const String testString = 'Hello Flutter';

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CustomText(text: testString),
          ),
        ),
      );

      final textFinder = find.text(testString);
      expect(textFinder, findsOneWidget);

      final Text widget = tester.widget(textFinder);
      final TextStyle? style = widget.style;

      expect(style?.fontSize, 14);
      expect(style?.fontWeight, FontWeight.normal);
      expect(style?.color, Colors.black);
    });

    testWidgets('applies custom style if provided',
        (WidgetTester tester) async {
      const String testString = 'Custom Style';
      const customStyle = TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.red,
      );

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CustomText(
              text: testString,
              customStyle: customStyle,
            ),
          ),
        ),
      );

      final textFinder = find.text(testString);
      expect(textFinder, findsOneWidget);

      final Text widget = tester.widget(textFinder);
      final TextStyle? style = widget.style;

      expect(style?.fontSize, 20);
      expect(style?.fontWeight, FontWeight.bold);
      expect(style?.color, Colors.red);
    });
  });
}
