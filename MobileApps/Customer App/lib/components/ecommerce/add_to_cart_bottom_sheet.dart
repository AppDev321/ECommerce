// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:razin_shop/components/ecommerce/custom_button.dart';
import 'package:razin_shop/components/ecommerce/custom_transparent_button.dart';
import 'package:razin_shop/config/app_color.dart';
import 'package:razin_shop/config/app_constants.dart';
import 'package:razin_shop/config/app_text_style.dart';
import 'package:razin_shop/config/theme.dart';
import 'package:razin_shop/controllers/common/master_controller.dart';
import 'package:razin_shop/controllers/eCommerce/cart/cart_controller.dart';
import 'package:razin_shop/controllers/misc/misc_controller.dart';
import 'package:razin_shop/generated/l10n.dart';
import 'package:razin_shop/models/eCommerce/cart/add_to_cart_model.dart';
import 'package:razin_shop/models/eCommerce/order/order_now_cart_model.dart';
import 'package:razin_shop/routes.dart';
import 'package:razin_shop/services/common/hive_service_provider.dart';
import 'package:razin_shop/utils/context_less_navigation.dart';
import 'package:razin_shop/views/eCommerce/products/layouts/product_details_layout.dart';

import '../../models/eCommerce/product/product.dart';

class AddToCartBottomSheet extends StatelessWidget {
  final Product product;
  const AddToCartBottomSheet({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      return Container(
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 18.h,
        ).copyWith(right: 8.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(6.r),
            topRight: Radius.circular(16.r),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Select',
                  style:
                      AppTextStyle(context).subTitle.copyWith(fontSize: 20.sp),
                ),
                IconButton(
                  onPressed: () {
                    context.nav.pop();
                  },
                  icon: Icon(
                    Icons.close,
                    size: 24.sp,
                  ),
                )
              ],
            ),
            Gap(6.h),
            _buildProductCard(),
            Gap(3.h),
            Visibility(
              visible: product.colors.isNotEmpty ||
                  product.productSizeList.isNotEmpty,
              child: _buildAttributeWidget(),
            ),
            Gap(16.h),
            _buildBottomRow(),
          ],
        ),
      );
    });
  }

  Widget _buildProductCard() {
    return Consumer(builder: (context, ref, _) {
      return SizedBox(
        height: 126.h,
        width: double.infinity,
        child: Row(
          children: [
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: CachedNetworkImage(
                imageUrl: product.thumbnail,
                fit: BoxFit.cover,
              ),
            ),
            Flexible(
              flex: 2,
              fit: FlexFit.tight,
              child: Padding(
                padding: EdgeInsets.all(8.dm),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${product.name}\n',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyle(ContextLess.context)
                          .bodyText
                          .copyWith(fontWeight: FontWeight.w500),
                    ),
                    Gap(8.h),
                    if (product.discountPrice > 0) ...[
                      Text(
                        ref
                                .read(masterControllerProvider.notifier)
                                .materModel
                                .data
                                .currency
                                .symbol +
                            product.discountPrice.toString(),
                        style: AppTextStyle(context)
                            .bodyText
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ] else ...[
                      Text(
                        ref
                                .read(masterControllerProvider.notifier)
                                .materModel
                                .data
                                .currency
                                .symbol +
                            product.price.toString(),
                        style: AppTextStyle(context)
                            .bodyText
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                    if (product.discountPrice > 0) ...[
                      Text(
                        ref
                                .read(masterControllerProvider.notifier)
                                .materModel
                                .data
                                .currency
                                .symbol +
                            product.price.toString(),
                        style: AppTextStyle(context).bodyText.copyWith(
                              color: EcommerceAppColor.lightGray,
                              decoration: TextDecoration.lineThrough,
                              decorationColor: EcommerceAppColor.lightGray,
                            ),
                      ),
                    ]
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildAttributeWidget() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(8.r),
      decoration: BoxDecoration(
        color: colors(ContextLess.context).accentColor,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        children: [
          Visibility(
            visible: product.colors.isNotEmpty,
            child: _buildColorPickerWidget(),
          ),
          Gap(4.h),
          Visibility(
            visible: product.productSizeList.isNotEmpty,
            child: _buildSizePicker(),
          ),
        ],
      ),
    );
  }

  Widget _buildColorPickerWidget() {
    return Consumer(builder: (context, ref, _) {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.dm),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: colors(context).light,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.of(context).color,
              style: AppTextStyle(context).bodyText.copyWith(fontSize: 16.sp),
            ),
            Gap(8.h),
            Row(
              children: [
                Wrap(
                  alignment: WrapAlignment.start,
                  direction: Axis.horizontal,
                  children: List.generate(
                    product.colors.length,
                    (index) => Padding(
                      padding: EdgeInsets.only(right: 8.w),
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
                            padding: EdgeInsets.all(8.dm),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.r),
                              border: Border.all(
                                color: ref.watch(selectedProductColorIndex) ==
                                        index
                                    ? EcommerceAppColor.primary
                                    : EcommerceAppColor.offWhite,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                product.colors[index].name[0].toUpperCase() +
                                    product.colors[index].name.substring(1),
                                style: AppTextStyle(context).bodyText.copyWith(
                                      color: ref.watch(
                                                  selectedProductColorIndex) ==
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
    });
  }

  Widget _buildSizePicker() {
    return Consumer(builder: (context, ref, _) {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.dm),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: colors(context).light,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.of(context).size,
              style: AppTextStyle(context).bodyText.copyWith(
                    fontSize: 16.sp,
                  ),
            ),
            Gap(10.h),
            Row(
              children: [
                Wrap(
                  alignment: WrapAlignment.start,
                  direction: Axis.horizontal,
                  children: List.generate(
                    product.productSizeList.length,
                    (index) => Padding(
                      padding: EdgeInsets.only(right: 8.w),
                      child: Material(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.r),
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(5.r),
                          onTap: () {
                            ref.read(selectedProductSizeIndex.notifier).state =
                                index;
                          },
                          child: Container(
                            padding: EdgeInsets.all(8.r),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.r),
                              border: Border.all(
                                color:
                                    ref.watch(selectedProductSizeIndex) == index
                                        ? EcommerceAppColor.primary
                                        : EcommerceAppColor.offWhite,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                product.productSizeList[index].name,
                                style: AppTextStyle(context).bodyText.copyWith(
                                      color:
                                          ref.watch(selectedProductSizeIndex) ==
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
    });
  }

  Widget _buildBottomRow() {
    return Consumer(builder: (context, ref, _) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: Row(
          children: [
            Flexible(
              flex: 1,
              child: CustomTransparentButton(
                borderColor: colors(ContextLess.context).primaryColor,
                buttonTextColor: colors(ContextLess.context).primaryColor,
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (_) => LoadingWrapperWidget(
                      isLoading: ref.watch(cartController).isLoading,
                      child: Container(),
                    ),
                  );
                  final AddToCartModel addToCartModel = AddToCartModel(
                    productId: product.id,
                    quantity: 1,
                    size: product.productSizeList.isNotEmpty
                        ? product
                            .productSizeList[ref.read(selectedProductSizeIndex)]
                            .name
                        : null,
                    color: product.colors.isNotEmpty
                        ? product
                            .colors[ref.read(selectedProductColorIndex)!].name
                        : null,
                  );

                  ref
                      .read(cartController.notifier)
                      .addToCart(
                        addToCartModel: addToCartModel,
                      )
                      .then((value) {
                    ref
                        .read(hiveServiceProvider)
                        .getAuthToken()
                        .then((token) => [
                              if (token != null)
                                Navigator.of(context)
                                  ..pop()
                                  ..pop()
                            ]);
                  });
                },
                buttonText: S.of(ContextLess.context).addToCart,
              ),
            ),
            Gap(16.w),
            Flexible(
              flex: 1,
              child: CustomButton(
                buttonText: S.of(ContextLess.context).buyNow,
                onPressed: () {
                  final OrderNowCartModel orderNowCartModel = OrderNowCartModel(
                    shopId: product.shop.id,
                    shopName: product.shop.name,
                    productId: product.id,
                    price: product.price,
                    discountPrice: product.discountPrice,
                    productImage: product.thumbnail,
                    productName: product.name,
                    size: product.productSizeList.isNotEmpty
                        ? product
                            .productSizeList[ref.read(selectedProductSizeIndex)]
                            .name
                        : null,
                    color: product.colors.isNotEmpty
                        ? product
                            .colors[ref.read(selectedProductColorIndex)!].name
                        : null,
                  );
                  context.nav.popAndPushNamed(
                    Routes.getOrderNowViewRouteName(
                        AppConstants.appServiceName),
                    arguments: orderNowCartModel,
                  );
                },
              ),
            )
          ],
        ),
      );
    });
  }
}
