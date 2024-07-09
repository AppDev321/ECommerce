// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

@immutable
class AppColors extends ThemeExtension<AppColors> {
  final Color? primaryColor;
  final Color? accentColor;
  final Color? secondaryColor;
  final Color? light;
  final Color? dark;
  final Color? buttonColor;
  final Color? headingColor;
  final Color? bodyTextColor;
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
    this.headingColor,
    required this.bodyTextColor,
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
      headingColor: headingColor ?? this.headingColor,
      bodyTextColor: bodyTextColor ?? this.bodyTextColor,
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
      headingColor: Color.lerp(headingColor, other.headingColor, t),
      bodyTextColor: Color.lerp(bodyTextColor, other.bodyTextColor, t),
      bodyTextSmallColor:
          Color.lerp(bodyTextSmallColor, other.bodyTextSmallColor, t),
      hintTextColor: Color.lerp(hintTextColor, other.hintTextColor, t),
      errorColor: Color.lerp(errorColor, other.errorColor, t),
    );
  }
}

class EcommerceAppColor {
  static const Color white = Color(0xFFFFFFFF);
  static const Color offWhite = Color(0xFFF1F1F5);
  static const Color black = Color(0xFF06161C);
  static const Color gray = Color(0xFF617986);
  static const Color lightGray = Color(0xFF979899);
  static Color primary = const Color(0xFF8322FF);
  static const Color carrotOrange = Color(0xFFFF8322);
  static const Color blueChalk = Color(0xFFF3E9FF);
  static const Color red = Color(0xFFFF2424);
  static const Color green = Color(0xFF1EDD31);
  static const Color blue = Color(0xFF2196F3);
}

class FoodAppColor {
  static const Color white = Color(0xFFFFFFFF);
  static const Color offWhite = Color(0xFFF1F1F5);
  static const Color black = Color(0xFF06161C);
  static const Color gray = Color(0xFF617986);
  static const Color lightGray = Color(0xFF979899);
  static const Color purple = Color(0xFF8322FF);
  static const Color carrotOrange = Color(0xFFFF8322);
  static const Color blueChalk = Color(0xFFF3E9FF);
  static const Color red = Color(0xFFFF2424);
  static const Color green = Color(0xFF1EDD31);
}

class GroceryAppColor {
  static const Color white = Color(0xFFFFFFFF);
  static const Color offWhite = Color(0xFFF1F1F5);
  static const Color black = Color(0xFF06161C);
  static const Color gray = Color(0xFF617986);
  static const Color lightGray = Color(0xFF979899);
  static const Color purple = Color(0xFF8322FF);
  static const Color carrotOrange = Color(0xFFFF8322);
  static const Color blueChalk = Color(0xFFF3E9FF);
  static const Color red = Color(0xFFFF2424);
  static const Color green = Color(0xFF1EDD31);
}

class PharmacyAppColor {
  static const Color white = Color(0xFFFFFFFF);
  static const Color offWhite = Color(0xFFF1F1F5);
  static const Color black = Color(0xFF06161C);
  static const Color gray = Color(0xFF617986);
  static const Color lightGray = Color(0xFF979899);
  static const Color purple = Color(0xFF8322FF);
  static const Color carrotOrange = Color(0xFFFF8322);
  static const Color blueChalk = Color(0xFFF3E9FF);
  static const Color red = Color(0xFFFF2424);
  static const Color green = Color(0xFF1EDD31);
}

class AppColor {
  final Color primaryColor;
  final Color accentColor;
  final Color secondaryColor;
  final Color light;
  final Color dark;
  final Color buttonColor;
  final Color bodyTextColor;
  final Color bodyTextSmallColor;
  final Color headingColor;
  final Color hintTextColor;
  final Color errorColor;
  AppColor({
    required this.primaryColor,
    required this.accentColor,
    required this.secondaryColor,
    required this.light,
    required this.dark,
    required this.buttonColor,
    required this.bodyTextColor,
    required this.bodyTextSmallColor,
    required this.headingColor,
    required this.hintTextColor,
    required this.errorColor,
  });
}

class AppColorManager {
  static AppColor getColorClass({required String serviceName}) {
    switch (serviceName.toLowerCase()) {
      case 'ecommerce':
        return AppColor(
          primaryColor: EcommerceAppColor.primary,
          accentColor: EcommerceAppColor.offWhite,
          secondaryColor: EcommerceAppColor.carrotOrange,
          light: EcommerceAppColor.white,
          dark: EcommerceAppColor.black,
          buttonColor: EcommerceAppColor.primary,
          bodyTextColor: EcommerceAppColor.black,
          bodyTextSmallColor: EcommerceAppColor.gray,
          headingColor: EcommerceAppColor.black,
          hintTextColor: EcommerceAppColor.lightGray,
          errorColor: EcommerceAppColor.red,
        );
      case 'food':
        return AppColor(
            primaryColor: FoodAppColor.purple,
            accentColor: FoodAppColor.offWhite,
            secondaryColor: FoodAppColor.carrotOrange,
            light: FoodAppColor.white,
            dark: FoodAppColor.black,
            buttonColor: FoodAppColor.purple,
            bodyTextColor: FoodAppColor.black,
            bodyTextSmallColor: FoodAppColor.gray,
            headingColor: FoodAppColor.black,
            hintTextColor: FoodAppColor.lightGray,
            errorColor: FoodAppColor.red);
      case 'grocery':
        return AppColor(
            primaryColor: GroceryAppColor.purple,
            accentColor: GroceryAppColor.offWhite,
            light: GroceryAppColor.white,
            dark: GroceryAppColor.black,
            secondaryColor: GroceryAppColor.carrotOrange,
            buttonColor: GroceryAppColor.purple,
            bodyTextColor: GroceryAppColor.black,
            bodyTextSmallColor: GroceryAppColor.gray,
            headingColor: GroceryAppColor.black,
            hintTextColor: GroceryAppColor.lightGray,
            errorColor: GroceryAppColor.red);

      case 'pharmacy':
        return AppColor(
          primaryColor: PharmacyAppColor.purple,
          accentColor: PharmacyAppColor.offWhite,
          secondaryColor: PharmacyAppColor.carrotOrange,
          light: PharmacyAppColor.white,
          dark: PharmacyAppColor.black,
          buttonColor: PharmacyAppColor.purple,
          bodyTextColor: PharmacyAppColor.black,
          bodyTextSmallColor: PharmacyAppColor.gray,
          headingColor: PharmacyAppColor.black,
          hintTextColor: PharmacyAppColor.lightGray,
          errorColor: PharmacyAppColor.red,
        );
      default:
        return AppColor(
          primaryColor: EcommerceAppColor.primary,
          accentColor: EcommerceAppColor.offWhite,
          secondaryColor: EcommerceAppColor.carrotOrange,
          light: EcommerceAppColor.white,
          dark: EcommerceAppColor.black,
          buttonColor: EcommerceAppColor.primary,
          bodyTextColor: EcommerceAppColor.black,
          bodyTextSmallColor: EcommerceAppColor.gray,
          headingColor: EcommerceAppColor.black,
          hintTextColor: EcommerceAppColor.lightGray,
          errorColor: EcommerceAppColor.red,
        );
    }
  }
}
