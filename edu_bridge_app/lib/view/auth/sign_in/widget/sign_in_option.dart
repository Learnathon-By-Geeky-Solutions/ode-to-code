import 'package:edu_bridge_app/resources/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

class SignInOption extends StatelessWidget {
  const SignInOption({
    super.key,
    required this.logo,
    required this.title,
  });
  final String logo;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 6.7.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Center(child: SvgPicture.asset(logo)),
          Text(
            "Continue with $title",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17.sp,
              color: AppColors.blackGray,
            ),
          ),
        ],
      ),
    );
  }
}
