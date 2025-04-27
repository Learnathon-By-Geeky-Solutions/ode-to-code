import 'package:edu_bridge_app/core/resources/export.dart'; // Adjust if needed
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LocalizationController Test', () {
    late LocalizationController controller;

    setUp(() {
      controller = LocalizationController();
    });

    test('Initial locale should be English (en)', () {
      expect(controller.locale, const Locale('en'));
    });

    test('Change locale to French (fr)', () {
      controller.changeLocale('fr');
      expect(controller.locale, const Locale('fr'));
    });

    test('Change locale to Spanish (es)', () {
      controller.changeLocale('es');
      expect(controller.locale, const Locale('es'));
    });
  });
}
