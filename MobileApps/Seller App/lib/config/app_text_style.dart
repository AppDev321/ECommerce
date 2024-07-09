import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:razin_commerce_seller_flutter/config/theme.dart';
import 'package:razin_commerce_seller_flutter/utils/global_function.dart';

class AppTextStyle {
  static TextStyle text24B700 = TextStyle(
    color: colors(GlobalFunction.navigatorKey.currentContext).textColor,
    fontSize: 24.sp,
    fontWeight: FontWeight.w700,
  );
  static TextStyle text16B700 = TextStyle(
    color: colors(GlobalFunction.navigatorKey.currentContext).textColor,
    fontSize: 16.sp,
    fontWeight: FontWeight.w700,
  );
  static TextStyle text16B400 = TextStyle(
    color: colors(GlobalFunction.navigatorKey.currentContext).textColor,
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
  );
  static TextStyle hintText16B400 = TextStyle(
    color: colors(GlobalFunction.navigatorKey.currentContext).hintTextColor,
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
  );
  static TextStyle text14B400 = TextStyle(
    color: colors(GlobalFunction.navigatorKey.currentContext).textColor,
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
  );
  static TextStyle text14B700 = TextStyle(
    color: colors(GlobalFunction.navigatorKey.currentContext).textColor,
    fontSize: 14.sp,
    fontWeight: FontWeight.w700,
  );
  static TextStyle text12B700 = TextStyle(
    color: colors(GlobalFunction.navigatorKey.currentContext).textColor,
    fontSize: 12.sp,
    fontWeight: FontWeight.w700,
  );
}
