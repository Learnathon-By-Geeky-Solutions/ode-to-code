import 'package:edu_bridge_app/core/resources/export.dart';
import 'package:edu_bridge_app/feature/profile/view/about_user.dart';
import 'package:edu_bridge_app/feature/profile/widgets/profile_option_card.dart';

List<Widget> buildProfileOptions(BuildContext context) {
  final options = [
    {
      "title": 'about_user'.tr,
      "icon": Icons.person,
      "onTap": () => Get.to(() => const AboutUser())
    },
    {"title": 'notification'.tr, "icon": Icons.notifications, "onTap": () {}},
    {
      "title": 'language'.tr,
      "icon": Icons.language,
      "onTap": () {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: CustomText(text: 'select_language'.tr),
            content: const LanguageSwitch(),
          ),
        );
      }
    },
    {
      "title": 'dark_mode'.tr,
      "icon": Icons.dark_mode,
      "onTap": () {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: CustomText(text: 'toggle_theme'.tr),
            content: const ThemeSwitch(),
          ),
        );
      }
    },
    {"title": 'help_center'.tr, "icon": Icons.help, "onTap": () {}},
    {"title": 'invite_friends'.tr, "icon": Icons.group_add, "onTap": () {}},
    {
      "title": 'settings'.tr,
      "icon": Icons.settings,
      "onTap": () => Get.to(() => const SettingsView())
    },
  ];

  return options.map((item) {
    return ProfileOptionCard(
      title: (item["title"] as String?) ??
          'Default Title', // Explicit cast to String?
      icon: item["icon"] as IconData, // Cast icon to IconData
      onTap: item["onTap"] as VoidCallback, // Cast onTap to VoidCallback
    );
  }).toList();
}
