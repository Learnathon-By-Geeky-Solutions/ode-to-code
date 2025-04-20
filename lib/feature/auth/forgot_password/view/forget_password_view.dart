import 'package:edu_bridge_app/core/resources/export.dart';
import 'package:edu_bridge_app/core/services/auth_service/deep_link_service.dart';
import 'package:edu_bridge_app/feature/auth/forgot_password/view_model/forget_password_controller.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final _emailTEController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailTEController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DeepLinkService.configure();
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CenteredAppLogo(),
                CustomHeaderText(
                  text1: "forgot_password_title".tr,
                  text2: "forgot_password_subtitle".tr,
                ),
                VerticalSpacing(3.h),
                CustomTextFormField(
                  labelText: "Email".tr,
                  controller: _emailTEController,
                  validator: Validators.emailValidator,
                ),
                VerticalSpacing(3.h),
                GetBuilder<ForgotPasswordController>(
                  builder: (controller) {
                    return Visibility(
                      visible: !controller.inProgress,
                      replacement: const CircularProgressIndicator(),
                      child: CustomButton(
                        text: "reset_password".tr,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        onPressed: () => _handleReset(controller),
                        backgroundColor: AppColors.themeColor,
                        textColor: Colors.white,
                        icon: Icons.refresh,
                        buttonType: ButtonType.elevated,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _handleReset(ForgotPasswordController controller) async {
    if (_formKey.currentState?.validate() ?? false) {
      await controller.sendPasswordResetEmail(
        _emailTEController.text.trim(),
      );
    }
  }
}
