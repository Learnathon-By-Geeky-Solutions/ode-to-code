import 'package:edu_bridge_app/core/resources/export.dart';

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
    return GetBuilder<SignInController>(
      builder: (controller) {
        return CustomButton(
          text: "Sign In",
          fontSize: 18,
          fontWeight: FontWeight.bold,
          onPressed: () => _handleSignIn(controller),
          backgroundColor: AppColors.themeColor,
          textColor: Colors.white,
          icon: Icons.arrow_forward,
          buttonType: ButtonType.elevated,
        );
      },
    );
  }

  Future<void> _handleSignIn(SignInController controller) async {
    if (formKey.currentState?.validate() ?? false) {
      final success = await controller.signIn(
        emailController.text,
        passwordController.text,
      );
      if (success) {
        Get.offAll(() => MainBottomNavView());
      }
    }
  }
}
