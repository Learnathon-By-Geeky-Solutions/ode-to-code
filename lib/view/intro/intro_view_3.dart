import 'package:edu_bridge_app/resources/app_colors.dart';
import 'package:flutter/material.dart';

class IntroView3 extends StatelessWidget {
  const IntroView3({super.key});

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
              Text(
                "Transform the Future",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              Text(
                'Your Knowledge, Our Progress Shaping a New Bangladesh!',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
