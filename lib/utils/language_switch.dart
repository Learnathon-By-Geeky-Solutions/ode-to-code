// widgets/language_switch.dart
import 'package:edu_bridge_app/view_model/theming%20and%20localization/localization_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LanguageSwitch extends StatelessWidget {
  const LanguageSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    final localeController = Get.find<LocalizationController>();

    return GetBuilder<LocalizationController>(
      builder: (_) {
        return DropdownButton<String>(
          value: localeController.locale.languageCode,
          items: const [
            DropdownMenuItem(
              value: 'en',
              child: Text('English'),
            ),
            DropdownMenuItem(
              value: 'bn',
              child: Text('বাংলা'),
            ),
          ],
          onChanged: (value) {
            if (value != null) {
              localeController.changeLocale(value);
            }
          },
        );
      },
    );
  }
}
