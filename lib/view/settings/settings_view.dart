// view/settings/settings_view.dart
import 'package:edu_bridge_app/utils/language_switch.dart';
import 'package:edu_bridge_app/utils/theme_switch.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('settings'.tr),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
              title: Text('dark_mode'.tr),
              trailing: const ThemeSwitch(),
            ),
            ListTile(
              title: Text('language'.tr),
              trailing: const LanguageSwitch(),
            ),
          ],
        ),
      ),
    );
  }
}
