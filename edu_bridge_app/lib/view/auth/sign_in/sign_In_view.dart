import 'package:edu_bridge_app/resources/export.dart';
import 'package:edu_bridge_app/utils/custom_spacing.dart';
import 'package:edu_bridge_app/utils/custom_text_field.dart';
import 'package:edu_bridge_app/utils/validators.dart';
import 'package:edu_bridge_app/view/auth/sign_in/widget/forgot_password_text_button.dart';
import 'package:edu_bridge_app/view/auth/sign_in/widget/sign_in_button_builder.dart';
import 'package:edu_bridge_app/view/auth/sign_in/widget/sign_up_text_button.dart';

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
                _buildLogo(),
                //Header Text
                _buildHeader(),
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
                SignInButtonBuilder(
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

  Widget _buildLogo() {
    return Column(
      children: [
        SizedBox(height: 15.h),
        Image.asset(AssetsPath.appLogo),
        SizedBox(height: 1.h),
      ],
    );
  }

  Widget _buildHeader() {
    return const Align(
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          CustomText(
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
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
