import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:razin_commerce_seller_flutter/config/app_color.dart';
import 'package:razin_commerce_seller_flutter/config/app_text_style.dart';
import 'package:razin_commerce_seller_flutter/config/theme.dart';

class OrderOverViewCard extends StatelessWidget {
  final String count;
  final String status;
  final String icon;
  const OrderOverViewCard({
    super.key,
    required this.count,
    required this.status,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.dm),
      decoration: ShapeDecoration(
        color: colors(context).secondaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(count, style: AppTextStyle.text16B700),
              SvgPicture.asset(icon)
            ],
          ),
          Gap(2.h),
          Text(
            status,
            style: AppTextStyle.text12B700.copyWith(
              fontWeight: FontWeight.w400,
              color: AppStaticColor.gray,
            ),
          )
        ],
      ),
    );
  }
}
