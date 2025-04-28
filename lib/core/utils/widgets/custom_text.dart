import 'package:edu_bridge_app/core/export.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  final TextStyle? customStyle;
  final TextAlign textAlign;
  final int? maxLines;
  final TextOverflow overflow;
  const CustomText({
    required this.text,
    this.fontSize = 14,
    this.fontWeight = FontWeight.normal,
    this.color = Colors.black,
    this.customStyle,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow = TextOverflow.ellipsis,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = customStyle ??
        GoogleFonts.jost(
          fontWeight: fontWeight,
          fontSize: fontSize,
          color: color,
        );

    return Text(
      text,
      style: textStyle,
      textAlign: textAlign,
      maxLines: maxLines, // Apply maxLines here
      overflow: overflow, // Apply overflow here
    );
  }
}
