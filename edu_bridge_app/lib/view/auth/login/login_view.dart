import 'package:edu_bridge_app/resources/export.dart';
import 'package:edu_bridge_app/view_model/auth/forgot_password_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
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
                      final email = emailTEController.text;
                      if (email.isEmpty) {
                        Get.snackbar(
                          'Error',
                          'Please enter your email to reset the password.',
                          backgroundColor: Colors.red,
                          colorText: Colors.white,
                        );
                        return;
                      }
                      bool isSuccess =
                          await forgotPasswordController.forgotPassword(email);
                      if (isSuccess) {
                        Get.snackbar(
                          'Success',
                          'A password reset link has been sent to your email.',
                          backgroundColor: Colors.green,
                          colorText: Colors.white,
                        );
                      }
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
                GetBuilder<LogInController>(
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
                        recognizer: TapGestureRecognizer()..onTap = () {},
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

  signInWithGoogle() async {
    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.accessToken,
    );
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    print(userCredential.user?.displayName);
  }
}
