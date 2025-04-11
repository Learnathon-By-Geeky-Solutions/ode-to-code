import 'package:edu_bridge_app/resources/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppThemes {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    colorScheme: const ColorScheme.light(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      background: AppColors.background,
      surface: AppColors.surface,
      onPrimary: AppColors.onPrimary,
      onSecondary: AppColors.onSecondary,
      onBackground: AppColors.onBackground,
      onSurface: AppColors.onSurface,
    ),
    fontFamily: 'Kalpurush',
    textTheme: GoogleFonts.jostTextTheme().copyWith(
      bodyLarge: const TextStyle(fontFamily: 'Kalpurush'),
      bodyMedium: const TextStyle(fontFamily: 'Kalpurush'),
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: AppColors.white,
      filled: true,
      labelStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        fontFamily: 'Kalpurush',
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.white),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.white),
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.darkPrimary,
    colorScheme: ColorScheme.dark(
      primary: AppColors.darkPrimary,
      secondary: AppColors.darkSecondary,
      background: AppColors.darkBackground,
      surface: AppColors.darkSurface,
      onPrimary: AppColors.onDarkPrimary,
      onSecondary: AppColors.onDarkSecondary,
      onBackground: AppColors.onDarkBackground,
      onSurface: AppColors.onDarkSurface,
    ),
    fontFamily: 'Kalpurush',
    textTheme: GoogleFonts.jostTextTheme().copyWith(
      bodyLarge: const TextStyle(fontFamily: 'Kalpurush'),
      bodyMedium: const TextStyle(fontFamily: 'Kalpurush'),
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: AppColors.darkSurface,
      filled: true,
      labelStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        fontFamily: 'Kalpurush',
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.darkSurface),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.darkSurface),
      ),
    ),
  );
}
