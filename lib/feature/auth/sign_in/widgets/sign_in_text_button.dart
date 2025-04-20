import 'package:edu_bridge_app/core/resources/export.dart';

class SignInTextButton extends StatelessWidget {
  const SignInTextButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: 'Already have an account? ',
        style: const TextStyle(
          color: AppColors.blackGray,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.4,
        ),
        children: [
          TextSpan(
            text: 'Sign In',
            style: const TextStyle(color: AppColors.themeColor),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Get.to(const SignInView());
              },
          ),
        ],
      ),
    );
  }
}
