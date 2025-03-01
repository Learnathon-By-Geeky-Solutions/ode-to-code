import 'package:edu_bridge_app/resources/export.dart';

class SignInButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const SignInButton({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      text: "Sign In",
      fontSize: 18,
      fontWeight: FontWeight.bold,
      onPressed: () {
        // No logic here, just keeping the UI
      },
      backgroundColor: AppColors.themeColor,
      textColor: Colors.white,
      icon: Icons.arrow_forward,
      buttonType: ButtonType.elevated,
    );
  }
}
