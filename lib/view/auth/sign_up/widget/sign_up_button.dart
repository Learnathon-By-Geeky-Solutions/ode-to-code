import 'package:edu_bridge_app/resources/export.dart';
import 'package:edu_bridge_app/view/auth/sign_in/sign_in_view.dart';
import 'package:edu_bridge_app/view_model/auth/sign_up_controller.dart';

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
      builder: (controller) {
        return CustomButton(
          text: "Sign Up",
          fontSize: 18,
          fontWeight: FontWeight.bold,
          onPressed: () async {
            if (!_formKey.currentState!.validate()) {
              return; // Exit if form is invalid
            }

            final email = emailTEController.text;
            final password = passwordTEController.text;

            // Call sign-up logic from SignUpController
            bool success = await controller.signUp(email, password);

            if (success) {
              // Navigate to Sign In screen after successful sign-up
              Get.offAll(const SignInView());
            }
          },
          backgroundColor: AppColors.themeColor,
          textColor: Colors.white,
          icon: Icons.arrow_forward,
          buttonType: ButtonType.elevated,
        );
      },
    );
  }
}
