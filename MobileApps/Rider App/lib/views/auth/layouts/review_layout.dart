import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:razinshop_rider/config/app_color.dart';
import 'package:razinshop_rider/config/app_constants.dart';
import 'package:razinshop_rider/config/app_text.dart';
import 'package:razinshop_rider/gen/assets.gen.dart';
import 'package:razinshop_rider/generated/l10n.dart';

class ReviewLayout extends StatefulWidget {
  const ReviewLayout({super.key, this.phoneNumber});
  final String? phoneNumber;

  @override
  State<ReviewLayout> createState() => _ReviewLayoutState();
}

class _ReviewLayoutState extends State<ReviewLayout> {
  final box = Hive.box(AppConstants.authBox);
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      box.put(AppConstants.isInReview, widget.phoneNumber);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Gap(60.h),
            Text(
              S.of(context).registrationDone,
              textAlign: TextAlign.center,
              style: AppTextStyle.normalBody,
            ),
            Gap(20.h),
            Text(
              S.of(context).underview,
              textAlign: TextAlign.center,
              style: AppTextStyle.normalBody
                  .copyWith(fontSize: 28.sp, fontWeight: FontWeight.w700),
            ),
            Gap(20.h),
            Assets.pngs.profileReviewScreen.image(height: 330.h),
            Gap(20.h),
            Text(
              S.of(context).underReviewText,
              textAlign: TextAlign.center,
              style: AppTextStyle.normalBody.copyWith(fontSize: 18.sp),
            ),
          ],
        ),
      ),
    );
  }
}
