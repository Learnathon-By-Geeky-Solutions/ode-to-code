import 'package:edu_bridge_app/core/resources/export.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
  });

  final String title;
  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final titleRow = Row(
      children: [
        Icon(icon),
        HorizontalSpacing(3.w),
        CustomText(text: title),
      ],
    );

    return TextButton(
      onPressed: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          titleRow,
          const Row(
            children: [
              Icon(Icons.arrow_forward_ios),
            ],
          ),
        ],
      ),
    );
  }
}
