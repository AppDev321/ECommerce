import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:razin_commerce_seller_flutter/config/app_color.dart';

AppColors colors(context) => Theme.of(context).extension<AppColors>()!;
ThemeData getAppTheme(
    {required BuildContext context, required bool isDarkTheme}) {
  return ThemeData(
    useMaterial3: true,
    extensions: <ThemeExtension<AppColors>>[
      AppColors(
        primaryColor: AppStaticColor.primary,
        accentColor: AppStaticColor.accent,
        secondaryColor: AppStaticColor.secondary,
        buttonColor: AppStaticColor.primary,
        light: AppStaticColor.white,
        dark: AppStaticColor.black,
        hintTextColor: AppStaticColor.lightGray,
        errorColor: AppStaticColor.red,
        textColor:
            isDarkTheme ? AppStaticColor.secondary : AppStaticColor.black,
        bodyTextSmallColor: null,
      ),
    ],
    fontFamily: GoogleFonts.mulish().fontFamily,
    scaffoldBackgroundColor:
        isDarkTheme ? AppStaticColor.black : AppStaticColor.secondary,
    appBarTheme: AppBarTheme(
      toolbarHeight: 64.h,
      backgroundColor:
          isDarkTheme ? AppStaticColor.black : AppStaticColor.white,
      surfaceTintColor:
          isDarkTheme ? AppStaticColor.black : AppStaticColor.white,
      titleTextStyle: TextStyle(
        color: isDarkTheme ? AppStaticColor.white : AppStaticColor.black,
        fontSize: 18.sp,
        fontWeight: FontWeight.w700,
      ),
      centerTitle: false,
      elevation: 0,
      iconTheme: IconThemeData(
        color: isDarkTheme ? AppStaticColor.white : AppStaticColor.black,
      ),
    ),
    colorScheme: ColorScheme(
      brightness: isDarkTheme ? Brightness.dark : Brightness.light,
      primary: AppStaticColor.primary,
      onPrimary: AppStaticColor.accent,
      secondary: AppStaticColor.secondary,
      onSecondary: AppStaticColor.secondary,
      error: AppStaticColor.red,
      onError: AppStaticColor.red,
      surface: isDarkTheme ? AppStaticColor.black : AppStaticColor.white,
      onSurface: isDarkTheme ? AppStaticColor.black : AppStaticColor.gray, background: AppStaticColor.white, onBackground: AppStaticColor.white,
    ),
    unselectedWidgetColor: AppStaticColor.lightGray,
    expansionTileTheme: const ExpansionTileThemeData(),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor:
          isDarkTheme ? AppStaticColor.white : AppStaticColor.black,
      modalBackgroundColor:
          isDarkTheme ? AppStaticColor.white : AppStaticColor.black,
      surfaceTintColor:
          isDarkTheme ? AppStaticColor.white : AppStaticColor.black,
    ),
  );
}
