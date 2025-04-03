import 'package:edu_bridge_app/resources/export.dart';

class CustomHeaderText extends StatelessWidget {
  const CustomHeaderText({
    super.key,
    required this.text1,
    required this.text2,
  });
  final String text1;
  final String text2;

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
            fontSize: 24,
          ),
          CustomText(
            text: text2,
            fontWeight: FontWeight.bold,
            fontSize: 12,
            color: AppColors.blackGray,
          ),
        ],
      ),
    );
  }
}
