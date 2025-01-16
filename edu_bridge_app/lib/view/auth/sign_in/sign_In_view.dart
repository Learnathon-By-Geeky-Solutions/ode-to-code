import 'package:edu_bridge_app/resources/export.dart';
import 'package:edu_bridge_app/view/auth/forgot_password/forget_password_view.dart';
import 'package:edu_bridge_app/view/auth/sign_up/sign_up_view.dart';
import 'package:edu_bridge_app/view_model/auth/forgot_password_controller.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final emailTEController = TextEditingController();
  final passwordTEController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final ForgotPasswordController forgotPasswordController =
      Get.put(ForgotPasswordController());
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
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 15.h),
                Image.asset(AssetsPath.appLogo),
                SizedBox(height: 1.h),
                Align(
                  alignment: Alignment.topLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomText(
                        text: "Let’s Sign In.!",
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                      CustomText(
                        text: "Login to Your Account to Continue your Courses",
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: AppColors.blackGray,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 3.h),
                buildTextFormField(
                  "Email",
                  controller: emailTEController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!RegExp(r"^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]+")
                        .hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 2.h),
                buildTextFormField(
                  "Password",
                  controller: passwordTEController,
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 2.h),
                Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () async {
                      Get.to(ForgotPasswordView());
                    },
                    child: CustomText(
                      text: "Forget Password",
                      fontWeight: FontWeight.w900,
                      fontSize: 16,
                      color: AppColors.blackGray,
                    ),
                  ),
                ),
                SizedBox(height: 2.h),
                GetBuilder<SignInController>(
                  builder: (logInController) {
                    return Obx(() {
                      if (logInController.signInApiInProgress) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return CustomButton(
                        text: "Sign In",
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        onPressed: () async {
                          final email = emailTEController.text;
                          final password = passwordTEController.text;
                          if (_formKey.currentState!.validate()) {
                            bool isSuccess =
                                await logInController.logIn(email, password);
                            if (isSuccess) {
                              Get.offAll(PinVerificationView());
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
                ),
                SizedBox(height: 2.h),
                RichText(
                  text: TextSpan(
                    text: 'Don\'t have an account? ',
                    style: TextStyle(
                      color: AppColors.blackGray,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.4,
                    ),
                    children: [
                      TextSpan(
                        text: 'Sign Up',
                        style: TextStyle(color: AppColors.themeColor),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Get.to(SignUpView());
                          },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    emailTEController.dispose();
    passwordTEController.dispose();
    super.dispose();
  }

  // Reusable TextFormField
  Widget buildTextFormField(
    String labelText, {
    bool obscureText = false,
    String? Function(String?)? validator,
    required TextEditingController controller,
  }) {
    return TextFormField(
      obscureText: obscureText,
      validator: validator,
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      ),
    );
  }
}
