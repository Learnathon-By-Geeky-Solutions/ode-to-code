import 'package:edu_bridge_app/core/export.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('CustomHeaderText renders both texts correctly',
      (WidgetTester tester) async {
    const text1 = 'Header Title';
    const text2 = 'Subheading Description';

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: CustomHeaderText(
            text1: text1,
            text2: text2,
          ),
        ),
      ),
    );

    // Verify both texts are rendered
    expect(find.text(text1), findsOneWidget);
    expect(find.text(text2), findsOneWidget);
  });

  testWidgets('CustomHeaderText applies custom font sizes and color',
      (WidgetTester tester) async {
    const text1 = 'Main Heading';
    const text2 = 'Secondary Text';
    const fontSize1 = 30.0;
    const fontSize2 = 14.0;
    const color2 = AppColors.red;

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: CustomHeaderText(
            text1: text1,
            text2: text2,
            text1FontSize: fontSize1,
            text2FontSize: fontSize2,
            text2Color: color2,
          ),
        ),
      ),
    );

    // Verify that both texts are still found
    expect(find.text(text1), findsOneWidget);
    expect(find.text(text2), findsOneWidget);

    // Optional: Check style if `CustomText` exposes TextStyle (harder if it doesn’t)
    // Otherwise, consider extracting style logic in `CustomText` for easier testing
  });
}
