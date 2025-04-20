import 'package:edu_bridge_app/core/resources/export.dart';

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
        return Visibility(
          visible: !controller.inProgress,
          replacement: const CircularProgressIndicator(),
          child: CustomButton(
            text: "sign_up".tr,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            onPressed: () => _handleSignUp(controller),
            backgroundColor: AppColors.themeColor,
            textColor: Colors.white,
            icon: Icons.arrow_forward,
            buttonType: ButtonType.elevated,
          ),
        );
      },
    );
  }

  Future<void> _handleSignUp(SignUpController controller) async {
    if (!_formKey.currentState!.validate()) return;

    final email = emailTEController.text.trim();
    final password = passwordTEController.text.trim();

    final success = await controller.signUp(email, password);
    if (success) {
      Get.offAll(const SignInView());
    }
  }
}
