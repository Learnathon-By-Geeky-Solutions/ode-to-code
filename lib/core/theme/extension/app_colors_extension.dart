import 'package:flutter/material.dart';

class AppColorsExtension extends ThemeExtension<AppColorsExtension> {
  final Color colorVariant1;
  final Color colorVariant2;
  final Color colorVariant3;

  AppColorsExtension({
    required this.colorVariant1,
    required this.colorVariant2,
    required this.colorVariant3,
  });

  @override
  AppColorsExtension copyWith({
    Color? colorVariant1,
    Color? colorVariant2,
    Color? colorVariant3,
  }) {
    return AppColorsExtension(
      colorVariant1: colorVariant1 ?? this.colorVariant1,
      colorVariant2: colorVariant2 ?? this.colorVariant2,
      colorVariant3: colorVariant3 ?? this.colorVariant3,
    );
  }

  @override
  AppColorsExtension lerp(
    ThemeExtension<AppColorsExtension>? other,
    double t,
  ) {
    if (other is! AppColorsExtension) return this;
    return AppColorsExtension(
      colorVariant1: Color.lerp(colorVariant1, other.colorVariant1, t)!,
      colorVariant2: Color.lerp(colorVariant2, other.colorVariant2, t)!,
      colorVariant3: Color.lerp(colorVariant3, other.colorVariant3, t)!,
    );
  }
}
