import 'package:edu_bridge_app/resources/export.dart';
import 'package:edu_bridge_app/view/admin/admin_sign_in/admin_sign_in_view.dart';

class AdminSignInTextButton extends StatelessWidget {
  const AdminSignInTextButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: 'Already have an account? ',
        style: TextStyle(
          color: AppColors.blackGray,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.4,
        ),
        children: [
          TextSpan(
            text: 'Admin Sign In',
            style: TextStyle(color: AppColors.themeColor),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Get.to(() => AdminSignInView());
              },
          ),
        ],
      ),
    );
  }
}
