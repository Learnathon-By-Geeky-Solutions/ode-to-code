import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String labelText;
  final bool obscureText;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final VoidCallback? onTap;
  final bool readOnly;
  final IconData? prefixIcon;
  final IconData? suffixIcon;

  const CustomTextFormField({
    super.key,
    required this.labelText,
    this.obscureText = false,
    this.validator,
    this.controller,
    this.onTap,
    this.readOnly = false,
    this.prefixIcon,
    this.suffixIcon, // Initialize optional icon
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      validator: validator,
      controller: controller,
      readOnly: readOnly,
      onTap: onTap,
      decoration: InputDecoration(
        labelText: labelText,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
        suffixIcon: suffixIcon != null ? Icon(prefixIcon) : null,
      ),
    );
  }
}
