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
    return CustomButton(
      text: "Sign Up",
      fontSize: 18,
      fontWeight: FontWeight.bold,
      onPressed: () {
        if (!_formKey.currentState!.validate()) {
          return; // Exit if form is invalid
        }

        // Get the latest values of email and password
        final email = emailTEController.text;
        final password = passwordTEController.text;

        // Navigate to Sign In screen (Sign up logic should be handled separately)
        Get.offAll(const SignInView());
      },
      backgroundColor: AppColors.themeColor,
      textColor: Colors.white,
      icon: Icons.arrow_forward,
      buttonType: ButtonType.elevated,
    );
  }
}
