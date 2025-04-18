import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:edu_bridge_app/core/resources/app_colors.dart';

void main() {
  group('AppColors', () {
    test('should have correct primary color', () {
      expect(AppColors.primary, const Color(0xff0961F5)); // Verify the primary color
    });

    test('should have correct secondary color', () {
      expect(
          AppColors.secondary, const Color(0xffFF6B00)); // Verify the secondary color
    });

    test('should have correct dark theme primary color', () {
      expect(AppColors.darkPrimary,
          const Color(0xff1565C0)); // Verify dark theme primary
    });

    test('should have correct dark theme background color', () {
      expect(AppColors.darkBackground,
          const Color(0xff121212)); // Verify dark theme background
    });
  });
}
