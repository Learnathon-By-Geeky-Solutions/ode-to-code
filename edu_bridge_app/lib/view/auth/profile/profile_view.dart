import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_bridge_app/resources/export.dart';
import 'package:edu_bridge_app/utils/custom_scaffold.dart';
import 'package:edu_bridge_app/utils/custom_spacing.dart';
import 'package:edu_bridge_app/utils/custom_text_button.dart';
import 'package:edu_bridge_app/view/auth/profile/edit_profile_view.dart';
import 'package:edu_bridge_app/view/auth/sign_in/Sign_In_view.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  String _fullName = "Loading...";
  String _email = "Loading...";
  String? _profileImageUrl;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _fetchUserProfile();
  }

  /// Fetch user profile data from Firestore
  Future<void> _fetchUserProfile() async {
    String userId = _auth.currentUser!.uid;
    DocumentSnapshot userDoc =
        await _firestore.collection('users').doc(userId).get();

    if (userDoc.exists) {
      Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
      setState(() {
        _fullName = userData['fullName'] ?? "No Name";
        _email = userData['email'] ?? "No Email";
        _profileImageUrl = userData['profileImageUrl']; // Profile Image
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: "Profile",
      body: Center(
        child: Container(
          width: 360,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: AppColors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                // Profile Image
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey[300],
                  backgroundImage:
                      _profileImageUrl != null && _profileImageUrl!.isNotEmpty
                          ? NetworkImage(_profileImageUrl!) as ImageProvider
                          : null, // Only sets background image if available
                  child: _profileImageUrl == null || _profileImageUrl!.isEmpty
                      ? const Icon(Icons.person, size: 50, color: Colors.grey)
                      : null, // Show icon if no image
                ),

                VerticalSpacing(0.5.h),

                // Name
                CustomText(
                    text: _fullName, fontSize: 18, fontWeight: FontWeight.bold),
                VerticalSpacing(0.5.h),

                // Email
                CustomText(
                    text: _email, fontSize: 14, color: AppColors.blackGray),
                VerticalSpacing(1.5.h),

                // Profile Options
                CustomTextButton(
                  title: "Edit Profile",
                  icon: Icons.person_outline,
                  onTap: () {
                    Get.to(() => EditProfileView());
                  },
                ),
                CustomTextButton(
                  title: "Notification",
                  icon: Icons.notifications_none_rounded,
                ),
                CustomTextButton(
                  title: "Dark Mode",
                  icon: Icons.remove_red_eye_outlined,
                ),
                CustomTextButton(
                  title: "Terms & Conditions",
                  icon: Icons.shield_outlined,
                ),
                CustomTextButton(
                  title: "Help Center",
                  icon: Icons.help_outline,
                ),
                CustomTextButton(
                  title: "Log Out",
                  icon: Icons.logout,
                  onTap: () async {
                    await FirebaseAuth.instance.signOut();
                    Get.snackbar('Logged Out', 'User successfully logged out',
                        snackPosition: SnackPosition.TOP);
                    Get.offAll(const SignInView());
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
