import 'package:edu_bridge_app/resources/export.dart';

class ForgotPasswordButton extends StatelessWidget {
  const ForgotPasswordButton({
    super.key,
    required TextEditingController emailTEController,
  }) : _emailTEController = emailTEController;

  final TextEditingController _emailTEController;

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      text: "Forgot Password",
      fontSize: 18,
      fontWeight: FontWeight.bold,
      onPressed: () {
        final email = _emailTEController.text;
        if (email.isEmpty) {
          Get.snackbar(
            'Error',
            'Please enter your email to reset the password.',
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
          return;
        }

        Get.snackbar(
          'Success',
          'A password reset link has been sent to your email.',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      },
      backgroundColor: AppColors.themeColor,
      textColor: Colors.white,
      icon: Icons.arrow_forward,
      buttonType: ButtonType.elevated,
    );
  }
}
