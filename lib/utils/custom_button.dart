import 'package:edu_bridge_app/resources/export.dart';

enum ButtonType { elevated, outlined, text }

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;
  final double fontSize;
  final FontWeight fontWeight;
  final Color iconBackgroundColor;
  final IconData? icon;
  final double width;
  final double height;
  final double borderRadius;
  final ButtonType buttonType;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor = Colors.blue,
    this.textColor = Colors.white,
    this.fontSize = 16,
    this.fontWeight = FontWeight.w500,
    this.iconBackgroundColor = Colors.white,
    this.icon,
    this.width = 350,
    this.height = 60,
    this.borderRadius = 30,
    this.buttonType = ButtonType.elevated, // Default to ElevatedButton
  });

  @override
  Widget build(BuildContext context) {
    switch (buttonType) {
      case ButtonType.outlined:
        return OutlinedButton(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
            fixedSize: Size(width, height),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            side: BorderSide(color: backgroundColor),
            foregroundColor: AppColors.themeColor, // Text color
          ),
          child: _buildButtonContent(),
        );
      case ButtonType.text:
        return TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            fixedSize: Size(width, height),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            foregroundColor: textColor, // Text color
          ),
          child: _buildButtonContent(),
        );
      case ButtonType.elevated:
      default:
        return ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            fixedSize: Size(width, height),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            backgroundColor: AppColors.themeColor,
            foregroundColor: textColor,
          ),
          child: _buildButtonContent(),
        );
    }
  }

  // Common button content (text + icon)
  Widget _buildButtonContent() {
    return Row(
      children: [
        Expanded(
          child: Center(
            child: CustomText(
              text: text,
              color: textColor,
              fontSize: fontSize,
              fontWeight: fontWeight,
            ),
          ),
        ),
        if (icon != null)
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: iconBackgroundColor,
            ),
            child: Center(
              child: Icon(
                icon,
                color: backgroundColor,
              ),
            ),
          ),
      ],
    );
  }
}
