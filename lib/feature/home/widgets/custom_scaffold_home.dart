import 'package:edu_bridge_app/core/resources/export.dart';
import 'package:edu_bridge_app/feature/profile/view/fetch_user_profile_view.dart';

class CustomScaffoldHome extends StatelessWidget {
  final String? name;
  final Widget body;
  final Widget? floatingActionButton;
  final List<Widget>? actions;
  final String? email;

  const CustomScaffoldHome({
    super.key,
    this.name,
    required this.body,
    this.floatingActionButton,
    this.actions,
    this.email,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0, left: 16.0, right: 16.0),
          child: AppBar(
            backgroundColor: AppColors.bg,
            elevation: 0,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: name ?? 'hi_there'.tr,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
                CustomText(
                  text: 'search_prompt'.tr,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: AppColors.blackGray,
                ),
              ],
            ),
            actions: [
              ...?actions,
            ],
          ),
        ),
      ),
      backgroundColor: AppColors.bg,
      body: body,
      floatingActionButton: floatingActionButton,
      endDrawer: _buildDrawer(context),
    );
  }

  Drawer _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Colors.white),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  text: name ?? 'user_email'.tr,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.blackGray,
                ),
                CustomText(
                  text: email ?? "",
                  fontSize: 16,
                  color: AppColors.blackGray,
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: CustomText(text: 'your_profile'.tr),
            onTap: () {
              Get.to(() => const FetchUserProfileView());
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: CustomText(text: 'sign_out'.tr),
            onTap: () async {
              final supabase = Supabase.instance.client;
              await supabase.auth.signOut();
              Get.offAll(const SignInView());
            },
          ),
        ],
      ),
    );
  }
}
