// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:razin_shop/config/app_color.dart';
import 'package:razin_shop/config/app_text_style.dart';
import 'package:razin_shop/config/theme.dart';
import 'package:razin_shop/controllers/misc/misc_controller.dart';
import 'package:razin_shop/generated/l10n.dart';
import 'package:razin_shop/models/eCommerce/product/product_details.dart';

class ProductColorPicker extends ConsumerStatefulWidget {
  final ProductDetails productDetails;
  const ProductColorPicker({
    Key? key,
    required this.productDetails,
  }) : super(key: key);

  @override
  ConsumerState<ProductColorPicker> createState() => _ProductColorPickerState();
}

class _ProductColorPickerState extends ConsumerState<ProductColorPicker> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.refresh(selectedProductColorIndex.notifier).state;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: colors(context).light,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.of(context).color,
            style: AppTextStyle(context).bodyText.copyWith(
                  fontWeight: FontWeight.w500,
                ),
          ),
          Gap(10.h),
          Row(
            children: [
              Wrap(
                alignment: WrapAlignment.start,
                direction: Axis.horizontal,
                children: List.generate(
                  widget.productDetails.product.colors.length,
                  (index) => Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: Material(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.r),
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(5.r),
                        onTap: () {
                          ref.read(selectedProductColorIndex.notifier).state =
                              index;
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 5.w, vertical: 3.h),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.r),
                            border: Border.all(
                              color:
                                  ref.watch(selectedProductColorIndex) == index
                                      ? EcommerceAppColor.primary
                                      : EcommerceAppColor.offWhite,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              widget.productDetails.product.colors[index]
                                      .name[0]
                                      .toUpperCase() +
                                  widget
                                      .productDetails.product.colors[index].name
                                      .substring(1),
                              style: AppTextStyle(context)
                                  .bodyTextSmall
                                  .copyWith(
                                    fontWeight: FontWeight.w500,
                                    color:
                                        ref.watch(selectedProductColorIndex) ==
                                                index
                                            ? EcommerceAppColor.primary
                                            : EcommerceAppColor.gray,
                                  ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
