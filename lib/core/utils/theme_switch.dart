import 'package:edu_bridge_app/core/resources/export.dart';

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
