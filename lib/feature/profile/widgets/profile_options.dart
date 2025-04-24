import 'package:edu_bridge_app/core/resources/export.dart';
import 'package:edu_bridge_app/feature/admin_content_post/admin_content_post_view.dart';
import 'package:edu_bridge_app/feature/profile/view/about_user.dart';
import 'package:edu_bridge_app/feature/profile/widgets/profile_option_card.dart';

List<Widget> buildProfileOptions(BuildContext context) {
  final isAdmin = Get.find<UserProfileController>().isAdmin;

  final options = [
    {
      "title": 'about_user'.tr,
      "icon": Icons.person,
      "onTap": () => Get.to(() => const AboutUser())
    },
    {"title": 'help_center'.tr, "icon": Icons.help, "onTap": () {}},
    {"title": 'invite_friends'.tr, "icon": Icons.group_add, "onTap": () {}},
    {
      "title": 'settings'.tr,
      "icon": Icons.settings,
      "onTap": () => Get.to(() => const SettingsView())
    },
    if (isAdmin)
      {
        "title": 'post_content'.tr,
        "icon": Icons.post_add,
        "onTap": () => Get.to(() => const AdminContentPostView())
      },
    {
      "title": 'sign_out'.tr,
      "icon": Icons.logout_outlined,
      "onTap": () async {
        await Supabase.instance.client.auth.signOut();
        Get.offAll(() => const SignInView());
      }
    },
  ];

  return options.map((item) {
    return ProfileOptionCard(
      title: (item["title"] as String?) ?? 'Default Title',
      icon: item["icon"] as IconData,
      onTap: item["onTap"] as VoidCallback,
    );
  }).toList();
}
