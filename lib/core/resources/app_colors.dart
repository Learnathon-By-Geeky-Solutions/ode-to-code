import 'package:flutter/material.dart';

class AppColors {
  // Existing colors
  static const Color bg = Color(0xffF5F9FF);
  static const Color bgWhite = Color(0xffFFFFFF);
  static const Color themeColor = Color(0xff0961F5);
  static const Color white = Color(0xffFFFFFF);
  static const Color blackGray = Color(0xff545454);
  static const Color orange = Color(0xffFF6B00);
  static const Color green = Color(0xff01A437);
  static const Color bookColor = Color(0xff507C5C);
  static const Color shadowGrey = Color(0xffBFBFBF);
  static const Color grey = Colors.grey;
  static const Color red = Color(0xffff0101);
  static const Color blue = themeColor;

  // Add these new color properties to match the theme
  static const Color primary = themeColor;
  static const Color secondary = orange;
  static const Color background = bgWhite;
  static const Color surface = white;

  static const Color onPrimary = white;
  static const Color onSecondary = white;
  static const Color onBackground = blackGray;
  static const Color onSurface = blackGray;
  static const Color greenAccent = Colors.greenAccent;

  // For dark theme
  static const Color darkPrimary = Color(0xff1565C0);
  static const Color darkSecondary = Color(0xffFF8F00);
  static const Color darkBackground = Color(0xff121212);
  static const Color darkSurface = Color(0xff1E1E1E);
  static const Color onDarkPrimary = white;
  static const Color onDarkSecondary = Colors.black;
  static const Color onDarkBackground = white;
  static const Color onDarkSurface = white;
}
