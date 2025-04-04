import 'package:edu_bridge_app/controller.dart';
import 'package:edu_bridge_app/resources/app_themes.dart';
import 'package:edu_bridge_app/resources/app_translations.dart';
import 'package:edu_bridge_app/view/auth/splash_view.dart';
import 'package:edu_bridge_app/view_model/theming%20and%20localization/localization_controller.dart';
import 'package:edu_bridge_app/view_model/theming%20and%20localization/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class EduBridgeUser extends StatelessWidget {
  const EduBridgeUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        // Initialize controllers before using them
        Get.put(ThemeController());
        Get.put(LocalizationController());

        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          initialBinding: ControllerBinder(),
          theme: AppThemes.lightTheme,
          darkTheme: AppThemes.darkTheme,
          themeMode: Get.find<ThemeController>().themeMode,
          translations: AppTranslations(),
          locale: Get.find<LocalizationController>().locale,
          fallbackLocale: const Locale('en'),
          home: const SplashView(),
        );
      },
    );
  }
}
