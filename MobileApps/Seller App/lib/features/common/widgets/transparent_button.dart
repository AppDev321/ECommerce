// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:razin_commerce_seller_flutter/config/app_text_style.dart';
import 'package:razin_commerce_seller_flutter/config/theme.dart';

class TransparentButton extends StatelessWidget {
  final String buttonName;
  final bool isArrowShow;
  final Color? color;
  final Color? textColor;
  final Color? borderColor;
  final void Function()? onTap;
  const TransparentButton({
    super.key,
    required this.buttonName,
    this.isArrowShow = false,
    this.color,
    this.textColor,
    this.borderColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color ?? colors(context).primaryColor,
      borderRadius: BorderRadius.circular(100),
      child: InkWell(
        borderRadius: BorderRadius.circular(100),
        onTap: onTap,
        child: Container(
          height: 56.h,
          width: double.infinity,
          decoration: BoxDecoration(
            border:
                Border.all(color: borderColor ?? colors(context).primaryColor!),
            borderRadius: BorderRadius.circular(100.r),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                buttonName,
                style: AppTextStyle.text16B700.copyWith(
                  color: textColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
