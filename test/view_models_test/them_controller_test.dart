import 'package:edu_bridge_app/core/resources/export.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ThemeController Test', () {
    late ThemeController themeController;

    setUp(() {
      themeController = ThemeController();
    });

    test('Initial themeMode should be light', () {
      expect(themeController.themeMode, ThemeMode.light);
    });

    test('Toggle theme to dark mode', () {
      themeController.toggleTheme(true);
      expect(themeController.themeMode, ThemeMode.dark);
    });

    test('Toggle theme to light mode', () {
      themeController.toggleTheme(false);
      expect(themeController.themeMode, ThemeMode.light);
    });
  });
}
