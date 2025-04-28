import 'package:edu_bridge_app/core/export.dart';

class Urls {
  static final Map<String, String> env = {
    'apiUrl': dotenv.env['API_URL'] ?? '',
    'apiKey': dotenv.env['API_KEY'] ?? '',
  };
}
