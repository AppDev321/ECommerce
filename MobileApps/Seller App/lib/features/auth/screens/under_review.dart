import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:razin_commerce_seller_flutter/config/app_text_style.dart';
import 'package:razin_commerce_seller_flutter/config/theme.dart';
import 'package:razin_commerce_seller_flutter/gen/assets.gen.dart';

class UnderReview extends StatelessWidget {
  const UnderReview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors(context).light,
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Registration DONE!',
                style: AppTextStyle.text16B400,
              ),
              Gap(16.h),
              Text(
                'Your profile is under review',
                textAlign: TextAlign.center,
                style: AppTextStyle.text24B700
                    .copyWith(fontSize: 28.sp, wordSpacing: 1.5),
              ),
              Gap(24.h),
              Assets.png.underReview.image(),
              Text(
                'Your profile has been submitted and is being reviewed. You will be notified when it is approved.',
                textAlign: TextAlign.center,
                style: AppTextStyle.text16B400.copyWith(
                  fontSize: 18.sp,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
