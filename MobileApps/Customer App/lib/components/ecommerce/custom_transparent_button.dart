// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:razin_shop/config/app_color.dart';
import 'package:razin_shop/config/app_text_style.dart';
import 'package:razin_shop/config/theme.dart';

class CustomTransparentButton extends StatelessWidget {
  final String buttonText;
  final void Function() onTap;
  final Color? buttonTextColor;
  final Color? borderColor;
  const CustomTransparentButton({
    Key? key,
    required this.buttonText,
    required this.onTap,
    this.buttonTextColor,
    this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(50.r),
      onTap: onTap,
      child: Container(
        height: 50.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: colors(context).light,
          borderRadius: BorderRadius.circular(50.r),
          border: Border.all(
            color: borderColor ?? EcommerceAppColor.black,
          ),
        ),
        child: Center(
          child: Text(
            buttonText,
            style: AppTextStyle(context).buttonText.copyWith(
                  color: buttonTextColor ?? EcommerceAppColor.black,
                ),
          ),
        ),
      ),
    );
  }
}
