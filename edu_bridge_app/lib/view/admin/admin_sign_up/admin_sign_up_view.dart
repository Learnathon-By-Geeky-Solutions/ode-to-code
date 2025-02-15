import 'package:edu_bridge_app/resources/export.dart';
import 'package:edu_bridge_app/utils/centered_app_logo.dart';
import 'package:edu_bridge_app/utils/custom_header_text.dart';
import 'package:edu_bridge_app/utils/custom_spacing.dart';
import 'package:edu_bridge_app/utils/custom_text_field.dart';
import 'package:edu_bridge_app/utils/validators.dart';
import 'package:edu_bridge_app/view/admin/admin_sign_up/widget/admin_sign_in_text_button.dart';
import 'package:edu_bridge_app/view/admin/admin_sign_up/widget/admin_sign_up_button.dart';

class AdminSignUpView extends StatefulWidget {
  const AdminSignUpView({super.key});

  @override
  State<AdminSignUpView> createState() => _AdminSignUpViewState();
}

class _AdminSignUpViewState extends State<AdminSignUpView> {
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
                  text1: "Getting Started with\nAdmin account.!",
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
                AdminSignUpButton(
                  formKey: _formKey,
                  emailTEController: _emailTEController,
                  passwordTEController: _passwordTEController,
                ),
                VerticalSpacing(2.h),
                AdminSignInTextButton(),
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
