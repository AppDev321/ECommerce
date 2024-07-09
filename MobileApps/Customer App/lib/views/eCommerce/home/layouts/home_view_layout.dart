import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:razin_shop/components/ecommerce/app_logo.dart';
import 'package:razin_shop/components/ecommerce/custom_search_field.dart';
import 'package:razin_shop/config/app_color.dart';
import 'package:razin_shop/config/app_constants.dart';
import 'package:razin_shop/config/app_text_style.dart';
import 'package:razin_shop/config/theme.dart';
import 'package:razin_shop/controllers/common/master_controller.dart';
import 'package:razin_shop/controllers/eCommerce/dashboard/dashboard_controller.dart';
import 'package:razin_shop/controllers/misc/misc_controller.dart';
import 'package:razin_shop/gen/assets.gen.dart';
import 'package:razin_shop/generated/l10n.dart';
import 'package:razin_shop/models/eCommerce/category/category.dart';
import 'package:razin_shop/models/eCommerce/dashboard/dashboard.dart';
// import 'package:razin_shop/models/eCommerce/order/order_details_model.dart';
import 'package:razin_shop/models/eCommerce/order/order_model.dart';
import 'package:razin_shop/models/eCommerce/product/product.dart' as product;
import 'package:razin_shop/routes.dart';
import 'package:razin_shop/services/common/hive_service_provider.dart';
import 'package:razin_shop/utils/context_less_navigation.dart';
import 'package:razin_shop/utils/global_function.dart';
import 'package:razin_shop/views/eCommerce/checkout/components/address_modal_bottom_sheet.dart';
import 'package:razin_shop/views/eCommerce/home/components/category_card.dart';
import 'package:razin_shop/views/eCommerce/home/components/deal_of_day_widget.dart';
import 'package:razin_shop/views/eCommerce/home/components/popular_product_card.dart';
import 'package:razin_shop/views/eCommerce/home/components/product_card.dart';
import 'package:razin_shop/views/eCommerce/home/components/shop_card.dart';

import '../../../../models/eCommerce/shop/shop.dart';

