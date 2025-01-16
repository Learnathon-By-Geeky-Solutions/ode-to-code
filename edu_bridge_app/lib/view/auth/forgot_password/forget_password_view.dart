import 'package:edu_bridge_app/resources/export.dart';
import 'package:edu_bridge_app/view_model/auth/forgot_password_controller.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final emailTEController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final ForgotPasswordController forgotPasswordController =
      ForgotPasswordController();
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
                        text: "Forgot your password?",
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                      CustomText(
                        text:
                            "Don’t worry! Enter your email to reset it and get back on track.",
                        fontWeight: FontWeight.w600,
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
                CustomButton(
                  text: "Forgot Password",
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  onPressed: () async {
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
                        await forgotPasswordController.sendPasswordReset(email);
                    if (isSuccess) {
                      Get.snackbar(
                        'Success',
                        'A password reset link has been sent to your email.',
                        backgroundColor: Colors.green,
                        colorText: Colors.white,
                      );
                    }
                  },
                  backgroundColor: AppColors.themeColor,
                  textColor: Colors.white,
                  icon: Icons.arrow_forward,
                  buttonType: ButtonType.elevated,
                )
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
