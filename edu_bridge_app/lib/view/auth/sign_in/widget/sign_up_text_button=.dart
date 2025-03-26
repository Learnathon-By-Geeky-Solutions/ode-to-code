import 'package:edu_bridge_app/resources/export.dart';
import 'package:edu_bridge_app/view/auth/sign_up/sign_up_view.dart';
import 'package:edu_bridge_app/view/user/user_profile_view.dart';

class SignUpTextButton extends StatelessWidget {
  const SignUpTextButton({super.key});

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
            text: 'Sign Up',
            style: TextStyle(color: AppColors.themeColor),
            recognizer: TapGestureRecognizer()
              ..onTap = () => Get.to(() => UserProfileView()),
          ),
        ],
      ),
    );
  }
}
