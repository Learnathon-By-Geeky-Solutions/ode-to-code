import 'package:edu_bridge_app/core/resources/export.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final _emailTEController = TextEditingController();
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
                  text1: "Forgot your password?",
                  text2:
                      "Don’t worry! Enter your email to reset it and get back on track.",
                ),
                VerticalSpacing(2.h),
                CustomTextFormField(
                  labelText: "Email",
                  controller: _emailTEController,
                  validator: Validators.emailValidator,
                ),
                VerticalSpacing(2.h),
                ForgotPasswordButton(
                  emailTEController: _emailTEController,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    super.dispose();
  }
}
