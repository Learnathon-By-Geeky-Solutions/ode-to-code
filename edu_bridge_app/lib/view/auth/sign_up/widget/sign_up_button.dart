import 'package:edu_bridge_app/resources/export.dart';
import 'package:edu_bridge_app/view/auth/sign_in/Sign_In_view.dart';

class SignUpButton extends StatelessWidget {
  const SignUpButton({
    super.key,
    required GlobalKey<FormState> formKey,
    required this.emailTEController,
    required this.passwordTEController,
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;
  final TextEditingController emailTEController;
  final TextEditingController passwordTEController;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignUpController>(
      builder: (signUpController) {
        return Obx(() {
          if (signUpController.signUpApiInProgress) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return CustomButton(
            text: "Sign Up",
            fontSize: 18,
            fontWeight: FontWeight.bold,
            onPressed: () async {
              if (!_formKey.currentState!.validate()) {
                return; // Exit if form is invalid
              }

              // Get the latest values of email and password
              final email = emailTEController.text;
              final password = passwordTEController.text;

              // Attempt to sign in
              final isSuccess = await signUpController.signUp(email, password);
              if (isSuccess) {
                Get.offAll(const SignInView());
              } else {
                Get.snackbar(
                  'Error',
                  signUpController.errorMessage,
                  backgroundColor: Colors.red,
                  colorText: Colors.white,
                  snackPosition: SnackPosition.BOTTOM,
                  duration: const Duration(seconds: 3),
                );
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
