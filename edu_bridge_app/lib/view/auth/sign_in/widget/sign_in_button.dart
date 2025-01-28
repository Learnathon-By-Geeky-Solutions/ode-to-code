import 'package:edu_bridge_app/resources/export.dart';
import 'package:edu_bridge_app/view/home/home_view.dart';

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
      builder: (logInController) {
        return Obx(() {
          if (logInController.signInApiInProgress) {
            return const Center(child: CircularProgressIndicator());
          }
          return CustomButton(
            text: "Sign In",
            fontSize: 18,
            fontWeight: FontWeight.bold,
            onPressed: () async {
              final email = emailController.text;
              final password = passwordController.text;
              print(email);
              print(password);
              if (formKey.currentState!.validate()) {
                bool isSuccess = await logInController.logIn(email, password);
                if (isSuccess) {
                  Get.offAll(HomeView());
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
