import 'package:edu_bridge_app/core/export.dart';

class CustomTextFormField extends StatelessWidget {
  final String labelText;
  final bool obscureText;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final VoidCallback? onTap;
  final bool readOnly;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final bool? enabled;

  const CustomTextFormField({
    super.key,
    required this.labelText,
    this.obscureText = false,
    this.validator,
    this.controller,
    this.onTap,
    this.readOnly = false,
    this.prefixIcon,
    this.suffixIcon,
    this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      validator: validator,
      controller: controller,
      readOnly: readOnly,
      onTap: onTap,
      enabled: enabled ?? true,
      style: GoogleFonts.mulish(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: AppColors.blackGray,
      ),
      decoration: InputDecoration(
        labelText: labelText,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
        suffixIcon: suffixIcon != null ? Icon(suffixIcon) : null,
        border: InputBorder.none,
      ),
    );
  }
}
