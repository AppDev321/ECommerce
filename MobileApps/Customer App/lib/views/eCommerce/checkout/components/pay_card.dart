// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:razin_shop/config/app_color.dart';
import 'package:razin_shop/config/app_text_style.dart';
import 'package:razin_shop/gen/assets.gen.dart';

class PayCard extends StatelessWidget {
  final bool isActive;
  final String type;
  final Image image;
  final void Function() onTap;
  const PayCard({
    Key? key,
    required this.isActive,
    required this.type,
    required this.image,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Material(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(10.r),
          child: InkWell(
            borderRadius: BorderRadius.circular(10.r),
            onTap: onTap,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  side: BorderSide(
                    width: 1.5,
                    color: isActive
                        ? EcommerceAppColor.primary
                        : EcommerceAppColor.offWhite,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    isActive ? Assets.svg.activeRadio : Assets.svg.radioIcon,
                    width: 22.sp,
                  ),
                  Gap(14.h),
                  Text(
                    type,
                    style: AppTextStyle(context).bodyTextSmall.copyWith(
                          color: EcommerceAppColor.black,
                        ),
                  )
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: 14.h,
          right: 14.w,
          child: image,
        )
      ],
    );
  }
}
