import 'package:flutter/material.dart';

@immutable
class AppColors extends ThemeExtension<AppColors> {
  final Color? primaryColor;
  final Color? accentColor;
  final Color? secondaryColor;
  final Color? light;
  final Color? dark;
  final Color? buttonColor;
  final Color? textColor;
  final Color? bodyTextSmallColor;
  final Color? hintTextColor;
  final Color? errorColor;

  const AppColors({
    required this.primaryColor,
    required this.accentColor,
    required this.secondaryColor,
    required this.light,
    required this.dark,
    required this.buttonColor,
    required this.textColor,
    required this.bodyTextSmallColor,
    required this.hintTextColor,
    required this.errorColor,
  });

  @override
  AppColors copyWith({
    Color? primaryColor,
    Color? accentColor,
    Color? secondaryColor,
    Color? light,
    Color? dark,
    Color? buttonColor,
    Color? headingColor,
    Color? bodyTextColor,
    Color? bodyTextSmallColor,
    Color? titleTextColor,
    Color? hintTextColor,
    Color? errorColor,
  }) {
    return AppColors(
      primaryColor: primaryColor ?? this.primaryColor,
      accentColor: accentColor ?? this.accentColor,
      secondaryColor: secondaryColor ?? this.secondaryColor,
      light: light ?? this.light,
      dark: dark ?? this.dark,
      buttonColor: buttonColor ?? this.buttonColor,
      textColor: bodyTextColor ?? textColor,
      bodyTextSmallColor: bodyTextSmallColor ?? this.bodyTextSmallColor,
      hintTextColor: hintTextColor ?? this.hintTextColor,
      errorColor: errorColor ?? this.errorColor,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) {
      return this;
    }
    return AppColors(
      primaryColor: Color.lerp(primaryColor, other.primaryColor, t),
      accentColor: Color.lerp(accentColor, other.accentColor, t),
      secondaryColor: Color.lerp(secondaryColor, other.secondaryColor, t),
      light: Color.lerp(light, other.light, t),
      dark: Color.lerp(dark, other.dark, t),
      buttonColor: Color.lerp(buttonColor, other.buttonColor, t),
      textColor: Color.lerp(textColor, other.textColor, t),
      bodyTextSmallColor:
          Color.lerp(bodyTextSmallColor, other.bodyTextSmallColor, t),
      hintTextColor: Color.lerp(hintTextColor, other.hintTextColor, t),
      errorColor: Color.lerp(errorColor, other.errorColor, t),
    );
  }
}

class AppStaticColor {
  static const Color white = Color(0xFFFFFFFF);
  static Color primary = const Color(0xFFef4444);
  static const Color secondary = Color(0xFFF7F7F7);

  static const Color accent = Color(0xFFf6eeff);
  static const Color black = Color(0xFF06161C);
  static const Color gray = Color(0xFF617986);
  static const Color lightGray = Color(0xFF979899);
  static const Color carrotOrange = Color(0xFFFF8322);
  static const Color orange = Color(0xFFEBB700);
  static const Color red = Color(0xFFFF2424);
  static const Color green = Color(0xFF1EDD31);
  static const Color blue = Color(0xFF2196F3);
}
