import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:gap/gap.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:razin_shop/components/ecommerce/app_logo.dart';
import 'package:razin_shop/components/ecommerce/custom_button.dart';
import 'package:razin_shop/components/ecommerce/custom_cart.dart';
import 'package:razin_shop/components/ecommerce/custom_transparent_button.dart';
import 'package:razin_shop/config/app_color.dart';
import 'package:razin_shop/config/app_constants.dart';
import 'package:razin_shop/config/theme.dart';
import 'package:razin_shop/controllers/eCommerce/cart/cart_controller.dart';
import 'package:razin_shop/controllers/eCommerce/product/product_controller.dart';
import 'package:razin_shop/controllers/eCommerce/shop/shop_controller.dart';
import 'package:razin_shop/controllers/misc/misc_controller.dart';
import 'package:razin_shop/generated/l10n.dart';
import 'package:razin_shop/models/eCommerce/cart/add_to_cart_model.dart';
import 'package:razin_shop/models/eCommerce/cart/hive_cart_model.dart';
import 'package:razin_shop/models/eCommerce/order/order_now_cart_model.dart';
import 'package:razin_shop/models/eCommerce/product/product_details.dart';
import 'package:razin_shop/routes.dart';
import 'package:razin_shop/utils/context_less_navigation.dart';
import 'package:razin_shop/views/eCommerce/products/components/product_color_picker.dart';
import 'package:razin_shop/views/eCommerce/products/components/product_description.dart';
import 'package:razin_shop/views/eCommerce/products/components/product_details_and_review.dart';
import 'package:razin_shop/views/eCommerce/products/components/product_image_page_view.dart';
import 'package:razin_shop/views/eCommerce/products/components/product_size_picker.dart';
import 'package:razin_shop/views/eCommerce/products/components/shop_info.dart';
import 'package:razin_shop/views/eCommerce/products/components/similar_products_widget.dart';

class EcommerceProductDetailsLayout extends ConsumerStatefulWidget {
  final int productId;
  const EcommerceProductDetailsLayout({
    super.key,
    required this.productId,
  });

  @override
  ConsumerState<EcommerceProductDetailsLayout> createState() =>
      _EcommerceProductDetailsLayoutState();
}

