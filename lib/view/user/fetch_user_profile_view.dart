import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:edu_bridge_app/view_model/user_profile_controller.dart';
import 'package:supabase_flutter/supabase_flutter.dart'; // Import your controller

class FetchUserProfileScreen extends StatefulWidget {
  const FetchUserProfileScreen({super.key});

  @override
  State<FetchUserProfileScreen> createState() => _FetchUserProfileScreenState();
}

class _FetchUserProfileScreenState extends State<FetchUserProfileScreen> {
  final UserProfileController profileController =
      Get.find<UserProfileController>();

  @override
  void initState() {
    super.initState();
    // Fetch profile data automatically when the screen is opened
    fetchProfileData();
  }

  // Method to fetch profile data
  void fetchProfileData() async {
    final supabase = Supabase.instance.client;
    final session = supabase.auth.currentSession;
    String email = session?.user.email ?? '';
    await profileController.fetchUserProfile(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
      ),
      body: GetBuilder<UserProfileController>(
        builder: (controller) {
          if (controller.inProgress) {
            // Show loading indicator while fetching data
            return Center(child: CircularProgressIndicator());
          } else if (controller.userProfile != null) {
            // Display fetched profile data
            final profile = controller.userProfile!;
            return SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (profile.image != null)
                    Center(
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(profile.image!),
                      ),
                    ),
                  SizedBox(height: 20),
                  Text('Name: ${profile.name}', style: TextStyle(fontSize: 16)),
                  SizedBox(height: 10),
                  Text('Email: ${profile.email}',
                      style: TextStyle(fontSize: 16)),
                  SizedBox(height: 10),
                  Text('What You Do: ${profile.whatYouDo}',
                      style: TextStyle(fontSize: 16)),
                  SizedBox(height: 10),
                  Text('Account Type: ${profile.accountType}',
                      style: TextStyle(fontSize: 16)),
                  SizedBox(height: 10),
                  Text('Date of Birth: ${profile.dateOfBirth}',
                      style: TextStyle(fontSize: 16)),
                  SizedBox(height: 10),
                  Text('Gender: ${profile.gender}',
                      style: TextStyle(fontSize: 16)),
                ],
              ),
            );
          } else if (controller.errorMessage != null) {
            // Show error message if fetching fails
            return Center(
              child: Text(
                controller.errorMessage!,
                style: TextStyle(color: Colors.red, fontSize: 16),
              ),
            );
          } else {
            // Show a message if no profile is found
            return Center(
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
