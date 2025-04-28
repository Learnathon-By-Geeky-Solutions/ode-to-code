import 'package:edu_bridge_app/core/export.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppTranslations', () {
    final translations = AppTranslations();

    test('should return correct translation for "appTitle" in English', () {
      expect(translations.keys['en']!['appTitle'], 'EduBridge');
    });

    test('should return correct translation for "welcome" in English', () {
      expect(translations.keys['en']!['welcome'], 'Welcome!');
    });

    test('should return correct translation for "signIn" in English', () {
      expect(translations.keys['en']!['signIn'], 'Sign In');
    });

    test('should return correct translation for "popular_courses" in English',
        () {
      expect(translations.keys['en']!['popular_courses'], 'Popular Courses');
    });

    test(
        'should return correct translation for "add_course_details" in English',
        () {
      expect(
          translations.keys['en']!['add_course_details'], 'Add Course Details');
    });

    test('should return correct translation for "appTitle" in Bangla', () {
      expect(translations.keys['bn']!['appTitle'], 'এডু ব্রিজ');
    });

    test('should return correct translation for "welcome" in Bangla', () {
      expect(translations.keys['bn']!['welcome'], 'স্বাগতম!');
    });

    test('should return correct translation for "signIn" in Bangla', () {
      expect(translations.keys['bn']!['signIn'], 'সাইন ইন');
    });

    test('should return correct translation for "popular_courses" in Bangla',
        () {
      expect(translations.keys['bn']!['popular_courses'], 'জনপ্রিয় কোর্স');
    });

    test('should return correct translation for "add_course_details" in Bangla',
        () {
      expect(translations.keys['bn']!['add_course_details'],
          'কোর্সের বিস্তারিত যোগ করুন');
    });

    test('should return null if key does not exist in English', () {
      expect(translations.keys['en']!['non_existent_key'], null);
    });

    test('should return null if key does not exist in Bangla', () {
      expect(translations.keys['bn']!['non_existent_key'], null);
    });
  });
}
