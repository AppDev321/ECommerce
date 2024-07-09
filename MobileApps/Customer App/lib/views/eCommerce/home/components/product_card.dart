import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:razin_shop/components/ecommerce/add_to_cart_bottom_sheet.dart';
import 'package:razin_shop/components/ecommerce/increment_button.dart';
import 'package:razin_shop/config/app_color.dart';
import 'package:razin_shop/config/app_text_style.dart';
import 'package:razin_shop/config/theme.dart';
import 'package:razin_shop/controllers/common/master_controller.dart';
import 'package:razin_shop/controllers/misc/misc_controller.dart';
import 'package:razin_shop/models/eCommerce/product/product.dart';
import 'package:razin_shop/utils/global_function.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final void Function()? onTap;

  const ProductCard({
    Key? key,
    required this.product,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: colors(context).light,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0.r),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(8.0.r),
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0.r),
            color: EcommerceAppColor.white,
            boxShadow: const [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.04),
                offset: Offset(0, 2),
                blurRadius: 10,
                spreadRadius: 0,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProductImage(context: context),
              _buildProductInformation(context: context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductImage({required BuildContext context}) {
    return Stack(
      children: [
        SizedBox(
          height: 120.h,
          width: double.infinity,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5.r),
            child: CachedNetworkImage(
              imageUrl: product.thumbnail,
              fit: BoxFit.cover,
            ),
          ),
        ),
        if (product.discountPercentage != 0)
          _buildDiscountBadge(context: context),
        if (product.quantity == 0) ...[
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.r),
                color: Colors.black.withOpacity(0.6),
              ),
              child: Center(
                child: Text(
                  'Out of Stock',
                  style: AppTextStyle(context).subTitle.copyWith(
                        color: colors(context).light,
                      ),
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildDiscountBadge({required BuildContext context}) {
    return Positioned(
      top: 0,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.r),
          color: EcommerceAppColor.red,
        ),
        child: Text(
          '-${product.discountPercentage}%',
          style: AppTextStyle(context).bodyTextSmall.copyWith(
                color: colors(context).light,
                fontWeight: FontWeight.w700,
              ),
        ),
      ),
    );
  }

  Widget _buildProductInformation({required BuildContext context}) {
    return Stack(
      children: [
        SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(5.h),
              Text(
                '${product.name}\n',
                style: AppTextStyle(context)
                    .bodyText
                    .copyWith(fontWeight: FontWeight.w500),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              Gap(10.h),
              _buildReviewAndSoldCount(context: context),
              Gap(product.discountPrice > 0 ? 8.h : 10.h),
              _buildPriceAndAddToCart(context: context),
            ],
          ),
        ),
        if (product.quantity == 0 || product.quantity < 0)
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                color: EcommerceAppColor.white.withOpacity(0.6),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildReviewAndSoldCount({required BuildContext context}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(
              Icons.star_rounded,
              size: 16.sp,
              color: EcommerceAppColor.carrotOrange,
            ),
            Text(
              product.rating.toString(),
              style: AppTextStyle(context).bodyTextSmall.copyWith(
                    fontWeight: FontWeight.w700,
                    color: colors(context).dark,
                  ),
            ),
            Gap(5.w),
            Text(
              '(${product.totalReviews})',
              style: AppTextStyle(context).bodyTextSmall.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            )
          ],
        ),
        CircleAvatar(
          radius: 2.5,
          backgroundColor: EcommerceAppColor.lightGray.withOpacity(0.3),
        ),
        Text(
          '${product.totalSold} Sold',
          style: AppTextStyle(context).bodyTextSmall.copyWith(
                fontWeight: FontWeight.w500,
              ),
        ),
      ],
    );
  }

  Widget _buildPriceAndAddToCart({required BuildContext context}) {
    return Consumer(builder: (context, ref, _) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              if (product.discountPrice > 0) ...[
                Text(
                  GlobalFunction.price(
                    currency: ref
                        .read(masterControllerProvider.notifier)
                        .materModel
                        .data
                        .currency
                        .symbol,
                    position: ref
                        .read(masterControllerProvider.notifier)
                        .materModel
                        .data
                        .currency
                        .position,
                    price: product.discountPrice.toString(),
                  ),
                  style: AppTextStyle(context)
                      .bodyText
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ] else ...[
                Text(
                  GlobalFunction.price(
                    currency: ref
                        .read(masterControllerProvider.notifier)
                        .materModel
                        .data
                        .currency
                        .symbol,
                    position: ref
                        .read(masterControllerProvider.notifier)
                        .materModel
                        .data
                        .currency
                        .position,
                    price: product.price.toString(),
                  ),
                  style: AppTextStyle(context)
                      .bodyText
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ],
              if (product.discountPrice > 0) ...[
                Text(
                  GlobalFunction.price(
                    currency: ref
                        .read(masterControllerProvider.notifier)
                        .materModel
                        .data
                        .currency
                        .symbol,
                    position: ref
                        .read(masterControllerProvider.notifier)
                        .materModel
                        .data
                        .currency
                        .position,
                    price: product.price.toString(),
                  ),
                  style: AppTextStyle(context).bodyText.copyWith(
                        color: EcommerceAppColor.lightGray,
                        decoration: TextDecoration.lineThrough,
                        decorationColor: EcommerceAppColor.lightGray,
                      ),
                ),
              ]
            ],
          ),
          IncrementButton(
            onTap: () {
              ref.refresh(selectedProductSizeIndex.notifier).state;
              ref.refresh(selectedProductColorIndex.notifier).state;
              showModalBottomSheet(
                isScrollControlled: true,
                isDismissible: false,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r),
                ),
                context: context,
                builder: (_) => AddToCartBottomSheet(
                  product: product,
                ),
              );
            },
          )
        ],
      );
    });
  }
}
