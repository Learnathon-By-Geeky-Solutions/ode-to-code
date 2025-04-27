import 'package:edu_bridge_app/core/resources/export.dart'; // Import your necessary files
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LocalizationController', () {
    test('should change locale to the given language code', () {
      final localizationController = LocalizationController();

      // Initially the locale is 'en'
      expect(localizationController.locale, const Locale('en'));

      // Change the locale to 'bn'
      localizationController.changeLocale('bn');
      expect(localizationController.locale, const Locale('bn'));

      // Change the locale back to 'en'
      localizationController.changeLocale('en');
      expect(localizationController.locale, const Locale('en'));
    });
  });

  group('ThemeController', () {
    test('should toggle between light and dark theme', () {
      final themeController = ThemeController();

      // Initially the theme mode is light
      expect(themeController.themeMode, ThemeMode.light);

      // Toggle to dark theme
      themeController.toggleTheme(true);
      expect(themeController.themeMode, ThemeMode.dark);

      // Toggle back to light theme
      themeController.toggleTheme(false);
      expect(themeController.themeMode, ThemeMode.light);
    });
  });
}
