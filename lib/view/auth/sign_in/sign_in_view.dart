import 'package:edu_bridge_app/resources/export.dart';
import 'package:edu_bridge_app/utils/centered_app_logo.dart';
import 'package:edu_bridge_app/utils/custom_header_text.dart';
import 'package:edu_bridge_app/utils/custom_spacing.dart';
import 'package:edu_bridge_app/utils/custom_text_field.dart';
import 'package:edu_bridge_app/utils/validators.dart';
import 'package:edu_bridge_app/view/auth/sign_in/widget/forgot_password_text_button.dart';
import 'package:edu_bridge_app/view/auth/sign_in/widget/sign_in_button.dart';
import 'package:edu_bridge_app/view/auth/sign_in/widget/sign_up_text_button=.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: Padding(
        padding: const EdgeInsets.all(35.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //Logo
                const CenteredAppLogo(),
                //Header Text
                const CustomHeaderText(
                  text1: "Let’s Sign In.!",
                  text2: "Login to Your Account to Continue your Courses",
                ),
                VerticalSpacing(3.h),
                //Text field
                CustomTextFormField(
                  labelText: "Email",
                  controller: _emailController,
                  validator: Validators.emailValidator,
                ),
                VerticalSpacing(2.h),
                CustomTextFormField(
                  labelText: "Password",
                  controller: _passwordController,
                  obscureText: true,
                  validator: Validators.passwordValidator,
                ),
                VerticalSpacing(2.h),

                //Forgot Password Text Button
                const ForgotPasswordTextButton(),
                VerticalSpacing(2.h),

                //SignInButton
                SignInButton(
                  formKey: _formKey,
                  emailController: _emailController,
                  passwordController: _passwordController,
                ),
                VerticalSpacing(2.h),
                const SignUpTextButton()
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
