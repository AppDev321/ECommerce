// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:razin_shop/config/app_color.dart';
import 'package:razin_shop/config/app_text_style.dart';
import 'package:razin_shop/models/eCommerce/shop/shop_review.dart';

class ReviewCard extends StatelessWidget {
  final Review review;
  const ReviewCard({
    Key? key,
    required this.review,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: Theme.of(context).scaffoldBackgroundColor,
          border: Border.all(color: EcommerceAppColor.offWhite)),
      margin: EdgeInsets.symmetric(horizontal: 20.w).copyWith(bottom: 10.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCustomerInfo(context: context),
          Gap(5.h),
          Text(
            review.description,
            style: AppTextStyle(context).bodyText.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
          )
        ],
      ),
    );
  }

  Widget _buildCustomerInfo({required BuildContext context}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          child: Row(
            children: [
              CircleAvatar(
                radius: 25.r,
                backgroundImage:
                    CachedNetworkImageProvider(review.customerProfile),
              ),
              Gap(10.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(review.customerName,
                      style: AppTextStyle(context)
                          .bodyText
                          .copyWith(fontWeight: FontWeight.bold)),
                  Gap(2.h),
                  Text(
                    review.createdAt,
                    style: AppTextStyle(context)
                        .bodyTextSmall
                        .copyWith(fontSize: 13),
                  )
                ],
              ),
            ],
          ),
        ),
        Column(
          children: [
            Text(
              review.rating.toDouble().toString(),
              style: AppTextStyle(context)
                  .bodyText
                  .copyWith(fontWeight: FontWeight.w600),
            ),
            const Icon(
              Icons.star_rounded,
              size: 20,
              color: EcommerceAppColor.carrotOrange,
            )
          ],
        )
      ],
    );
  }
}
