// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:razin_shop/components/ecommerce/custom_cart.dart';
import 'package:razin_shop/components/ecommerce/custom_search_field.dart';
import 'package:razin_shop/components/ecommerce/product_not_found.dart';
import 'package:razin_shop/config/app_color.dart';
import 'package:razin_shop/config/app_constants.dart';
import 'package:razin_shop/config/app_text_style.dart';
import 'package:razin_shop/config/theme.dart';
import 'package:razin_shop/controllers/eCommerce/product/product_controller.dart';
import 'package:razin_shop/gen/assets.gen.dart';
import 'package:razin_shop/generated/l10n.dart';
import 'package:razin_shop/models/eCommerce/category/category.dart';
import 'package:razin_shop/models/eCommerce/common/product_filter_model.dart';
import 'package:razin_shop/models/eCommerce/product/product.dart';
import 'package:razin_shop/routes.dart';
import 'package:razin_shop/utils/context_less_navigation.dart';
import 'package:razin_shop/views/eCommerce/home/components/product_card.dart';
import 'package:razin_shop/views/eCommerce/products/components/filter_modal_bottom_sheet.dart';
import 'package:razin_shop/views/eCommerce/products/components/list_product_card.dart';

class EcommerceShopProductsLayout extends ConsumerStatefulWidget {
  final int shopId;
  final String shopName;
  final int categoryId;
  final List<Category> categories;
  const EcommerceShopProductsLayout({
    super.key,
    required this.shopId,
    required this.shopName,
    required this.categoryId,
    required this.categories,
  });

  @override
  ConsumerState<EcommerceShopProductsLayout> createState() =>
      _EcommerceShopProductsLayoutState();
}

