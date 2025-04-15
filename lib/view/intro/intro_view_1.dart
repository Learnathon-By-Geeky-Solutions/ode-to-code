import 'package:edu_bridge_app/resources/app_colors.dart';
import 'package:edu_bridge_app/resources/export.dart';
import 'package:flutter/material.dart';

class IntroView1 extends StatelessWidget {
  const IntroView1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(
                text: 'education_for_everyone'.tr,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
              CustomText(
                text: 'empowering_minds'.tr,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
