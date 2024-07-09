import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:razin_shop/components/ecommerce/custom_button.dart';
import 'package:razin_shop/components/ecommerce/custom_text_field.dart';
import 'package:razin_shop/config/app_color.dart';
import 'package:razin_shop/config/app_text_style.dart';
import 'package:razin_shop/utils/global_function.dart';

class SellerReviewDialog extends StatelessWidget {
  const SellerReviewDialog({super.key});

  static TextEditingController productReviewController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      backgroundColor: EcommerceAppColor.white,
      insetPadding: EdgeInsets.symmetric(
        horizontal: 20.w,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'What do you think about Seller?',
              textAlign: TextAlign.center,
              style: AppTextStyle(context)
                  .title
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            Gap(14.h),
            RatingBar.builder(
              tapOnlyMode: false,
              itemSize: 30.sp,
              initialRating: 5,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              unratedColor: EcommerceAppColor.offWhite,
              itemBuilder: (context, _) => Icon(
                Icons.star_rounded,
                size: 16.sp,
                color: EcommerceAppColor.carrotOrange,
              ),
              onRatingUpdate: (rating) => debugPrint(rating.toString()),
            ),
            Gap(5.h),
            CustomTextFormField(
              name: 'Seller Review',
              hintText: 'Write something about the seller',
              showName: false,
              maxLines: 4,
              minLines: 4,
              textInputType: TextInputType.multiline,
              controller: productReviewController,
              textInputAction: TextInputAction.done,
              validator: (value) => GlobalFunction.commonValidator(
                value: value!,
                hintText: 'Seller review',
                context: context,
              ),
            ),
            Gap(24.h),
            CustomButton(
              buttonText: 'Submit',
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
