import 'package:edu_bridge_app/view_model/theming_and_localization/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeSwitch extends StatelessWidget {
  const ThemeSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();

    return GetBuilder<ThemeController>(
      builder: (_) {
        return Switch(
          value: themeController.themeMode == ThemeMode.dark,
          onChanged: (value) {
            themeController.toggleTheme(value);
          },
        );
      },
    );
  }
}
