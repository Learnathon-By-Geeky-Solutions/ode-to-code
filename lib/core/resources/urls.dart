import 'package:edu_bridge_app/core/resources/export.dart';

class Urls {
  static String get apiUrls => dotenv.env['API_URL'] ?? '';
  static String get apiKey => dotenv.env['API_KEY'] ?? '';
}
