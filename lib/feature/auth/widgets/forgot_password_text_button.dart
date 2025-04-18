import 'package:edu_bridge_app/core/resources/export.dart';

class ForgotPasswordTextButton extends StatelessWidget {
  const ForgotPasswordTextButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: GestureDetector(
        onTap: () => Get.to(() => const ForgotPasswordView()),
        child: CustomText(
          text: 'forget_password'.tr,
          fontWeight: FontWeight.w900,
          fontSize: 16,
          color: AppColors.blackGray,
        ),
      ),
    );
  }
}
