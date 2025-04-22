import 'package:edu_bridge_app/core/resources/export.dart';
import 'package:edu_bridge_app/feature/profile/widgets/profile_avatar.dart';
import 'package:edu_bridge_app/feature/profile/widgets/profile_info.dart';
import 'package:edu_bridge_app/feature/profile/widgets/profile_options.dart';

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
      try {
        await profileController.fetchUserProfile(email);
      } catch (e) {
        SnackBarUtil.showError("Error fetching user profile: $e", "$e");
      }
    } else {
      SnackBarUtil.showError("User is not logged in.", "");
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      name: 'Your Profile',
      body: GetBuilder<UserProfileController>(builder: (controller) {
        if (controller.inProgress) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.userProfile != null) {
          final profile = controller.userProfile!;
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
                  ProfileAvatar(profile: profile),
                  ProfileInfo(profile: profile),
                  const SizedBox(height: 24),
                  ...buildProfileOptions(
                      context), // Use the imported function here
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
      }),
    );
  }
}
