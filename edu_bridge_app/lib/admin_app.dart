/*
import 'package:edu_bridge_app/controller.dart';
import 'package:edu_bridge_app/resources/app_colors.dart';
import 'package:edu_bridge_app/view/admin/admin_sign_in/admin_sign_in_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class EduBridgeAdmin extends StatelessWidget {
  const EduBridgeAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialBinding: ControllerBinder(),
        theme: _buildThemeData(),
        home: AdminSignInView(),
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
          borderSide: const BorderSide(
            color: AppColors.white,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppColors.white,
          ),
        ),
      ),
      fontFamily: GoogleFonts.jost().fontFamily,
    );
  }
}
*/
