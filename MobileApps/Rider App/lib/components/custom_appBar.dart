import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:razinshop_rider/config/app_color.dart';
import 'package:razinshop_rider/config/app_text.dart';
import 'package:razinshop_rider/gen/assets.gen.dart';
import 'package:razinshop_rider/utils/context_less_navigate.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.whiteColor,
      child: Column(
        children: [
          Gap(56.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8).r,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    context.nav.pop();
                  },
                  child: SvgPicture.asset(
                    Assets.svgs.backArrow,
                    height: 24.r,
                    width: 24.r,
                  ),
                ),
                Gap(24.w),
                Text(
                  title,
                  style: AppTextStyle.largeBody,
                ),
              ],
            ),
          ),
          Gap(8.r),
        ],
      ),
    );
  }
}
