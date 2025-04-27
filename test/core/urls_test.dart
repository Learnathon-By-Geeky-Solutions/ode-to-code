import 'package:edu_bridge_app/core/resources/urls.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Urls', () {
    test('should load API_URL from environment', () async {
      await dotenv.load();
      expect(Urls.env['apiUrl'], dotenv.env['API_URL']);
    });

    test('should load API_KEY from environment', () async {
      await dotenv.load();
      expect(Urls.env['apiKey'], dotenv.env['API_KEY']);
    });
  });
}
