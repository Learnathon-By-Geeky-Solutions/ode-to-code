import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:edu_bridge_app/view_model/user_profile_controller.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
    final session = supabase.auth.currentSession;
    final email = session?.user.email ?? '';
    if (email.isNotEmpty) {
      await profileController.fetchUserProfile(email);
    } else {
      profileController.errorMessage;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Profile'),
        centerTitle: true,
        elevation: 1,
      ),
      body: GetBuilder<UserProfileController>(
        builder: (controller) {
          if (controller.inProgress) {
            return const Center(child: CircularProgressIndicator());
          } else if (controller.userProfile != null) {
            final profile = controller.userProfile!;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: CircleAvatar(
                      radius: 55,
                      backgroundColor: Colors.grey.shade200,
                      backgroundImage: profile.image != null
                          ? NetworkImage(profile.image!)
                          : const AssetImage('assets/images/default_avatar.png')
                              as ImageProvider,
                    ),
                  ),
                  const SizedBox(height: 25),
                  ProfileField(title: 'Name', value: profile.name),
                  ProfileField(title: 'Email', value: profile.email),
                  ProfileField(title: 'What You Do', value: profile.whatYouDo),
                  ProfileField(
                      title: 'Account Type', value: profile.accountType),
                  ProfileField(
                      title: 'Date of Birth', value: profile.dateOfBirth),
                  ProfileField(title: 'Gender', value: profile.gender),
                ],
              ),
            );
          } else if (controller.errorMessage != null) {
            return Center(
              child: Text(
                controller.errorMessage!,
                style: const TextStyle(color: Colors.red, fontSize: 16),
              ),
            );
          } else {
            return const Center(
              child: Text(
                'No user profile found.',
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            );
          }
        },
      ),
    );
  }
}

class ProfileField extends StatelessWidget {
  final String title;
  final String value;

  const ProfileField({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$title: ',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
