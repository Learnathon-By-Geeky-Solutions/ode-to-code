import 'package:edu_bridge_app/resources/export.dart';
import 'package:edu_bridge_app/view/home/home_view.dart';
import 'package:edu_bridge_app/view_model/auth/sign_in_controller.dart';

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
          onPressed: () async {
            if (formKey.currentState?.validate() ?? false) {
              bool success = await controller.signIn(
                emailController.text,
                passwordController.text,
              );
              if (success) {
                Get.offAll(() => HomeView());
              }
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
