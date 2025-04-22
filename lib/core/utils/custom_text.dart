import 'package:edu_bridge_app/core/resources/export.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  final TextStyle? customStyle;
  final TextAlign textAlign;

  const CustomText({
    required this.text,
    this.fontSize = 14,
    this.fontWeight = FontWeight.normal,
    this.color = Colors.black,
    this.customStyle,
    this.textAlign = TextAlign.start,
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
      textAlign: textAlign, // Apply textAlign here
    );
  }
}
