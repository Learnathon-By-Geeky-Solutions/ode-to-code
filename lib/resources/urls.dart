import 'package:flutter_dotenv/flutter_dotenv.dart';

class Urls {
  static String get apiUrls =>
      dotenv.env['API_URL'] ?? ''; // Use a getter for lazy loading
  static String get apiKey =>
      dotenv.env['API_KEY'] ?? ''; // Use a getter for lazy loading
}
