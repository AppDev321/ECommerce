import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:razin_shop/config/theme.dart';

class AppTextStyle {
  final BuildContext context;
  AppTextStyle(this.context);

  TextStyle get title => TextStyle(
        color: colors(context).headingColor,
        fontSize: 24.sp,
        fontWeight: FontWeight.w500,
      );
  TextStyle get subTitle => TextStyle(
        color: colors(context).headingColor,
        fontSize: 18.sp,
        fontWeight: FontWeight.w700,
      );
  TextStyle get bodyText => TextStyle(
        color: colors(context).bodyTextColor,
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
      );
  TextStyle get bodyTextSmall => TextStyle(
        color: colors(context).bodyTextSmallColor,
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
      );
  TextStyle get buttonText => TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w700,
      );
  TextStyle get hintText => TextStyle(
        color: colors(context).hintTextColor,
        fontSize: 21.sp,
        fontWeight: FontWeight.w300,
      );
  TextStyle get appBarText => TextStyle(
        color: colors(context).headingColor,
        fontSize: 18.sp,
        fontWeight: FontWeight.w700,
      );
}
