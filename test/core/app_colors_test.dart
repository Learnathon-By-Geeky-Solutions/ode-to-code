import 'package:edu_bridge_app/core/export.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppColors', () {
    test('should have correct color values', () {
      expect(AppColors.bg, const Color(0xffF5F9FF));
      expect(AppColors.bgWhite, const Color(0xffFFFFFF));
      expect(AppColors.themeColor, const Color(0xff0961F5));
      expect(AppColors.white, const Color(0xffFFFFFF));
      expect(AppColors.blackGray, const Color(0xff545454));
      expect(AppColors.orange, const Color(0xffFF6B00));
      expect(AppColors.green, const Color(0xff01A437));
      expect(AppColors.bookColor, const Color(0xff507C5C));
      expect(AppColors.shadowGrey, const Color(0xffBFBFBF));
      expect(AppColors.grey, Colors.grey);
      expect(AppColors.red, const Color(0xffff0101));
      expect(AppColors.blue, AppColors.themeColor);

      // Theme mapping
      expect(AppColors.primary, AppColors.themeColor);
      expect(AppColors.secondary, AppColors.orange);
      expect(AppColors.background, AppColors.bgWhite);
      expect(AppColors.surface, AppColors.white);

      expect(AppColors.onPrimary, AppColors.white);
      expect(AppColors.onSecondary, AppColors.white);
      expect(AppColors.onBackground, AppColors.blackGray);
      expect(AppColors.onSurface, AppColors.blackGray);

      expect(AppColors.greenAccent, Colors.greenAccent);

      // New colors
      expect(AppColors.transparent, Colors.transparent);
      expect(AppColors.grey100, const Color(0xFFF5F5F5));
      expect(AppColors.blueAccent, Colors.blueAccent);
      expect(AppColors.black12, Colors.black12);
      expect(AppColors.black, Colors.black);
      expect(AppColors.teal, Colors.teal);
      expect(AppColors.black87, Colors.black87);
      expect(AppColors.grey50, const Color(0xFFFAFAFA));
      expect(AppColors.grey300, const Color(0xFFE0E0E0));

      // Dark theme colors
      expect(AppColors.darkPrimary, const Color(0xff1565C0));
      expect(AppColors.darkSecondary, const Color(0xffFF8F00));
      expect(AppColors.darkBackground, const Color(0xff121212));
      expect(AppColors.darkSurface, const Color(0xff1E1E1E));
      expect(AppColors.onDarkPrimary, AppColors.white);
      expect(AppColors.onDarkSecondary, Colors.black);
      expect(AppColors.onDarkBackground, AppColors.white);
      expect(AppColors.onDarkSurface, AppColors.white);
    });
  });
}
