import 'package:flutter_test/flutter_test.dart';
import 'package:edu_bridge_app/core/resources/export.dart';

void main() {
  group('AppThemes', () {
    test('should have correct light theme primary color', () {
      expect(AppThemes.lightTheme.primaryColor,
          AppColors.primary); // Check if the primary color is set correctly
    });

    test('should have correct dark theme primary color', () {
      expect(AppThemes.darkTheme.primaryColor,
          AppColors.darkPrimary); // Verify dark theme primary color
    });

    test('should have correct light theme font family', () {
      expect(AppThemes.lightTheme.fontFamily,
          'Kalpurush'); // Check if font is applied
    });

    test('should have correct input decoration for light theme', () {
      expect(AppThemes.lightTheme.inputDecorationTheme.fillColor,
          AppColors.white); // Check fill color for input field
    });
  });
}

extension on ThemeData {
  get fontFamily => null;
}