class EcommerceHomeViewLayout extends ConsumerStatefulWidget {
  const EcommerceHomeViewLayout({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<EcommerceHomeViewLayout> createState() =>
      _EcommerceHomeViewLayoutState();
}

class _EcommerceHomeViewLayoutState
    extends ConsumerState<EcommerceHomeViewLayout> {
  final TextEditingController productSearchController = TextEditingController();
  PageController pageController = PageController();
  final ScrollController scrollController = ScrollController();
  bool isHeaderVisible = true;

  @override
  void initState() {
    ref.refresh(currentPageController.notifier).state;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
    pageController.addListener(() {
      int? newPage = pageController.page?.round();
      if (newPage != ref.read(currentPageController)) {
        setState(() {
          ref.read(currentPageController.notifier).state = newPage!;
        });
      }
    });
    scrollController.addListener(() {
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (isHeaderVisible) {
          setState(() {
            isHeaderVisible = false;
          });
        }
      } else if (scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (!isHeaderVisible) {
          // Check if the scroll position is at the bottom
          if (scrollController.position.pixels ==
              scrollController.position.minScrollExtent) {
            setState(() {
              isHeaderVisible = true;
            });
          }
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    if (mounted) scrollController.dispose();
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _buildHeaderWidget(context),
          Flexible(
            flex: 5,
            child: ref.watch(dashboardControllerProvider).when(
                  data: (dashboardData) => RefreshIndicator(
                    onRefresh: () async {
                      ref.refresh(dashboardControllerProvider).value;
                    },
                    child: SingleChildScrollView(
                      controller: scrollController,
                      child: AnimationLimiter(
                        child: Column(
                          children: AnimationConfiguration.toStaggeredList(
                            duration: const Duration(milliseconds: 375),
                            childAnimationBuilder: (widget) => SlideAnimation(
                              verticalOffset: 50.h,
                              child: FadeInAnimation(child: widget),
                            ),
                            children: [
                              Gap(20.h),
                              _buildBannerWidget(context, dashboardData),
                              Gap(20.h),
                              _buildCategoriesWidget(
                                context: context,
                                categories: dashboardData.categories,
                              ),
                              Gap(20.h),
                              DealOfDayWidget(
                                targetDate:
                                    DateTime.parse('2023-12-30T23:00:00'),
                              ),
                              _buildPopularProductWidget(
                                context: context,
                                products: dashboardData.popularProducts,
                              ),
                              Visibility(
                                visible: ref
                                    .read(masterControllerProvider.notifier)
                                    .materModel
                                    .data
                                    .isMultiVendor,
                                child: _buildShopsWidget(
                                  context: context,
                                  shops: dashboardData.shops,
                                ),
                              ),
                              Visibility(
                                visible: ref
                                    .read(masterControllerProvider.notifier)
                                    .materModel
                                    .data
                                    .isMultiVendor,
                                child: Divider(
                                  color: colors(context).accentColor,
                                  thickness: 2,
                                ),
                              ),
                              Gap(10.h),
                              _buildBeautyProductWidget(
                                products: dashboardData.justForYou.products,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  error: ((error, stackTrace) => Center(
                        child: Text(
                          error.toString(),
                          style: AppTextStyle(context).subTitle,
                        ),
                      )),
                  loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
          ),
        ],
      ),
    );
  }

  Stack _buildBeautyProductWidget({required List<product.Product> products}) {
    return Stack(
      children: [
        GridView.builder(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h)
              .copyWith(top: 34.h, bottom: 80.h),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: calculateCrossAxisCount(context),
            crossAxisSpacing: 16.w,
            mainAxisSpacing: 16.h,
            childAspectRatio: 0.66,
          ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            return ProductCard(
              product: products[index],
              onTap: () {
                context.nav.pushNamed(
                  Routes.getProductDetailsRouteName(
                      AppConstants.appServiceName),
                  arguments: products[index].id,
                );
              },
            );
          },
        ),
        Positioned(
          left: 20.w,
          child: Text(
            S.of(context).justForYou,
            style: AppTextStyle(context).subTitle,
          ),
        ),
        Positioned(
          bottom: 20.h,
          left: 20.w,
          right: 20.w,
          child: _buildViewMoreButton(),
        ),
      ],
    );
  }

  Container _buildCategoriesWidget({
    required BuildContext context,
    required List<Category> categories,
  }) {
    return Container(
      color: colors(context).light,
      child: Column(
        children: [
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: 16.h).copyWith(right: 4.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  S.of(context).categories,
                  style: AppTextStyle(context).buttonText,
                ),
                TextButton(
                  onPressed: () {
                    context.nav.pushNamed(
                      Routes.getCategoriesViewRouteName(
                          AppConstants.appServiceName),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        S.of(context).viewMore,
                        style: AppTextStyle(context).bodyText.copyWith(
                              color: colors(context).primaryColor,
                            ),
                      ),
                      Gap(3.w),
                      SvgPicture.asset(
                        Assets.svg.arrowRight,
                        colorFilter: ColorFilter.mode(
                          colors(context).primaryColor!,
                          BlendMode.srcIn,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Gap(10.h),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Gap(10.w),
                ...List.generate(
                    categories.length,
                    (index) => CategoryCard(
                          category: categories[index],
                          onTap: () {
                            context.nav.pushNamed(
                              Routes.getProductsViewRouteName(
                                  AppConstants.appServiceName),
                              arguments: [
                                categories[index].id,
                                categories[index].name,
                                null
                              ],
                            );
                          },
                        )),
                Gap(10.w),
              ],
            ),
          ),

          // SizedBox(
          //   height: MediaQuery.of(context).size.height / 6.8,
          //   child: ListView.builder(
          //     padding: EdgeInsets.only(
          //       left: 10.w,
          //       right: 10.w,
          //     ),
          //     scrollDirection: Axis.horizontal,
          //     itemCount: categories.length,
          //     itemBuilder: ((context, index) => ),
          //   ),
          // ),
        ],
      ),
    );
  }

  Container _buildShopsWidget({
    required BuildContext context,
    required List<Shop> shops,
  }) {
    return Container(
      color: colors(context).light,
      child: Column(
        children: [
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: 20.h).copyWith(right: 6.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  S.of(context).shops,
                  style: AppTextStyle(context).subTitle,
                ),
                TextButton(
                  onPressed: () {
                    context.nav.pushNamed(
                      Routes.getShopsViewRouteName(
                        AppConstants.appServiceName,
                      ),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        S.of(context).viewMore,
                        style: AppTextStyle(context).bodyText.copyWith(
                              color: colors(context).primaryColor,
                            ),
                      ),
                      Gap(3.w),
                      SvgPicture.asset(
                        Assets.svg.arrowRight,
                        colorFilter: ColorFilter.mode(
                          colors(context).primaryColor!,
                          BlendMode.srcIn,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 8.h,
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              scrollDirection: Axis.horizontal,
              itemCount: shops.length,
              itemBuilder: ((context, index) => Padding(
                    padding: EdgeInsets.only(right: 10.w),
                    child: ShopCardCircle(
                      callback: () {
                        context.nav.pushNamed(
                          Routes.getShopViewRouteName(
                              AppConstants.appServiceName),
                          arguments: shops[index].id,
                        );
                      },
                      shop: shops[index],
                    ),
                  )),
            ),
          ),
        ],
      ),
    );
  }

  Container _buildPopularProductWidget({
    required BuildContext context,
    required List<product.Product> products,
  }) {
    return Container(
      decoration: BoxDecoration(color: colors(context).accentColor),
      child: Column(
        children: [
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: 16.w).copyWith(right: 4.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  S.of(context).popularProducts,
                  style: AppTextStyle(context).subTitle,
                ),
                TextButton(
                  onPressed: () {
                    context.nav.pushNamed(
                      Routes.getProductsViewRouteName(
                          AppConstants.appServiceName),
                      arguments: [null, 'Popular', 'popular_product'],
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        S.of(context).viewMore,
                        style: AppTextStyle(context).bodyText.copyWith(
                              color: colors(context).primaryColor,
                            ),
                      ),
                      Gap(3.w),
                      SvgPicture.asset(
                        Assets.svg.arrowRight,
                        colorFilter: ColorFilter.mode(
                            colors(context).primaryColor!, BlendMode.srcIn),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 2.8,
            child: ListView.builder(
              padding: EdgeInsets.only(left: 16.w),
              scrollDirection: Axis.horizontal,
              itemCount: products.length,
              itemBuilder: ((context, index) => PopularProductCard(
                    product: products[index],
                    onTap: () {
                      context.nav.pushNamed(
                        Routes.getProductDetailsRouteName(
                            AppConstants.appServiceName),
                        arguments: products[index].id,
                      );
                    },
                  )),
            ),
          ),
          Gap(20.h),
        ],
      ),
    );
  }

  Stack _buildBannerWidget(BuildContext context, Dashboard dashboardData) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10.w),
          height: 130.h,
          width: double.infinity,
          child: PageView.builder(
            controller: pageController,
            itemCount: dashboardData.banners.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: dashboardData.banners[index].thumbnail),
                ),
              );
            },
          ),
        ),
        Positioned(
          bottom: 16.h,
          left: 50.w,
          right: 50.w,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              dashboardData.banners.length,
              (index) => AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 6),
                decoration: BoxDecoration(
                  color: ref.read(currentPageController.notifier).state == index
                      ? colors(context).light
                      : colors(context).accentColor!.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(30.sp),
                ),
                height: 8.h,
                width: 8.w,
              ),
            ).toList(),
          ),
        )
      ],
    );
  }

  Widget _buildHeaderWidget(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      padding: EdgeInsets.symmetric(
        horizontal: 20.w,
        vertical: 20.h,
      ).copyWith(top: !isHeaderVisible ? 20.h : 50.h),
      decoration: _buildContainerDecoration(context),
      child: ValueListenableBuilder<Box>(
          valueListenable: Hive.box(AppConstants.userBox).listenable(),
          builder: (context, userBox, _) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if (isHeaderVisible) ...[
                  ref.read(hiveServiceProvider).userIsLoggedIn()
                      ? GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(16.r),
                                  topRight: Radius.circular(16.r),
                                ),
                              ),
                              context: context,
                              builder: (_) => const AddressModalBottomSheet(),
                            );
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 500),
                            child: _buildHeaderRow(context),
                          ),
                        )
                      : const AppLogo(
                          isAnimation: true,
                          centerAlign: false,
                        ),
                  Gap(10.h),
                ],
                Gap(10.h),
                GestureDetector(
                  onTap: () {
                    context.nav.pushNamed(
                      Routes.getProductsViewRouteName(
                        AppConstants.appServiceName,
                      ),
                      arguments: [null, 'All Product', null],
                    );
                  },
                  child: AbsorbPointer(
                    absorbing: true,
                    child: CustomSearchField(
                      name: 'product_search',
                      hintText: S.of(context).searchProduct,
                      textInputType: TextInputType.text,
                      controller: productSearchController,
                      widget: Container(
                        margin: EdgeInsets.all(10.sp),
                        child: SvgPicture.asset(Assets.svg.searchHome),
                      ),
                    ),
                  ),
                )
              ],
            );
          }),
    );
  }

  Decoration _buildContainerDecoration(BuildContext context) {
    return BoxDecoration(
      color: Theme.of(context).scaffoldBackgroundColor,
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(16),
        bottomRight: Radius.circular(16),
      ),
      boxShadow: [
        BoxShadow(
          color: colors(context).accentColor ?? EcommerceAppColor.offWhite,
          blurRadius: 20,
          spreadRadius: 5,
          offset: const Offset(
            0,
            2,
          ),
        )
      ],
    );
  }

  Widget _buildHeaderRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildLeftRow(context),
        Icon(
          Icons.expand_more,
          color: colors(context).hintTextColor,
        ),
      ],
    );
  }

  Widget _buildLeftRow(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          const AppLogo(
            withAppName: false,
            isAnimation: true,
          ),
          Gap(10.w),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  S.of(context).deliverTo,
                  style: AppTextStyle(context)
                      .bodyTextSmall
                      .copyWith(fontWeight: FontWeight.w700),
                ),
                ValueListenableBuilder(
                    valueListenable:
                        Hive.box(AppConstants.userBox).listenable(),
                    builder: (context, box, _) {
                      final addressData = box.get(AppConstants.defaultAddress);

                      return Text(
                        defaultAddress(addressData),
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyle(context).bodyText.copyWith(
                            fontSize: 11, fontWeight: FontWeight.w600),
                      );
                    })
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildViewMoreButton() {
    return OutlinedButton(
      onPressed: () {
        context.nav.pushNamed(
          Routes.getProductsViewRouteName(AppConstants.appServiceName),
          arguments: [null, 'Just For You', 'just_for_you'],
        );
      },
      style: OutlinedButton.styleFrom(
        backgroundColor: EcommerceAppColor.blueChalk,
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        side: BorderSide(color: EcommerceAppColor.primary, width: 1),
        minimumSize: Size(MediaQuery.of(context).size.width, 45.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            S.of(context).viewMore,
            style: AppTextStyle(context).bodyTextSmall.copyWith(
                color: colors(context).primaryColor,
                fontWeight: FontWeight.w600),
          ),
          Gap(3.w),
          SvgPicture.asset(
            Assets.svg.arrowRight,
            colorFilter: ColorFilter.mode(
              colors(context).primaryColor!,
              BlendMode.srcIn,
            ),
          )
        ],
      ),
    );
  }

  String defaultAddress(dynamic data) {
    if (data != null) {
      Map<String, dynamic> addressStringKeys = data.cast<String, dynamic>();
      Address address = Address.fromJson(addressStringKeys);
      return GlobalFunction.formatDeliveryAddress(
          context: context, address: address);
    }
    return '';
  }

  int calculateCrossAxisCount(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth > 600) {
      return 3;
    } else {
      return 2;
    }
  }

  double calculateAspectRatio(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double aspectRatio = screenWidth / screenHeight / 0.8;

    return aspectRatio;
  }

  final List<String> bannerImageList = [
    Assets.png.bannerImage.keyName,
    Assets.png.bannerImage.keyName,
    Assets.png.bannerImage.keyName,
    Assets.png.bannerImage.keyName,
  ];
}
