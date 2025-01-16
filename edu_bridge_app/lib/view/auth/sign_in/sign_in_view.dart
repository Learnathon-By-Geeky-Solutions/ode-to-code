import 'package:edu_bridge_app/resources/app_colors.dart';
import 'package:edu_bridge_app/resources/assets_path.dart';
import 'package:edu_bridge_app/utils/widgets/custom_text.dart';
import 'package:edu_bridge_app/view/auth/login/login_view.dart';
import 'package:edu_bridge_app/view/auth/register/register_view.dart';
import 'package:edu_bridge_app/view/auth/sign_in/widget/sign_in_option.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F9FF),
      body: Padding(
        padding: EdgeInsets.all(5.w), // Responsive padding
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "Let's you in",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.sp, // Responsive font size
                ),
              ),
              SizedBox(height: 2.h), // Spacing after title
              Container(
                width: 60.w, // Responsive width
                child: Column(
                  children: [
                    SignInOption(logo: AssetsPath.google, title: "Google"),
                    // Spacing between options
                    SignInOption(logo: AssetsPath.apple, title: "Apple"),
                  ],
                ),
              ),
              SizedBox(height: 2.h), // Spacing after options
              CustomText(
                text: " ( Or )",
                fontWeight: FontWeight.w700,
                fontSize: 17.sp,
              ),
              SizedBox(height: 3.h), // Spacing after divider
              buildElevatedButton(),
              SizedBox(height: 3.h), // Spacing after button
              RichText(
                text: TextSpan(
                  text: 'Don\'t have an account? ',
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.8),
                    fontWeight: FontWeight.w600,
                    fontSize: 15.sp, // Responsive font size
                    letterSpacing: 0.4,
                  ),
                  children: [
                    TextSpan(
                      text: 'Sign Up',
                      style: TextStyle(color: AppColors.themeColor),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Get.offAll(RegisterView());
                        },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5.h), // Final spacing
            ],
          ),
        ),
      ),
    );
  }

  ElevatedButton buildElevatedButton() {
    return ElevatedButton(
      onPressed: () {
        Get.offAll(const LoginView());
      },
      style: ElevatedButton.styleFrom(
        fixedSize: Size(350, 60), // Responsive button size
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        backgroundColor: AppColors.themeColor,
        foregroundColor: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            text: "Sign In with Your Account",
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 17.sp,
          ),
          Container(
            width: 12.w,
            height: 12.w, // Responsive icon container size
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.white,
            ),
            child: Center(
              child: Icon(
                Icons.arrow_forward,
                color: AppColors.themeColor,
                size: 7.w, // Responsive icon size
              ),
            ),
          ),
        ],
      ),
    );
  }
}
