import 'package:edu_bridge_app/resources/export.dart';
import 'package:edu_bridge_app/view/admin/admin_sign_up/admin_sign_up_view.dart';

class AdminSignUpTextButton extends StatelessWidget {
  const AdminSignUpTextButton({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: 'Don\'t have an account? ',
        style: const TextStyle(
          color: AppColors.blackGray,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.4,
        ),
        children: [
          TextSpan(
            text: 'Admin Sign Up',
            style: TextStyle(color: AppColors.themeColor),
            recognizer: TapGestureRecognizer()
              ..onTap = () => Get.to(() => AdminSignUpView()),
          ),
        ],
      ),
    );
  }
}
