import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:razin_shop/config/app_constants.dart';
import 'package:razin_shop/config/app_text_style.dart';
import 'package:razin_shop/controllers/eCommerce/product/product_controller.dart';
import 'package:razin_shop/generated/l10n.dart';
import 'package:razin_shop/routes.dart';
import 'package:razin_shop/utils/context_less_navigation.dart';
import 'package:razin_shop/utils/global_function.dart';
import 'package:razin_shop/views/eCommerce/products/components/list_product_card.dart';

class FavouritesProductsLayout extends ConsumerStatefulWidget {
  const FavouritesProductsLayout({super.key});

  static late ScrollController scrollController;

  @override
  ConsumerState<FavouritesProductsLayout> createState() =>
      _FavouritesProductsLayoutState();
}

class _FavouritesProductsLayoutState
    extends ConsumerState<FavouritesProductsLayout> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      FavouritesProductsLayout.scrollController = ScrollController();
      ref.read(productControllerProvider.notifier).getFavoriteProducts();
    });
    super.initState();
  }

  @override
  void dispose() {
    FavouritesProductsLayout.scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalFunction.getBackgroundColor(context: context),
      appBar: AppBar(
        title: Text(S.of(context).favorites),
        surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: _buildListProductsWidget(context: context),
    );
  }

  Widget _buildListProductsWidget({required BuildContext context}) {
    return AnimationLimiter(
      child: ref.watch(productControllerProvider)
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ref
                  .watch(productControllerProvider.notifier)
                  .favoriteProducts
                  .isEmpty
              ? Center(
                  child: Text(
                    'Favorite products not found!',
                    style: AppTextStyle(context).subTitle,
                  ),
                )
              : ListView.builder(
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  controller: FavouritesProductsLayout.scrollController,
                  itemCount: ref
                      .watch(productControllerProvider.notifier)
                      .favoriteProducts
                      .length,
                  itemBuilder: (context, index) {
                    final product = ref
                        .watch(productControllerProvider.notifier)
                        .favoriteProducts[index];
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(milliseconds: 500),
                      child: SlideAnimation(
                        verticalOffset: 50.0,
                        child: FadeInAnimation(
                          child: Stack(
                            children: [
                              ListProductCard(
                                product: product,
                                onTap: () {
                                  context.nav.pushNamed(
                                      Routes.getProductDetailsRouteName(
                                        AppConstants.appServiceName,
                                      ),
                                      arguments: product.id);
                                },
                                onTapRemove: () {
                                  debugPrint(product.id.toString());
                                  ref
                                      .read(productControllerProvider.notifier)
                                      .favoriteProducts
                                      .removeWhere(
                                        (element) => element.id == product.id,
                                      );
                                  ref
                                      .read(productControllerProvider.notifier)
                                      .favoriteProductAddRemove(
                                          productId: product.id);
                                  setState(() {});
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
