import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:razinshop_rider/config/app_color.dart';
import 'package:razinshop_rider/gen/assets.gen.dart';
import 'package:razinshop_rider/generated/l10n.dart';

class GlobalFunction {
  GlobalFunction._();

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static void showCustomSnackbar({
    required String message,
    required bool isSuccess,
    bool isTop = false,
  }) {
    final snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          16.r,
        ),
      ),
      dismissDirection:
          isTop ? DismissDirection.startToEnd : DismissDirection.down,
      backgroundColor: isSuccess ? Colors.green : AppColor.redColor,
      content: Text(message),
      margin: isTop
          ? EdgeInsets.only(
              bottom: MediaQuery.of(navigatorKey.currentState!.context)
                      .size
                      .height -
                  160,
              right: 20,
              left: 20,
            )
          : null,
    );
    ScaffoldMessenger.of(navigatorKey.currentState!.context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        snackBar,
      );
  }

  static void changeStatusBarTheme({required isDark}) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
      ),
    );
  }

  static ({String buttonText, Color buttonColor, Color textColor})
      sliderButtonStatus(String value, BuildContext context) {
    return switch (value) {
      'Confirm' => (
          buttonColor: AppColor.primaryColor.withOpacity(0.10),
          textColor: AppColor.primaryColor,
          buttonText: S.of(context).slideToStartPickUp,
        ),
      'Processing' => (
          buttonColor: Color(0xffFF8322).withOpacity(0.10),
          textColor: Color(0xffFF8322),
          buttonText: S.of(context).slideToPickupConfirm,
        ),
      'responseSuccess' => (
          buttonColor: Color(0xff1EDD31).withOpacity(0.10),
          textColor: Color(0xff1EDD31),
          buttonText: S.of(context).success,
        ),
      'On The Way' => (
          buttonColor: Color(0xff2196F3).withOpacity(0.10),
          textColor: Color(0xff2196F3),
          buttonText: S.of(context).slideToConfirmDelivery,
        ),
      'Delivered' => (
          buttonColor: Color(0xff1EDD31).withOpacity(0.10),
          textColor: Color(0xff1EDD31),
          buttonText: S.of(context).deliveryConfirmed,
        ),
      _ => (
          buttonColor: AppColor.redColor.withOpacity(0.10),
          textColor: AppColor.redColor,
          buttonText: S.of(context).somethingWentWrong,
        ),
    };
  }

  static SvgPicture slideButtonIcon(String value) {
    return switch (value) {
      'Confirm' => SvgPicture.asset(Assets.svgs.doubleArrowStart),
      'Processing' => SvgPicture.asset(Assets.svgs.doubleArrow),
      'responseSuccess' => SvgPicture.asset(Assets.svgs.subwayTick),
      'On The Way' => SvgPicture.asset(Assets.svgs.doubleArrow2),
      'Delivered' => SvgPicture.asset(Assets.svgs.subwayTick),
      _ => SvgPicture.asset(Assets.svgs.doubleArrow),
    };
  }

  static ({String text, Color bgColor}) orderStatusText(String value, context) {
    return switch (value) {
      'Confirm' => (text: S.of(context).active, bgColor: AppColor.primaryColor),
      'Processing' => (text: S.of(context).active, bgColor: Color(0xffFF8322)),
      'responseSuccess' => (
          text: S.of(context).active,
          bgColor: Color(0xffFF8322)
        ),
      'On The Way' => (
          text: S.of(context).delivering,
          bgColor: Color(0xff2196F3)
        ),
      'Delivered' => (
          text: S.of(context).delivered,
          bgColor: Color(0xff1EDD31)
        ),
      _ => (text: S.of(context).active, bgColor: Color(0xffFF8322)),
    };
  }
}