class _EcommerceShopProductsLayoutState
    extends ConsumerState<EcommerceShopProductsLayout> {
  final ScrollController scrollController = ScrollController();
  final TextEditingController searchController = TextEditingController();
  late int? selectedCategoryId;
  bool isList = true;
  int page = 1;
  int perPage = 20;
  bool loading = false;
  List<FilterCategory> filterCategoryList = [
    FilterCategory(id: 0, name: 'All')
  ];
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        selectedCategoryId = widget.categoryId;
      });

      setCategory(categories: widget.categories);

      ref.read(productControllerProvider.notifier).getCategoryWiseProducts(
            productFilterModel: ProductFilterModel(
              page: 1,
              perPage: 20,
              shopId: widget.shopId,
              categoryId: widget.categoryId,
            ),
            isPagination: false,
          );
    });

    scrollController.addListener(() {
      productScrollListener();
    });
    super.initState();
  }

  setCategory({required List<Category> categories}) {
    for (Category category in categories) {
      filterCategoryList.add(
        FilterCategory(id: category.id, name: category.name),
      );
    }
  }

  void productScrollListener() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent) {
      if (ref.watch(productControllerProvider.notifier).products.length <
              ref.watch(productControllerProvider.notifier).total! &&
          !ref.watch(productControllerProvider)) {
        page++;
        loading = true;
        ref.read(productControllerProvider.notifier).getCategoryWiseProducts(
              isPagination: true,
              productFilterModel: ProductFilterModel(
                page: page,
                perPage: perPage,
                shopId: widget.shopId,
                categoryId: selectedCategoryId,
              ),
            );
      }
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor ==
              const Color.fromARGB(255, 1, 1, 2)
          ? colors(context).dark
          : colors(context).accentColor,
      body: Column(
        children: [
          _buildHeaderWidget(context: context),
          _buildProductsWidget(context: context),
        ],
      ),
    );
  }

  Widget _buildHeaderWidget({required BuildContext context}) {
    return Container(
      color:
          Theme.of(context).scaffoldBackgroundColor == EcommerceAppColor.black
              ? colors(context).dark
              : colors(context).light,
      child: Column(
        children: [
          _buildHeaderRow(context: context),
          _buildFilterRow(context: context),
          const Divider(
            color: EcommerceAppColor.offWhite,
            height: 2,
            thickness: 2,
          ),
          Container(
            height: 65.h,
            color: EcommerceAppColor.white,
            child: ListView.builder(
                padding: EdgeInsets.only(left: 15.w),
                scrollDirection: Axis.horizontal,
                itemCount: filterCategoryList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      if (searchController.text.isNotEmpty) {
                        searchController.clear();
                      }
                      setState(() {
                        selectedCategoryId = filterCategoryList[index].id;
                      });
                      page = 1;
                      loading = false;
                      ref
                          .read(productControllerProvider.notifier)
                          .getCategoryWiseProducts(
                            productFilterModel: ProductFilterModel(
                              page: page,
                              perPage: perPage,
                              shopId: widget.shopId,
                              categoryId: selectedCategoryId == 0
                                  ? null
                                  : selectedCategoryId,
                            ),
                            isPagination: false,
                          );
                    },
                    child: Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 16.h, horizontal: 5.w),
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(
                          color:
                              selectedCategoryId == filterCategoryList[index].id
                                  ? const Color.fromARGB(255, 131, 34, 255)
                                  : EcommerceAppColor.gray,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          filterCategoryList[index].name,
                          style: AppTextStyle(context).bodyTextSmall.copyWith(
                              color: selectedCategoryId ==
                                      filterCategoryList[index]
                                  ? EcommerceAppColor.primary
                                  : EcommerceAppColor.gray),
                        ),
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }

  Widget _buildProductsWidget({required BuildContext context}) {
    return Flexible(
      flex: 5,
      child: ref.watch(productControllerProvider) && !loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ref.watch(productControllerProvider.notifier).products.isEmpty
              ? const ProductNotFoundWidget()
              : isList
                  ? _buildListProductsWidget(context: context)
                  : _buildGridProductsWidget(context: context),
    );
  }

  Widget _buildListProductsWidget({required BuildContext context}) {
    return AnimationLimiter(
      child: ref.watch(productControllerProvider) && !loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ref.watch(productControllerProvider.notifier).products.isEmpty
              ? Center(
                  child: Text(
                    S.of(context).productNotFount,
                    style: AppTextStyle(context).subTitle,
                  ),
                )
              : ListView.builder(
                  controller: scrollController,
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  itemCount: ref
                      .watch(productControllerProvider.notifier)
                      .products
                      .length,
                  itemBuilder: (context, index) {
                    final Product product = ref
                        .watch(productControllerProvider.notifier)
                        .products[index];
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(milliseconds: 500),
                      child: SlideAnimation(
                        verticalOffset: 50.0,
                        child: FadeInAnimation(
                          child: ListProductCard(
                            product: product,
                            onTap: () {
                              context.nav.pushNamed(
                                Routes.getProductDetailsRouteName(
                                    AppConstants.appServiceName),
                                arguments: product.id,
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  },
                ),
    );
  }

  Widget _buildGridProductsWidget({required BuildContext context}) {
    return AnimationLimiter(
      child: GridView.builder(
        controller: scrollController,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16.w,
          mainAxisSpacing: 16.h,
          childAspectRatio: 0.67,
        ),
        itemCount:
            ref.watch(productControllerProvider.notifier).products.length,
        itemBuilder: (context, index) {
          final Product product =
              ref.watch(productControllerProvider.notifier).products[index];
          return AnimationConfiguration.staggeredGrid(
            duration: const Duration(milliseconds: 375),
            position: index,
            columnCount: 2,
            child: ScaleAnimation(
              child: ProductCard(
                product: product,
                onTap: () {
                  context.nav.pushNamed(
                    Routes.getProductDetailsRouteName(
                        AppConstants.appServiceName),
                    arguments: product.id,
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeaderRow({required BuildContext context}) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 12.h,
      ).copyWith(top: 34.h, left: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(flex: 7, child: _buildLeftRow(context: context)),
          Flexible(flex: 3, child: _buildRightRow(context: context)),
        ],
      ),
    );
  }

  Widget _buildLeftRow({required BuildContext context}) {
    return Row(
      children: [
        Flexible(
          flex: 1,
          child: IconButton(
            onPressed: () {
              context.nav.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              size: 26.sp,
            ),
          ),
        ),
        Gap(16.w),
        Flexible(
          flex: 3,
          child: Text(
            widget.shopName,
            // widget.categories
            //     .firstWhere(
            //       (category) => category.id == selectedCategoryId,
            //     )
            //     .name,
            style: AppTextStyle(context).subTitle,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildRightRow({required BuildContext context}) {
    return Row(
      children: [
        CustomCartWidget(context: context),
        Gap(10.w),
        GestureDetector(
          onTap: () {
            showModalBottomSheet(
              isScrollControlled: true,
              backgroundColor: EcommerceAppColor.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12.r),
                  topRight: Radius.circular(12.r),
                ),
              ),
              context: context,
              builder: (context) {
                return FilterModalBottomSheet(
                  productFilterModel: ProductFilterModel(
                    page: 1,
                    perPage: 20,
                    categoryId: selectedCategoryId,
                    shopId: widget.shopId,
                  ),
                );
              },
            );
          },
          child: SvgPicture.asset(
            Assets.svg.filter,
            width: 46.sp,
          ),
        ),
      ],
    );
  }

  Widget _buildFilterRow({required BuildContext context}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w).copyWith(bottom: 8.h),
      child: Row(
        children: [
          Flexible(
            flex: 5,
            fit: FlexFit.tight,
            child: CustomSearchField(
              name: 'searchProduct',
              hintText: S.of(context).searchProduct,
              textInputType: TextInputType.text,
              controller: searchController,
              onChanged: (value) {
                page = 1;
                ref
                    .read(productControllerProvider.notifier)
                    .getCategoryWiseProducts(
                      productFilterModel: ProductFilterModel(
                        page: 1,
                        perPage: 20,
                        shopId: widget.shopId,
                        categoryId: selectedCategoryId,
                        search: value,
                      ),
                      isPagination: false,
                    );
              },
              widget: Container(
                margin: EdgeInsets.all(10.sp),
                child: SvgPicture.asset(Assets.svg.searchHome),
              ),
            ),
          ),
          Gap(20.w),
          GestureDetector(
            onTap: () {
              setState(() {
                isList = !isList;
              });
            },
            child: SvgPicture.asset(
              !isList ? Assets.svg.list : Assets.svg.grid,
              width: 26.w,
            ),
          ),
        ],
      ),
    );
  }

  int calculateCrossAxisCount(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth > 600) {
      return 3;
    } else {
      return 2;
    }
  }
}

class FilterCategory {
  final int? id;
  final String name;
  FilterCategory({
    this.id,
    required this.name,
  });
}
