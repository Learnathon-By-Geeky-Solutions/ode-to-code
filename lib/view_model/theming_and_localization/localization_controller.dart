// controllers/locale_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LocalizationController extends GetxController {
  Locale _locale = const Locale('bn');

  Locale get locale => _locale;

  void changeLocale(String languageCode) {
    _locale = Locale(languageCode);
    Get.updateLocale(_locale);
    update(); // This will trigger GetBuilder to rebuild
  }
}
