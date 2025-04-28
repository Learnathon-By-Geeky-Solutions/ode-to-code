import 'package:edu_bridge_app/core/export.dart';

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
            style: const TextStyle(color: AppColors.themeColor),
            recognizer: TapGestureRecognizer()
              ..onTap = () => Get.to(() => const UserProfileView()),
          ),
        ],
      ),
    );
  }
}
