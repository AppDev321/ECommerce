// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:razin_shop/config/app_color.dart';
import 'package:razin_shop/config/app_text_style.dart';
import 'package:razin_shop/models/eCommerce/shop/shop_review.dart';

class RatingSummary extends StatelessWidget {
  final AverageRatingPercentage averageRatingPercentage;
  const RatingSummary({
    Key? key,
    required this.averageRatingPercentage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Container(
        color: EcommerceAppColor.white,
        padding: EdgeInsets.symmetric(horizontal: 0.w),
        child: Column(
          children: [
            Divider(
              height: 30.h,
              thickness: 3.h,
              color: EcommerceAppColor.offWhite,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                children: [
                  _buildRatingSummaryWidget(context: context),
                  Gap(14.w),
                  _buildRatingProgressBarWidget(context: context),
                ],
              ),
            ),
            Divider(
              height: 10.h,
              thickness: 2.h,
              color: EcommerceAppColor.offWhite,
            ),
          ],
        ),
      );
    });
  }

  Widget _buildRatingSummaryWidget({required BuildContext context}) {
    return Column(
      children: [
        Text(
          averageRatingPercentage.rating.toString(),
          style: AppTextStyle(context).title,
        ),
        RatingBarIndicator(
          unratedColor: EcommerceAppColor.gray,
          rating: averageRatingPercentage.rating,
          itemBuilder: (context, index) => SizedBox(
            child: Icon(
              Icons.star_rounded,
              size: 16.sp,
              color: EcommerceAppColor.carrotOrange,
            ),
          ),
          itemCount: 5,
          itemSize: 20.0,
          direction: Axis.horizontal,
          itemPadding: EdgeInsets.only(left: 5.h),
        ),
        Text(
          "(${averageRatingPercentage.totalReview})",
          style: AppTextStyle(context).bodyText,
        )
      ],
    );
  }

  Widget _buildRatingProgressBarWidget({required BuildContext context}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildRatingBarRow(
          number: 5,
          value: averageRatingPercentage.percentages.n5 / 100,
          percentage: averageRatingPercentage.percentages.n5,
          context: context,
        ),
        _buildRatingBarRow(
          number: 4,
          value: averageRatingPercentage.percentages.n4 / 100,
          percentage: averageRatingPercentage.percentages.n4,
          context: context,
        ),
        _buildRatingBarRow(
          number: 3,
          value: averageRatingPercentage.percentages.n3 / 100,
          percentage: averageRatingPercentage.percentages.n3,
          context: context,
        ),
        _buildRatingBarRow(
          number: 2,
          value: averageRatingPercentage.percentages.n2 / 100,
          percentage: averageRatingPercentage.percentages.n2,
          context: context,
        ),
        _buildRatingBarRow(
            number: 1,
            value: averageRatingPercentage.percentages.n1 / 100,
            percentage: averageRatingPercentage.percentages.n1,
            context: context)
      ],
    );
  }

  Widget _buildRatingBarRow({
    required int number,
    required double value,
    required double percentage,
    required BuildContext context,
  }) {
    return Row(
      children: [
        Text(
          number.toString(),
          style: AppTextStyle(context).bodyTextSmall.copyWith(
              color: EcommerceAppColor.black, fontWeight: FontWeight.bold),
        ),
        LinearPercentIndicator(
          width: 156.w,
          animation: true,
          lineHeight: 8.h,
          animationDuration: 400,
          percent: value > 1.0 ? 1.0 : value,
          barRadius: const Radius.circular(12),
          progressColor: Colors.orangeAccent,
          backgroundColor: EcommerceAppColor.offWhite,
        ),
        Text(
          '$percentage%', // Display the percentage as a formatted string
          style: AppTextStyle(context).bodyTextSmall.copyWith(
                color: EcommerceAppColor.gray,
              ),
        )
      ],
    );
  }
}
