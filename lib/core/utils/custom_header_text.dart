import 'package:edu_bridge_app/core/resources/export.dart';

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
    this.text2FontSize = 12.0,
    this.text2Color = AppColors.blackGray,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: text1,
            fontWeight: FontWeight.bold,
            fontSize: text1FontSize,
          ),
          CustomText(
            text: text2,
            fontWeight: FontWeight.bold,
            fontSize: text2FontSize,
            color: text2Color,
          ),
        ],
      ),
    );
  }
}
