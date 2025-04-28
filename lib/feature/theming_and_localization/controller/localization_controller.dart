import 'package:edu_bridge_app/core/export.dart';

class LocalizationController extends GetxController {
  Locale _locale = const Locale('en');

  Locale get locale => _locale;

  void changeLocale(String languageCode) {
    _locale = Locale(languageCode);
    Get.updateLocale(_locale);
    update();
  }
}
