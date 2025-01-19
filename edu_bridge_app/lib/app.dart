import 'package:edu_bridge_app/controller.dart';
import 'package:edu_bridge_app/resources/app_colors.dart';
import 'package:edu_bridge_app/view/home/home_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class EduBridge extends StatelessWidget {
  const EduBridge({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) => GetMaterialApp(
        initialBinding: ControllerBinder(),
        theme: _buildThemeData(),
        home: const HomeView(),
      ),
    );
  }

  ThemeData _buildThemeData() {
    return ThemeData(
      inputDecorationTheme: InputDecorationTheme(
        fillColor: AppColors.white,
        filled: true,
        labelStyle:
            GoogleFonts.mulish(fontSize: 14, fontWeight: FontWeight.bold),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: AppColors.white,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: AppColors.white,
          ),
        ),
      ),
      fontFamily: GoogleFonts.jost().fontFamily,
    );
  }
}
