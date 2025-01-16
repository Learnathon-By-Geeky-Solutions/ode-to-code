import 'package:edu_bridge_app/resources/export.dart';
import 'package:edu_bridge_app/view/auth/forgot_password/forget_password_view.dart';

class ForgotPasswordTextButton extends StatelessWidget {
  const ForgotPasswordTextButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: GestureDetector(
        onTap: () => Get.to(const ForgotPasswordView()),
        child: const CustomText(
          text: "Forget Password",
          fontWeight: FontWeight.w900,
          fontSize: 16,
          color: AppColors.blackGray,
        ),
      ),
    );
  }
}
