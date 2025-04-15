import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  final TextStyle? customStyle;

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
    return CustomText(
      text: text,
      customStyle: customStyle ??
          GoogleFonts.jost(
            fontWeight: fontWeight,
            fontSize: fontSize,
            color: color,
          ),
    );
  }
}
