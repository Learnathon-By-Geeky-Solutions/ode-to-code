import 'package:edu_bridge_app/core/export.dart'; // Update this import based on your file structure
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AssetsPath', () {
    test('should return correct logo paths', () {
      expect(AssetsPath.appLogo, 'assets/logo/app_logo/edu_bridge_logo.png');
      expect(AssetsPath.appLogo2, 'assets/logo/app_logo/edu_bridge_logo1.png');
    });

    test('should return correct category asset paths', () {
      expect(AssetsPath.school, 'assets/logo/categories/01.svg');
      expect(AssetsPath.college, 'assets/logo/categories/02.svg');
      expect(AssetsPath.english, 'assets/logo/categories/03.svg');
      expect(AssetsPath.creativity, 'assets/logo/categories/04.svg');
      expect(AssetsPath.skill, 'assets/logo/categories/05.svg');
    });

    test('should return correct school class asset paths', () {
      expect(AssetsPath.class6, 'assets/logo/school/6.svg');
      expect(AssetsPath.class7, 'assets/logo/school/7.svg');
      expect(AssetsPath.class8, 'assets/logo/school/8.svg');
      expect(AssetsPath.class9, 'assets/logo/school/9.svg');
      expect(AssetsPath.class10, 'assets/logo/school/10.svg');
    });

    test('should return correct college asset paths', () {
      expect(AssetsPath.hsc1Sci, 'assets/logo/college/1.svg');
      expect(AssetsPath.hsc2Sci, 'assets/logo/college/2.svg');
      expect(AssetsPath.hsc1Com, 'assets/logo/college/3.svg');
      expect(AssetsPath.hsc2Com, 'assets/logo/college/4.svg');
      expect(AssetsPath.hsc1Hum, 'assets/logo/college/5.svg');
      expect(AssetsPath.hsc2Hum, 'assets/logo/college/6.svg');
    });

    test('should return correct icon paths', () {
      expect(AssetsPath.google, 'assets/icons/google_logo.svg');
      expect(AssetsPath.apple, 'assets/icons/apple_logo.svg');
      expect(AssetsPath.notification, 'assets/icons/notification.svg');
      expect(AssetsPath.subjectsBook, 'assets/icons/subjects_book.svg');
      expect(AssetsPath.bn, 'assets/icons/bn.svg');
      expect(AssetsPath.en, 'assets/icons/en.svg');
      expect(AssetsPath.videPlayIcon, 'assets/icons/video_play_icon.png');
      expect(AssetsPath.noteIcon, 'assets/icons/note_icon.png');
    });

    test('should return correct image paths', () {
      expect(AssetsPath.sliderCard, 'assets/images/offer.png');
    });

    test('should return correct external asset URLs', () {
      expect(AssetsPath.google1,
          'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Google_%22G%22_logo.svg/1200px-Google_%22G%22_logo.svg.png');
      expect(AssetsPath.apple2,
          'https://e7.pngegg.com/pngimages/912/682/png-clipart-apple-logo-brand-apple-company-trademark-thumbnail.png');
    });
  });
}
