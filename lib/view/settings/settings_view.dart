import 'package:edu_bridge_app/resources/export.dart';
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
        title: CustomText(text: 'settings'.tr),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Text(
                'settings'.tr,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            const Divider(),
            const ListTile(
              leading: Icon(Icons.dark_mode),
              title: CustomText(text: "Dark Mood"),
              trailing: ThemeSwitch(),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.language),
              title: CustomText(text: 'language'.tr),
              trailing: const LanguageSwitch(),
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
