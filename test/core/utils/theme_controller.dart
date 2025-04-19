import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:edu_bridge_app/core/resources/export.dart'; // Adjust the import based on your project structure

void main() {
  // Set up a test group
  group('ThemeSwitch Widget Test', () {
    // Initialize the GetX dependency injection
    setUp(() {
      // Initialize GetX
      Get.testMode = true;
      Get.put(
          ThemeController()); // Put ThemeController in GetX dependency injection system
    });

    testWidgets('should toggle theme on switch', (WidgetTester tester) async {
      // Build the widget for testing
      await tester.pumpWidget(
        GetMaterialApp(
          home: Scaffold(
            body: ThemeSwitch(),
          ),
        ),
      );

      final themeController = Get.find<ThemeController>();

      // Verify initial theme is light
      expect(themeController.themeMode, ThemeMode.light);

      // Find the switch widget
      final switchWidget = find.byType(Switch);

      // Ensure the switch is in the 'off' position initially (light mode)
      expect(tester.widget<Switch>(switchWidget).value, false);

      // Toggle the switch to turn on dark mode
      await tester.tap(switchWidget);
      await tester.pump(); // Rebuild the widget tree

      // Verify theme is now dark
      expect(themeController.themeMode, ThemeMode.dark);
      expect(tester.widget<Switch>(switchWidget).value, true);

      // Toggle back to light mode
      await tester.tap(switchWidget);
      await tester.pump(); // Rebuild the widget tree

      // Verify theme is light again
      expect(themeController.themeMode, ThemeMode.light);
      expect(tester.widget<Switch>(switchWidget).value, false);
    });
  });
}
