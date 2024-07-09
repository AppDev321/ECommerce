import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:razin_commerce_seller_flutter/config/app_text_style.dart';
import 'package:razin_commerce_seller_flutter/config/theme.dart';

class WalletCardWidget extends StatelessWidget {
  final String text;
  final String icon;
  final String amount;
  const WalletCardWidget(
      {super.key,
      required this.text,
      required this.icon,
      required this.amount});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.dm),
        border: Border.all(
          color: colors(context).secondaryColor!,
          width: 2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text,
                style: AppTextStyle.text12B700.copyWith(
                  fontWeight: FontWeight.w400,
                ),
              ),
              SvgPicture.asset(icon),
            ],
          ),
          Gap(8.h),
          Text(
            amount,
            style: AppTextStyle.text16B700,
          )
        ],
      ),
    );
  }
}
