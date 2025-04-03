import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  final TextStyle? customStyle; // Allow full customizability of style

  const CustomText({
    required this.text,
    this.fontSize = 14,
    this.fontWeight = FontWeight.normal,
    this.color = Colors.black,
    this.customStyle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: customStyle ??
          GoogleFonts.jost(
            fontWeight: fontWeight,
            fontSize: fontSize,
            color: color,
          ),
    );
  }
}
