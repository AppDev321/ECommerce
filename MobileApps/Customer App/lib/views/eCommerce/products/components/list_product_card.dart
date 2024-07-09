import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:razin_shop/components/ecommerce/add_to_cart_bottom_sheet.dart';
import 'package:razin_shop/components/ecommerce/increment_button.dart';
import 'package:razin_shop/config/app_color.dart';
import 'package:razin_shop/config/app_constants.dart';
import 'package:razin_shop/config/app_text_style.dart';
import 'package:razin_shop/config/theme.dart';
import 'package:razin_shop/controllers/common/master_controller.dart';
import 'package:razin_shop/gen/assets.gen.dart';
import 'package:razin_shop/models/eCommerce/cart/hive_cart_model.dart';
import 'package:razin_shop/models/eCommerce/product/product.dart';
import 'package:razin_shop/utils/global_function.dart';

class ListProductCard extends StatelessWidget {
  final Product product;
  final void Function()? onTap;
  final void Function()? onTapRemove;
  const ListProductCard({
    Key? key,
    required this.product,
    required this.onTap,
    this.onTapRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<HiveCartModel>>(
        valueListenable:
            Hive.box<HiveCartModel>(AppConstants.cartModelBox).listenable(),
        builder: (context, cartBox, _) {
          bool inCart = false;
          late int productQuantity = 0;
          late int index = 0;
          final cartItems = cartBox.values.toList();
          for (int i = 0; i < cartItems.length; i++) {
            final cartProduct = cartItems[i];
            if (cartProduct.productId == product.id) {
              inCart = true;
              productQuantity = cartProduct.productsQTY;
              index = i;
              break;
            }
          }
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
            child: Material(
              color: EcommerceAppColor.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(8.r),
                onTap: onTap,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height / 6.15,
                  child: Row(
                    children: [
                      _buildImageSection(context: context),
                      _buildDetailsSection(
                        context: context,
                        inCart: inCart,
                        productQuantity: productQuantity,
                        cartBox: cartBox,
                        index: index,
                        cartItems: cartItems,
                        onTapRemove: onTapRemove,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  Widget _buildImageSection({required BuildContext context}) {
    return Flexible(
      flex: 2,
      fit: FlexFit.tight,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: CachedNetworkImage(
              placeholder: (context, url) =>
                  const Center(child: CircularProgressIndicator()),
              imageUrl: product.thumbnail,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
          ),
          if (product.quantity == 0)
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
          if (product.discountPercentage != 0)
            Positioned(
              top: 4.h,
              left: 4.w,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.r),
                  color: EcommerceAppColor.red,
                ),
                child: Text(
                  '-${product.discountPercentage}%',
                  style: AppTextStyle(context).bodyTextSmall.copyWith(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                        color: colors(context).light,
                      ),
                ),
              ),
            )
        ],
      ),
    );
  }

  Widget _buildDetailsSection(
      {required BuildContext context,
      required bool inCart,
      required int productQuantity,
      required Box<HiveCartModel> cartBox,
      required int index,
      required List<HiveCartModel> cartItems,
      Function()? onTapRemove}) {
    return Flexible(
      flex: 3,
      fit: FlexFit.tight,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 11.w, vertical: 8.h),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        '${product.name}\n',
                        style: AppTextStyle(context)
                            .bodyText
                            .copyWith(fontWeight: FontWeight.w500),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (onTapRemove != null)
                      GestureDetector(
                        onTap: onTapRemove,
                        child: SvgPicture.asset(Assets.svg.trash),
                      )
                  ],
                ),
                Gap(8.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      child: Row(
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
                            style: AppTextStyle(context)
                                .bodyTextSmall
                                .copyWith(fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                    CircleAvatar(
                      radius: 2.5,
                      backgroundColor:
                          EcommerceAppColor.lightGray.withOpacity(0.3),
                    ),
                    Text(
                      '${product.totalSold} Sold',
                      style: AppTextStyle(context)
                          .bodyTextSmall
                          .copyWith(fontWeight: FontWeight.w500),
                    )
                  ],
                ),
                Gap(10.h),
                Consumer(builder: (context, ref, _) {
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
                              style: AppTextStyle(context).bodyText.copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
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
                                  .copyWith(fontWeight: FontWeight.w700),
                            ),
                          ],
                          Visibility(
                            visible: product.discountPrice > 0,
                            child: Text(
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
                                    decorationColor:
                                        EcommerceAppColor.lightGray,
                                  ),
                            ),
                          )
                        ],
                      ),
                      IncrementButton(
                        onTap: () {
                          showModalBottomSheet(
                            isDismissible: false,
                            isScrollControlled: true,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.r),
                            ),
                            context: context,
                            builder: (_) => AddToCartBottomSheet(
                              product: product,
                            ),
                          );
                        },
                      ),
                    ],
                  );
                })
              ],
            ),
            if (product.quantity == 0)
              Container(
                decoration: BoxDecoration(
                  color: EcommerceAppColor.white.withOpacity(0.6),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
