import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_bridge_app/resources/export.dart';
import 'package:edu_bridge_app/view/admin/admin_content_post/admin_content_post_view.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import the admin screen

class AdminSignInButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const AdminSignInButton({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignInController>(
      builder: (logInController) {
        return Obx(() {
          if (logInController.signInApiInProgress) {
            return const Center(child: CircularProgressIndicator());
          }
          return CustomButton(
            text: "Admin Sign In",
            fontSize: 18,
            fontWeight: FontWeight.bold,
            onPressed: () async {
              final email = emailController.text;
              final password = passwordController.text;

              if (formKey.currentState!.validate()) {
                bool isSuccess = await logInController.logIn(email, password);

                if (isSuccess) {
                  try {
                    User? user = FirebaseAuth.instance.currentUser;

                    if (user != null) {
                      DocumentSnapshot userDoc = await FirebaseFirestore
                          .instance
                          .collection('users')
                          .doc(user.uid)
                          .get();

                      if (userDoc.exists && userDoc['isAdmin'] == true) {
                        Get.offAll(() =>
                            AdminContentPostView()); // Navigate to admin screen
                      } else {
                        Get.snackbar(
                          'Access Denied',
                          'This is not an admin account.',
                          backgroundColor: Colors.red,
                          colorText: Colors.white,
                        );
                      }
                    }
                  } catch (e) {
                    Get.snackbar(
                      'Error',
                      'Failed to verify admin status. Please try again.',
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                    );
                  }
                } else {
                  Get.snackbar(
                    'Error',
                    logInController.errorMessage,
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                  );
                }
              }
            },
            backgroundColor: AppColors.themeColor,
            textColor: Colors.white,
            icon: Icons.arrow_forward,
            buttonType: ButtonType.elevated,
          );
        });
      },
    );
  }
}
