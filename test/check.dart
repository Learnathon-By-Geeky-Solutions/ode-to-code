import 'package:flutter_test/flutter_test.dart';
import 'package:edu_bridge_app/core/resources/export.dart'; // Assuming this imports the necessary components.

void main() {
  group('CustomScaffoldHome Tests', () {
    testWidgets('should render CustomScaffoldHome with the correct title and subtitle', (tester) async {
      // Build our app and trigger a frame
      await tester.pumpWidget(
        MaterialApp(
          home: CustomScaffoldHome(
            name: 'Test User',  // Pass in a custom name
            body: Container(),  // Simple body for testing
          ),
        ),
      );

      // Verify the title is displayed
      expect(find.text('Test User'), findsOneWidget);  // Test with passed name
      expect(find.text('search_prompt'.tr), findsOneWidget);  // Check subtitle for 'search_prompt'

      // Test if the AppBar is rendered correctly
      expect(find.byType(AppBar), findsOneWidget);
    });

    testWidgets('should render CustomScaffoldHome with default "hi_there" when no name is provided', (tester) async {
      // Build our app with no name passed
      await tester.pumpWidget(
        MaterialApp(
          home: CustomScaffoldHome(
            body: Container(),  // Simple body for testing
          ),
        ),
      );

      // Verify the title is default text 'hi_there'
      expect(find.text('hi_there'.tr), findsOneWidget);
    });

    testWidgets('should toggle language between English and Bengali on button press', (tester) async {
      // Setup for localeController and initial locale
      final localeController = Get.put(LocalizationController());

      // Set initial locale to English
      localeController.changeLocale('en');

      // Build the widget
      await tester.pumpWidget(
        MaterialApp(
          home: CustomScaffoldHome(
            body: Container(),  // Simple body for testing
          ),
        ),
      );

      // Find the language toggle button (the flag icon)
      final languageToggleButton = find.byType(IconButton);

      // Verify initial language is English
      expect(Get.locale?.languageCode, 'en');

      // Tap the language toggle button
      await tester.tap(languageToggleButton);
      await tester.pump();  // Rebuild after the state change

      // Verify that the locale has changed to Bengali
      expect(Get.locale?.languageCode, 'bn');

      // Tap the language toggle button again to revert to English
      await tester.tap(languageToggleButton);
      await tester.pump();

      // Verify that the locale is now back to English
      expect(Get.locale?.languageCode, 'en');
    });

    testWidgets('should show the floating action button if provided', (tester) async {
      // Build our app with a floatingActionButton
      await tester.pumpWidget(
        MaterialApp(
          home: CustomScaffoldHome(
            body: Container(),  // Simple body for testing
            floatingActionButton: FloatingActionButton(
              onPressed: () {},
              child: const Icon(Icons.add),
            ),
          ),
        ),
      );

      // Verify the FloatingActionButton is visible
      expect(find.byType(FloatingActionButton), findsOneWidget);
    });

    testWidgets('should not show the floating action button if not provided', (tester) async {
      // Build our app with no floatingActionButton
      await tester.pumpWidget(
        MaterialApp(
          home: CustomScaffoldHome(
            body: Container(),  // Simple body for testing
          ),
        ),
      );

      // Verify the FloatingActionButton is not visible
      expect(find.byType(FloatingActionButton), findsNothing);
    });
  });
}
