import 'package:edu_bridge_app/core/resources/export.dart';

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
  void dispose() {
    _emailTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }

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
                /// Logo
                const CenteredAppLogo(),

                /// Header Text
                CustomHeaderText(
                  text1: "getting_started".tr, // Add in localization
                  text2: "create_account_continue".tr, // Add in localization
                ),
                VerticalSpacing(2.h),

                /// Email Field
                CustomTextFormField(
                  labelText: "email".tr,
                  controller: _emailTEController,
                  validator: Validators.emailValidator,
                ),
                VerticalSpacing(2.h),

                /// Password Field
                CustomTextFormField(
                  labelText: "password".tr,
                  controller: _passwordTEController,
                  obscureText: true,
                  validator: Validators.passwordValidator,
                ),
                VerticalSpacing(2.h),

                /// Sign Up Button
                SignUpButton(
                  formKey: _formKey,
                  emailTEController: _emailTEController,
                  passwordTEController: _passwordTEController,
                ),
                VerticalSpacing(2.h),

                /// Sign In Redirect
                const SignInTextButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
