import 'package:edu_bridge_app/core/resources/export.dart';

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
          onChanged: (String? value) {
            if (value != null) {
              localeController.changeLocale(value);
            }
          },
        );
      },
    );
  }
}
