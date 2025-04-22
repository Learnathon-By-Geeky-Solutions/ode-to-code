import 'package:edu_bridge_app/core/resources/export.dart';

class AboutUser extends StatefulWidget {
  const AboutUser({super.key});

  @override
  State<AboutUser> createState() => _AboutUserState();
}

class _AboutUserState extends State<AboutUser> {
  final UserProfileController profileController =
      Get.find<UserProfileController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchProfileData();
    });
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
      name: "User Profile",
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GetBuilder<UserProfileController>(
          builder: (controller) {
            if (controller.inProgress) {
              return const Center(child: CircularProgressIndicator());
            } else if (controller.userProfile == null) {
              return Center(
                child: CustomText(
                  text: "no_content_available".tr,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              );
            } else {
              final user = controller.userProfile!;
              return Center(
                child: ListView(
                  children: [
                    Center(
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(user.image),
                      ),
                    ),
                    Column(
                      children: [
                        const SizedBox(height: 20),
                        CustomText(text: "Name: ${user.name}", fontSize: 16),
                        CustomText(text: "Email: ${user.email}", fontSize: 16),
                        CustomText(
                            text: "What You Do: ${user.whatYouDo}",
                            fontSize: 16),
                        CustomText(
                            text: "Account Type: ${user.accountType}",
                            fontSize: 16),
                        CustomText(
                            text: "Date of Birth: ${user.dateOfBirth}",
                            fontSize: 16),
                        CustomText(
                            text: "Gender: ${user.gender}", fontSize: 16),
                      ],
                    )
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
