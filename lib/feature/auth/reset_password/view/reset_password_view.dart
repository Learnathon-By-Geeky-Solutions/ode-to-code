import 'package:edu_bridge_app/core/export.dart';

class ResetPasswordView extends StatefulWidget {
  const ResetPasswordView({super.key});

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(35.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const CenteredAppLogo(),
                CustomHeaderText(
                  text1: "update_your_password".tr,
                  text2: "enter_new_password".tr,
                ),
                VerticalSpacing(3.h),
                _buildPasswordFields(),
                VerticalSpacing(3.h),
                _buildSubmitButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordFields() {
    return Column(
      children: [
        CustomTextFormField(
          labelText: "New Password".tr,
          controller: _passwordController,
          validator: Validators.passwordValidator,
          obscureText: true,
        ),
        VerticalSpacing(2.h),
        CustomTextFormField(
          labelText: "Confirm Password".tr,
          controller: _confirmPasswordController,
          validator: _confirmPasswordValidator,
          obscureText: true,
        ),
      ],
    );
  }

  String? _confirmPasswordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "please_enter_confirm_password".tr;
    }
    if (value != _passwordController.text) {
      return "passwords_do_not_match".tr;
    }
    return null;
  }

  Widget _buildSubmitButton() {
    return GetBuilder<ResetPasswordController>(
      builder: (controller) {
        return Visibility(
          visible: !controller.inProgress,
          replacement: const CircularProgressIndicator(),
          child: CustomButton(
            text: "update_password".tr,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            onPressed: () => _updatePassword(controller),
            backgroundColor: AppColors.themeColor,
            textColor: AppColors.white,
            icon: Icons.lock_reset,
            buttonType: ButtonType.elevated,
          ),
        );
      },
    );
  }

  Future<void> _updatePassword(ResetPasswordController controller) async {
    if (_formKey.currentState?.validate() ?? false) {
      await controller.updatePassword(_passwordController.text.trim());
    }
  }
}
