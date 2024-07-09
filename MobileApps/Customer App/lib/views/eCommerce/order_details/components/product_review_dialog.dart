// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:razin_shop/components/ecommerce/custom_button.dart';
import 'package:razin_shop/components/ecommerce/custom_text_field.dart';
import 'package:razin_shop/config/app_color.dart';
import 'package:razin_shop/config/app_text_style.dart';
import 'package:razin_shop/controllers/eCommerce/order/order_controller.dart';
import 'package:razin_shop/generated/l10n.dart';
import 'package:razin_shop/models/eCommerce/order/add_product_review_model.dart';
import 'package:razin_shop/utils/context_less_navigation.dart';
import 'package:razin_shop/utils/global_function.dart';
import 'package:tuple/tuple.dart';

class ProductReviewDialog extends StatelessWidget {
  final Tuple2 arugument;

  const ProductReviewDialog({
    Key? key,
    required this.arugument,
  }) : super(key: key);

  static TextEditingController productReviewController =
      TextEditingController();
  static double ratingCount = 5.0;

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
              S.of(context).hWtheProduct,
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
              onRatingUpdate: (rating) {
                ratingCount = rating;
                debugPrint(rating.toString());
              },
            ),
            Gap(5.h),
            CustomTextFormField(
              name: 'Product Review',
              hintText: S.of(context).writeSATP,
              showName: false,
              minLines: 4,
              maxLines: 4,
              textInputType: TextInputType.multiline,
              controller: productReviewController,
              textInputAction: TextInputAction.done,
              validator: (value) => GlobalFunction.commonValidator(
                  value: value!, hintText: 'Product review', context: context),
            ),
            Gap(24.h),
            Consumer(builder: (context, ref, _) {
              return ref.watch(orderControllerProvider)
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : CustomButton(
                      buttonText: S.of(context).submit,
                      onPressed: () {
                        final AddProductReviewModel productReviewModel =
                            AddProductReviewModel(
                          orderId: arugument.item1,
                          productId: arugument.item2,
                          rating: ratingCount,
                          message: productReviewController.text,
                        );
                        ref
                            .read(orderControllerProvider.notifier)
                            .addProudctReview(
                                productReviewModel: productReviewModel)
                            .whenComplete(() {
                          productReviewController.clear();
                          ratingCount = 5.0;
                          context.nav.pop();

                          return ref.refresh(
                              orderDetailsControllerProvider(arugument.item1));
                        });
                      },
                    );
            })
          ],
        ),
      ),
    );
  }
}
