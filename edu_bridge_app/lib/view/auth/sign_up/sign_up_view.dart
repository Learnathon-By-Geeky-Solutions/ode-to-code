import 'package:edu_bridge_app/resources/export.dart';
import 'package:edu_bridge_app/utils/centered_app_logo.dart';
import 'package:edu_bridge_app/utils/custom_header_text.dart';
import 'package:edu_bridge_app/utils/custom_spacing.dart';
import 'package:edu_bridge_app/utils/custom_text_field.dart';
import 'package:edu_bridge_app/utils/validators.dart';
import 'package:edu_bridge_app/view/auth/sign_up/widget/sign_in_text_button.dart';
import 'package:edu_bridge_app/view/auth/sign_up/widget/sign_up_button.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final _emailTEController = TextEditingController();
  final _passwordTEController = TextEditingController();
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
                const CenteredAppLogo(),
                const CustomHeaderText(
                  text1: "Getting Started.!",
                  text2: "Create an Account to Continue your all Courses",
                ),
                VerticalSpacing(2.h),
                CustomTextFormField(
                  labelText: "Email",
                  controller: _emailTEController,
                  validator: Validators.emailValidator,
                ),
                VerticalSpacing(2.h),
                CustomTextFormField(
                  labelText: "Password",
                  controller: _passwordTEController,
                  obscureText: true,
                  validator: Validators.passwordValidator,
                ),
                VerticalSpacing(2.h),
                SignUpButton(
                  formKey: _formKey,
                  emailTEController: _emailTEController,
                  passwordTEController: _passwordTEController,
                ),
                VerticalSpacing(2.h),
                const SignInTextButton(),
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
    _emailTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }
}
