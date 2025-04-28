import 'package:edu_bridge_app/core/export.dart';

class CustomHeaderText extends StatelessWidget {
  final String text1;
  final String text2;
  final double text1FontSize;
  final double text2FontSize;
  final Color text2Color;

  const CustomHeaderText({
    super.key,
    required this.text1,
    required this.text2,
    this.text1FontSize = 24.0,
    this.text2FontSize = 14.0,
    this.text2Color = AppColors.blackGray,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomText(
          text: text1,
          fontWeight: FontWeight.w600,
          fontSize: text1FontSize,
        ),
        CustomText(
          text: text2,
          customStyle: GoogleFonts.mulish(
            fontSize: text2FontSize,
            fontWeight: FontWeight.bold,
            color: text2Color,
          ),
        ),
      ],
    );
  }
}