class _EcommerceProductDetailsLayoutState
    extends ConsumerState<EcommerceProductDetailsLayout> {
  bool isTextExpanded = false;
  bool isFavorite = false;
  bool isLoading = false;
  // change the status bar color to transparent

  @override
  Widget build(BuildContext context) {
    return LoadingWrapperWidget(
      isLoading: ref.watch(cartController).isLoading,
      child: Scaffold(
        backgroundColor:
            Theme.of(context).scaffoldBackgroundColor == EcommerceAppColor.black
                ? colors(context).dark
                : colors(context).accentColor,
        // appBar: AppBar(
        //   leading: IconButton(
        //     onPressed: () {
        //       ref.read(shopControllerProvider.notifier).review.clear();
        //       context.nav.pop();
        //     },
        //     icon: const Icon(Icons.arrow_back),
        //   ),
        //   surfaceTintColor: Theme.of(context).scaffoldBackgroundColor ==
        //           EcommerceAppColor.black
        //       ? colors(context).dark
        //       : colors(context).light,
        //   title: const Text(''),
        //   actions: [
        //     _buildAppBarRightRow(context: context),
        //   ],
        // ),
        bottomNavigationBar: ref
            .watch(productDetailsControllerProvider(widget.productId))
            .whenOrNull(
              data: (productDetails) => _buildBottomNavigationBar(
                  context: context, productDetails: productDetails),
            ),
        body: Stack(
          children: [
            ref.watch(productDetailsControllerProvider(widget.productId)).when(
                  data: (productDetails) => SingleChildScrollView(
                    child: AnimationLimiter(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: AnimationConfiguration.toStaggeredList(
                          duration: const Duration(milliseconds: 500),
                          childAnimationBuilder: (widget) => SlideAnimation(
                              verticalOffset: 50.h,
                              child: FadeInAnimation(
                                child: widget,
                              )),
                          children: [
                            Gap(2.h),
                            ProductImagePageView(
                                productDetails: productDetails),
                            Gap(14.h),
                            ProductDescription(productDetails: productDetails),
                            Gap(14.h),
                            Visibility(
                              visible: productDetails.product.colors.isNotEmpty,
                              child: ProductColorPicker(
                                  productDetails: productDetails),
                            ),
                            Gap(14.h),
                            Visibility(
                              visible: productDetails
                                  .product.productSizeList.isNotEmpty,
                              child: ProductSizePicker(
                                  productDetails: productDetails),
                            ),
                            Gap(14.h),
                            ShopInformation(productDetails: productDetails),
                            Gap(14.h),
                            ProductDetailsAndReview(
                              productDetails: productDetails,
                            ),
                            Gap(14.h),
                            SimilarProductsWidget(
                              productDetails: productDetails,
                            ),
                            Gap(14.h),
                          ],
                        ),
                      ),
                    ),
                  ),
                  error: ((error, stackTrace) => Center(
                        child: Text(
                          error.toString(),
                        ),
                      )),
                  loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(top: 26, left: 16, right: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      child: IconButton(
                        onPressed: () {
                          ref
                              .read(shopControllerProvider.notifier)
                              .review
                              .clear();
                          context.nav.pop();
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          color: colors(context).primaryColor,
                        ),
                      ),
                    ),
                    _buildAppBarRightRow(context: context),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _buildAppBarRightRow({required BuildContext context}) {
    return SizedBox(
      child: Padding(
        padding: EdgeInsets.only(right: 20.w, bottom: 6.h),
        child: Row(
          children: [
            CustomCartWidget(context: context),
            // Gap(10.w),
            // SvgPicture.asset(
            //   Assets.svg.share,
            //   width: 52.w,
            // )
          ],
        ),
      ),
    );
  }

  _buildBottomNavigationBar(
      {required BuildContext context, required ProductDetails productDetails}) {
    return ValueListenableBuilder<Box<HiveCartModel>>(
        valueListenable:
            Hive.box<HiveCartModel>(AppConstants.cartModelBox).listenable(),
        builder: (context, cartBox, _) {
          bool inCart = false;
          int index = 0;

          final cartItems = cartBox.values.toList();
          for (int i = 0; i < cartItems.length; i++) {
            final cartProduct = cartItems[i];
            if (cartProduct.productId == productDetails.product.id) {
              inCart = true;
              index = i;
              break;
            }
          }
          return Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            height: 70.h,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
              child: Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: CustomTransparentButton(
                      buttonTextColor: EcommerceAppColor.primary,
                      borderColor: EcommerceAppColor.primary,
                      buttonText: S.of(context).addToCart,
                      onTap: () {
                        final AddToCartModel addToCartModel = AddToCartModel(
                          productId: productDetails.product.id,
                          quantity: 1,
                          size:
                              productDetails.product.productSizeList.isNotEmpty
                                  ? productDetails
                                      .product
                                      .productSizeList[
                                          ref.read(selectedProductSizeIndex)]
                                      .name
                                  : null,
                          color: productDetails.product.colors.isNotEmpty
                              ? productDetails
                                  .product
                                  .colors[ref.read(selectedProductColorIndex)!]
                                  .name
                              : null,
                        );

                        ref
                            .read(cartController.notifier)
                            .addToCart(addToCartModel: addToCartModel);
                      },
                    ),
                  ),
                  Gap(10.w),
                  Flexible(
                    flex: 1,
                    child: CustomButton(
                      buttonText: S.of(context).buyNow,
                      onPressed: () {
                        final OrderNowCartModel orderNowCartModel =
                            OrderNowCartModel(
                          shopId: productDetails.product.shop.id,
                          shopName: productDetails.product.shop.name,
                          productId: productDetails.product.id,
                          price: productDetails.product.price,
                          discountPrice: productDetails.product.discountPrice,
                          productImage:
                              productDetails.product.thumbnails.first.thumbnail,
                          productName: productDetails.product.name,
                          size:
                              productDetails.product.productSizeList.isNotEmpty
                                  ? productDetails
                                      .product
                                      .productSizeList[
                                          ref.read(selectedProductSizeIndex)]
                                      .name
                                  : null,
                          color: productDetails.product.colors.isNotEmpty
                              ? productDetails
                                  .product
                                  .colors[ref.read(selectedProductColorIndex)!]
                                  .name
                              : null,
                        );
                        context.nav.pushNamed(
                          Routes.getOrderNowViewRouteName(
                              AppConstants.appServiceName),
                          arguments: orderNowCartModel,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}

class LoadingWrapperWidget extends StatelessWidget {
  final Widget child;
  final bool isLoading;
  const LoadingWrapperWidget({
    Key? key,
    required this.child,
    required this.isLoading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          const Opacity(
            opacity: 0.3,
            child: ModalBarrier(dismissible: false, color: Colors.black),
          ),
        if (isLoading)
          const Center(
            child: AppLogo(
              withAppName: false,
              isAnimation: true,
            ),
          ),
      ],
    );
  }
}
