import 'package:edu_bridge_app/core/resources/export.dart';

class TestProfileScreen extends StatefulWidget {
  const TestProfileScreen({super.key});

  @override
  State<TestProfileScreen> createState() => _TestProfileScreenState();
}

class _TestProfileScreenState extends State<TestProfileScreen> {
  final UserProfileController _controller = Get.find();

  @override
  void initState() {
    super.initState();

    // Example: Fetching the profile for a given email
    _controller.fetchUserProfile("sakifrahman0981@gmail.com");
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
              return ListView(
                children: [
                  Center(
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(user.image),
                    ),
                  ),
                  const SizedBox(height: 20),
                  CustomText(text: "Name: ${user.name}", fontSize: 16),
                  CustomText(text: "Email: ${user.email}", fontSize: 16),
                  CustomText(text: "What You Do: ${user.whatYouDo}", fontSize: 16),
                  CustomText(text: "Account Type: ${user.accountType}", fontSize: 16),
                  CustomText(text: "Date of Birth: ${user.dateOfBirth}", fontSize: 16),
                  CustomText(text: "Gender: ${user.gender}", fontSize: 16),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
