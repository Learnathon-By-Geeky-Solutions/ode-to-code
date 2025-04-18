import 'package:edu_bridge_app/core/resources/export.dart';

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
      onPressed: _handleForgotPassword,
      backgroundColor: AppColors.themeColor,
      textColor: Colors.white,
      icon: Icons.arrow_forward,
      buttonType: ButtonType.elevated,
    );
  }

  void _handleForgotPassword() {
    final email = _emailTEController.text.trim();

    if (email.isEmpty) {
      _showSnackbar('Error', 'Please enter your email to reset the password.',
          Colors.red);
    } else {
      _showSnackbar('Success',
          'A password reset link has been sent to your email.', Colors.green);
    }
  }

  void _showSnackbar(String title, String message, Color bgColor) {
    Get.snackbar(
      title,
      message,
      backgroundColor: bgColor,
      colorText: Colors.white,
    );
  }
}
