// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:razin_commerce_seller_flutter/config/app_color.dart';
import 'package:razin_commerce_seller_flutter/config/app_text_style.dart';
import 'package:razin_commerce_seller_flutter/config/theme.dart';

class ImagePickerButton extends StatelessWidget {
  final String title;
  final String icon;
  final bool isActive;
  final VoidCallback callback;
  const ImagePickerButton({
    super.key,
    required this.title,
    required this.icon,
    required this.isActive,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callback,
      child: Container(
        height: 48.h,
        decoration: BoxDecoration(
          border: Border.all(
            color: isActive
                ? colors(context).primaryColor!
                : AppStaticColor.lightGray,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(12.sp),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                icon,
                colorFilter: ColorFilter.mode(
                    isActive
                        ? colors(context).primaryColor!
                        : AppStaticColor.gray,
                    BlendMode.srcIn),
              ),
              // Icon(
              //   icon,
              //   color: isActive
              //       ? colors(context).primaryColor!
              //       : AppStaticColor.gray,
              // ),
              Gap(8.w),
              Text(
                title,
                style: AppTextStyle.text14B400.copyWith(
                    color: isActive
                        ? colors(context).primaryColor!
                        : AppStaticColor.gray),
              )
            ],
          ),
        ),
      ),
    );
  }
}
