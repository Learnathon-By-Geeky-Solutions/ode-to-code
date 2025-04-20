import 'package:edu_bridge_app/core/resources/export.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: Padding(
        padding: const EdgeInsets.all(35.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CenteredAppLogo(),
                CustomHeaderText(
                  text1: "lets_sign_in".tr,
                  text2: "login_to_continue".tr, // Add key in localization
                ),
                VerticalSpacing(3.h),
                CustomTextFormField(
                  labelText: "Email".tr,
                  controller: _emailController,
                  validator: Validators.emailValidator,
                ),
                VerticalSpacing(2.h),
                CustomTextFormField(
                  labelText: "Password".tr,
                  controller: _passwordController,
                  obscureText: true,
                  validator: Validators.passwordValidator,
                ),
                VerticalSpacing(2.h),
                const ForgotPasswordTextButton(),
                VerticalSpacing(2.h),
                GetBuilder<SignInController>(builder: (controller) {
                  return Visibility(
                    visible: !controller.inProgress,
                    replacement: const CircularProgressIndicator(),
                    child: CustomButton(
                      text: "Sign In",
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      onPressed: () => _handleSignIn(controller),
                      backgroundColor: AppColors.themeColor,
                      textColor: Colors.white,
                      icon: Icons.arrow_forward,
                      buttonType: ButtonType.elevated,
                    ),
                  );
                }),
                VerticalSpacing(2.h),
                const SignUpTextButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _handleSignIn(SignInController controller) async {
    if (_formKey.currentState?.validate() ?? false) {
      final success = await controller.signIn(
        _emailController.text,
        _passwordController.text,
      );
      if (success) {
        Get.offAll(() => MainBottomNavView());
      }
    }
  }
}
