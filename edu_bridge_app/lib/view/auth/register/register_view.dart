import 'package:edu_bridge_app/resources/export.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final emailTEController = TextEditingController();
  final passwordTEController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
                        text: "Getting Started.!",
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                      CustomText(
                        text: "Create an Account to Continue your all Courses",
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
                /*Align(
                  alignment: Alignment.topRight,
                  child: CustomText(
                    text: "Forget Password",
                    fontWeight: FontWeight.w900,
                    fontSize: 16,
                    color: AppColors.blackGray,
                  ),
                ),*/
                SizedBox(height: 2.h),
                GetBuilder<SignUpController>(
                  builder: (signUpController) {
                    return Visibility(
                      visible: !signUpController.signUpApiInProgress,
                      replacement:
                          const Center(child: CircularProgressIndicator()),
                      child: CustomButton(
                        text: "Sign Up",
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        onPressed: () async {
                          if (!_formKey.currentState!.validate()) {
                            return; // Exit if form is invalid
                          }

                          // Get the latest values of email and password
                          final email = emailTEController.text;
                          final password = passwordTEController.text;

                          // Attempt to sign in
                          final isSuccess =
                              await signUpController.signUp(email, password);
                          if (isSuccess) {
                            Get.offAll(const SignInView());
                          } else {
                            Get.snackbar(
                              'Error',
                              signUpController.errorMessage,
                              backgroundColor: Colors.red,
                              colorText: Colors.white,
                              snackPosition: SnackPosition.BOTTOM,
                              duration: const Duration(seconds: 3),
                            );
                          }
                        },
                        backgroundColor: AppColors.themeColor,
                        textColor: Colors.white,
                        icon: Icons.arrow_forward,
                        buttonType: ButtonType.elevated,
                      ),
                    );
                  },
                ),
                SizedBox(height: 2.h),
                CustomText(
                  text: "Or Continue with",
                  fontWeight: FontWeight.w900,
                  fontSize: 16,
                  color: AppColors.blackGray,
                ),
                SizedBox(height: 2.h),
                SizedBox(
                  width: 146,
                  height: 48,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SvgPicture.asset(
                        AssetsPath.google,
                        fit: BoxFit.cover,
                      ),
                      SvgPicture.asset(
                        AssetsPath.apple,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 5.h),
                RichText(
                  text: TextSpan(
                    text: 'Already have an account? ',
                    style: TextStyle(
                      color: AppColors.blackGray,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.4,
                    ),
                    children: [
                      TextSpan(
                        text: 'Sign In',
                        style: TextStyle(color: AppColors.themeColor),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Get.to(LoginView());
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

  Widget socialButton(String assetPath) {
    return InkWell(
      onTap: () {
        // Add logic for social login
      },
      child: SvgPicture.asset(
        assetPath,
        fit: BoxFit.cover,
      ),
    );
  }
}
