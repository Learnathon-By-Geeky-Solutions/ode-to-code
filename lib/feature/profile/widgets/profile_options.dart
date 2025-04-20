import 'package:edu_bridge_app/core/resources/export.dart';

class ProfileOptions extends StatelessWidget {
  final BuildContext context;

  const ProfileOptions({super.key, required this.context});

  @override
  Widget build(BuildContext context) {
    final options = _buildOptions(context);
    return ListView(
      children: options
          .map((item) => buildCard(item["title"], item["icon"],
              Icons.arrow_forward_ios, item["onTap"]))
          .toList(),
    );
  }

  List<Map<String, dynamic>> _buildOptions(BuildContext context) {
    return [
      {
        "title": 'about_user'.tr,
        "icon": Icons.person,
        "onTap": () {},
      },
      {
        "title": 'notification'.tr,
        "icon": Icons.notifications,
        "onTap": () {},
      },
      {
        "title": 'language'.tr,
        "icon": Icons.language,
        "onTap": () =>
            _showDialog(context, 'select_language'.tr, const LanguageSwitch()),
      },
      {
        "title": 'dark_mode'.tr,
        "icon": Icons.dark_mode,
        "onTap": () =>
            _showDialog(context, 'toggle_theme'.tr, const ThemeSwitch()),
      },
      {
        "title": 'help_center'.tr,
        "icon": Icons.help,
        "onTap": () {},
      },
      {
        "title": 'invite_friends'.tr,
        "icon": Icons.group_add,
        "onTap": () {},
      },
      {
        "title": 'settings'.tr,
        "icon": Icons.settings,
        "onTap": () => Get.to(() => const SettingsView()),
      },
    ];
  }

  void _showDialog(BuildContext context, String title, Widget content) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: CustomText(text: title),
        content: content,
      ),
    );
  }

  Widget buildCard(
      String title, IconData leading, IconData trailing, VoidCallback onTap) {
    return Card(
      child: ListTile(
        onTap: onTap,
        title: CustomText(text: title, fontSize: 16),
        leading: Icon(leading),
        trailing: Icon(trailing),
      ),
    );
  }
}
