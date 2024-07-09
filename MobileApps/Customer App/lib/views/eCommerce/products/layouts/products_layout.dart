import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
import 'package:razin_shop/models/eCommerce/common/product_filter_model.dart';
import 'package:razin_shop/models/eCommerce/product/product.dart';
import 'package:razin_shop/routes.dart';
import 'package:razin_shop/utils/context_less_navigation.dart';
import 'package:razin_shop/views/eCommerce/home/components/product_card.dart';
import 'package:razin_shop/views/eCommerce/products/components/filter_modal_bottom_sheet.dart';
import 'package:razin_shop/views/eCommerce/products/components/list_product_card.dart';

class EcommerceProductsLayout extends ConsumerStatefulWidget {
  final int? categoryId;
  final String? sortType;
  final String categoryName;
  const EcommerceProductsLayout({
    Key? key,
    required this.categoryId,
    required this.categoryName,
    required this.sortType,
  }) : super(key: key);

  @override
  ConsumerState<EcommerceProductsLayout> createState() =>
      _EcommerceProductsLayoutState();
}

class _EcommerceProductsLayoutState
    extends ConsumerState<EcommerceProductsLayout> {
  ScrollController scrollController = ScrollController();
  TextEditingController searchController = TextEditingController();
  bool isHeaderVisible = true;
  bool isList = true;
  int page = 1;
  int perPage = 20;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.watch(productControllerProvider.notifier).products.clear();
      ref.read(productControllerProvider.notifier).getCategoryWiseProducts(
            productFilterModel: ProductFilterModel(
                categoryId: widget.categoryId,
                page: page,
                perPage: perPage,
                sortType: widget.sortType),
            isPagination: false,
          );
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
          setState(() {
            isHeaderVisible = true;
          });
          // if (scrollController.position.pixels ==
          //     scrollController.position.minScrollExtent) {
          //   setState(() {
          //     isHeaderVisible = true;
          //   });
          // }
        }
      }
    });
    scrollController.addListener(() {
      productScrollListener();
    });
    super.initState();
  }

  void productScrollListener() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent) {
      if (ref.watch(productControllerProvider.notifier).products.length <
              ref.watch(productControllerProvider.notifier).total! &&
          ref.watch(productControllerProvider) == false) {
        page++;
        ref.read(productControllerProvider.notifier).getCategoryWiseProducts(
              isPagination: true,
              productFilterModel: ProductFilterModel(
                  page: page, perPage: perPage, categoryId: widget.categoryId),
            );
      }
    }
  }

  @override
  void dispose() {
    searchController.dispose();
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
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      color:
          Theme.of(context).scaffoldBackgroundColor == EcommerceAppColor.black
              ? colors(context).dark
              : colors(context).light,
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 12.h,
      ).copyWith(top: !isHeaderVisible ? 35.h : 50.h),
      child: Column(
        children: [
          if (isHeaderVisible) ...[
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              child: _buildHeaderRow(context: context),
            ),
            Gap(20.h),
          ],
          _buildFilterRow(context: context),
        ],
      ),
    );
  }

  Widget _buildProductsWidget({required BuildContext context}) {
    return Flexible(
      flex: 5,
      child: ref.watch(productControllerProvider) &&
              ref.watch(productControllerProvider.notifier).products.isEmpty
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

  Widget _buildGridProductsWidget({required BuildContext context}) {
    return AnimationLimiter(
      child: GridView.builder(
        controller: scrollController,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16.w,
          mainAxisSpacing: 16.h,
          childAspectRatio: 0.66,
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

  Widget _buildListProductsWidget({required BuildContext context}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      child: AnimationLimiter(
        child: ListView.builder(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          controller: scrollController,
          itemCount:
              ref.watch(productControllerProvider.notifier).products.length,
          itemBuilder: (context, index) {
            final Product product =
                ref.watch(productControllerProvider.notifier).products[index];
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
      ),
    );
  }

  Widget _buildHeaderRow({required BuildContext context}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildLeftRow(context: context),
        _buildRightRow(context: context),
      ],
    );
  }

  Widget _buildLeftRow({required BuildContext context}) {
    return Expanded(
      child: Row(
        children: [
          IconButton(
            visualDensity: VisualDensity.compact,
            onPressed: () {
              context.nav.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              size: 26.sp,
            ),
          ),
          Gap(16.w),
          Expanded(
            child: Text(
              widget.categoryName,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyle(context).subTitle,
            ),
          ),
          Gap(4.w),
        ],
      ),
    );
  }

  Widget _buildRightRow({required BuildContext context}) {
    return Row(
      children: [
        CustomCartWidget(context: context),
        Gap(16.w),
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
                    categoryId: widget.categoryId,
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
    return Row(
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
                      categoryId: widget.categoryId,
                      search: value,
                      page: page,
                      perPage: perPage,
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
            isList ? Assets.svg.grid : Assets.svg.list,
            width: 26.w,
          ),
        ),
      ],
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
