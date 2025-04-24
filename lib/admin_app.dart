import 'package:edu_bridge_app/core/resources/export.dart';
import 'package:edu_bridge_app/feature/admin_content_post/admin_content_post_view.dart';

class EduBridgeAdmin extends StatelessWidget {
  const EduBridgeAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
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
            home: const AdminContentPostView()
        );
      },
    );
  }
}
