import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:razin_commerce_seller_flutter/config/app_color.dart';
import 'package:razin_commerce_seller_flutter/config/app_text_style.dart';
import 'package:razin_commerce_seller_flutter/config/theme.dart';
import 'package:razin_commerce_seller_flutter/features/order/models/order_model.dart';

class GlobalFunction {
  static void changeStatusBarTheme({required isDark}) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: isDark ? AppStaticColor.black : AppStaticColor.white,
        statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
      ),
    );
  }

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static BuildContext get context => navigatorKey.currentState!.context;

  static void showCustomSnackbar({
    required String message,
    required bool isSuccess,
  }) {
    final snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      dismissDirection: DismissDirection.startToEnd,
      backgroundColor: isSuccess
          ? colors(navigatorKey.currentState!.context).primaryColor
          : colors(navigatorKey.currentState!.context).errorColor,
      content: Text(message),
    );
    ScaffoldMessenger.of(navigatorKey.currentState!.context)
        .showSnackBar(snackBar);
  }

  // Pick date by Flutter DatePicker
  static Future<String?> pickDate({required BuildContext context}) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1800),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      return DateFormat('yyyy-MM-dd').format(picked);
    }
    return null;
  }

  // Pick image from gallery
  static Future<XFile?> pickImageFromGallery() async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    return image;
  }

  // Pick image from camera
  static Future<XFile?> pickImageFromCamera() async {
    final picker = ImagePicker();
    return await picker.pickImage(source: ImageSource.camera);
  }

  static InputDecoration inputDecoration({
    required String hintText,
    required Widget? widget,
    required BuildContext context,
    Color? fillColor,
  }) {
    return InputDecoration(
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16),
      alignLabelWithHint: true,
      hintText: hintText,
      hintStyle: AppTextStyle.hintText16B400,
      suffixIcon: widget,
      filled: true,
      fillColor: fillColor ?? colors(context).light,
      errorStyle:
          AppTextStyle.text14B400.copyWith(color: colors(context).errorColor),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(13.r),
        borderSide: BorderSide(color: colors(context).hintTextColor!),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(13.r),
        borderSide: BorderSide(
          color: colors(context).secondaryColor!,
          width: 1.5,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(13.r),
        borderSide: BorderSide(
          color: colors(context).primaryColor!,
          width: 1.5,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(13.r),
        borderSide: BorderSide(color: colors(context).errorColor!, width: 1.5),
      ),
    );
  }

  static Color getOrderStatsusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return AppStaticColor.orange;
      case 'confirm':
        return AppStaticColor.carrotOrange;
      case 'processing':
        return AppStaticColor.primary;
      case 'pickup':
        return AppStaticColor.blue;
      case 'on the way':
        return AppStaticColor.blue;
      case 'delivered':
        return AppStaticColor.green;
      default:
        return AppStaticColor.red;
    }
  }

  static String getFormattedAddress(Address address) {
    return '${address.flatNo}, ${address.addressLine}, ${address.addressLine2}, ${address.area}, ${address.postCode}';
  }
}
