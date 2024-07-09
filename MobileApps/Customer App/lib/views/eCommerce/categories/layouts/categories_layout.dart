import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:razin_shop/config/app_color.dart';
import 'package:razin_shop/config/app_constants.dart';
import 'package:razin_shop/controllers/eCommerce/category/category_controller.dart';
import 'package:razin_shop/routes.dart';
import 'package:razin_shop/utils/context_less_navigation.dart';
import 'package:razin_shop/views/eCommerce/home/components/category_card.dart';

class EcommerceCategoriesLayout extends StatelessWidget {
  const EcommerceCategoriesLayout({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int columnCount = 4;
    bool isDark =
        Theme.of(context).scaffoldBackgroundColor == EcommerceAppColor.black;
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Categories'),
        toolbarHeight: 80.h,
      ),
      backgroundColor:
          isDark ? EcommerceAppColor.black : EcommerceAppColor.offWhite,
      body: Consumer(
        builder: (context, ref, _) {
          final asyncValue = ref.watch(categoryControllerProvider);
          return asyncValue.when(
            data: (categoryList) => AnimationLimiter(
              child: RefreshIndicator(
                onRefresh: () async {
                  ref.refresh(categoryControllerProvider).value;
                },
                child: GridView.builder(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 15.h,
                    crossAxisSpacing: 0.w,
                    childAspectRatio: 90.w / 105.w,
                    crossAxisCount: columnCount,
                  ),
                  itemCount: categoryList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return AnimationConfiguration.staggeredGrid(
                      position: index,
                      duration: const Duration(milliseconds: 375),
                      columnCount: columnCount,
                      child: ScaleAnimation(
                        child: FadeInAnimation(
                          child: CategoryCard(
                            category: categoryList[index],
                            onTap: () {
                              context.nav.pushNamed(
                                Routes.getProductsViewRouteName(
                                  AppConstants.appServiceName,
                                ),
                                arguments: [
                                  categoryList[index].id,
                                  categoryList[index].name,
                                  null
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            error: (error, stackTrace) => Center(
              child: Text(
                error.toString(),
              ),
            ),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }
}
