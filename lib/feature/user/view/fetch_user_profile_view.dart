import 'package:edu_bridge_app/core/resources/export.dart';

class FetchUserProfileView extends StatefulWidget {
  const FetchUserProfileView({super.key});

  @override
  State<FetchUserProfileView> createState() => _FetchUserProfileViewState();
}

class _FetchUserProfileViewState extends State<FetchUserProfileView> {
  final UserProfileController profileController =
      Get.find<UserProfileController>();

  @override
  void initState() {
    super.initState();
    fetchProfileData();
  }

  void fetchProfileData() async {
    final supabase = Supabase.instance.client;
    final email = supabase.auth.currentSession?.user.email ?? '';
    if (email.isNotEmpty) {
      await profileController.fetchUserProfile(email);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      name: 'Your Profile',
      body: GetBuilder<UserProfileController>(
        builder: (controller) {
          if (controller.inProgress) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.userProfile != null) {
            final profile = controller.userProfile!;

            final List<Map<String, dynamic>> options = [
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
                "onTap": () {
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: CustomText(text: 'select_language'.tr),
                      content: const LanguageSwitch(),
                    ),
                  );
                },
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
                },
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

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: AppColors.bgWhite,
                ),
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    const SizedBox(height: 16),
                    Center(
                      child: Container(
                        height: 110,
                        width: 110,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.green, width: 4),
                          color: Colors.greenAccent,
                        ),
                        child: CircleAvatar(
                          backgroundImage: profile.image != null
                              ? NetworkImage(profile.image!)
                              : const AssetImage(
                                      'assets/images/default_avatar.png')
                                  as ImageProvider,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Center(child: CustomText(text: profile.name)),
                    Center(child: CustomText(text: profile.email)),
                    const SizedBox(height: 24),
                    ...options.map((item) => buildCard(
                          item["title"],
                          item["icon"],
                          Icons.arrow_forward_ios,
                          item["onTap"],
                        )),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            );
          }

          if (controller.errorMessage != null) {
            return Center(
              child: CustomText(
                text: controller.errorMessage!,
                customStyle: const TextStyle(color: Colors.red, fontSize: 16),
              ),
            );
          }

          return Center(
            child: CustomText(
              text: 'no_user_profile_found'.tr,
              color: Colors.grey,
              fontSize: 16,
            ),
          );
        },
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
