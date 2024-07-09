import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:razin_shop/controllers/eCommerce/cart/cart_controller.dart';
import 'package:razin_shop/controllers/misc/misc_controller.dart';
import 'package:razin_shop/gen/assets.gen.dart';
import 'package:razin_shop/generated/l10n.dart';
import 'package:razin_shop/services/common/hive_service_provider.dart';
import 'package:razin_shop/views/eCommerce/dashboard/components/app_bottom_navbar.dart';
import 'package:razin_shop/views/eCommerce/favourites/favourites_products_view.dart';
import 'package:razin_shop/views/eCommerce/home/home_view.dart';
import 'package:razin_shop/views/eCommerce/more/more_view.dart';
import 'package:razin_shop/views/eCommerce/my_cart/my_cart_view.dart';

class EcommerceDashboardLayout extends ConsumerStatefulWidget {
  const EcommerceDashboardLayout({super.key});

  @override
  ConsumerState<EcommerceDashboardLayout> createState() =>
      _EcommerceDashboardLayoutState();
}

class _EcommerceDashboardLayoutState
    extends ConsumerState<EcommerceDashboardLayout> {
  @override
  void initState() {
    _init();
    super.initState();
  }

  _init() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(hiveServiceProvider).getAuthToken().then((token) {
        if (token != null) {
          ref.read(cartController.notifier).getAllCarts();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final pageController = ref.watch(bottomTabControllerProvider);
    print(ref.read(selectedTabIndexProvider));
    return PopScope(
      canPop: true,
      onPopInvoked: (onPop) {
        if (ref.read(selectedTabIndexProvider) != 0) {
          ref.read(selectedTabIndexProvider.notifier).state = 0;
          pageController.jumpToPage(0);
        } else {
          SystemNavigator.pop();
        }
      },
      child: Scaffold(
        bottomNavigationBar: AppBottomNavbar(
            bottomItem: getBottomItems(context: context),
            onSelect: (index) {
              if (index != null) {
                pageController.jumpToPage(index);
              }
            }),
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: pageController,
          onPageChanged: (index) {
            ref.read(selectedTabIndexProvider.notifier).state = index;
          },
          children: const [
            EcommerceHomeView(),
            EcommerceMyCartView(
              isRoot: true,
            ),
            FavouritesProductsView(),
            EcommerceMoreView()
          ],
        ),
      ),
    );
  }
}

List<BottomItem> getBottomItems({required BuildContext context}) {
  return [
    BottomItem(
      icon: Assets.svg.inactiveHome,
      activeIcon: Assets.svg.activeHome,
      name: S.of(context).home,
    ),
    BottomItem(
      icon: Assets.svg.inactiveBag,
      activeIcon: Assets.svg.activeBag,
      name: S.of(context).myCart,
    ),
    BottomItem(
      icon: Assets.svg.inactiveFavorite,
      activeIcon: Assets.svg.activeFavorite,
      name: S.of(context).favorites,
    ),
    BottomItem(
      icon: Assets.svg.inactiveMore,
      activeIcon: Assets.svg.activeMore,
      name: S.of(context).more,
    ),
  ];
}

class BottomItem {
  final String icon;
  final String activeIcon;
  final String name;
  BottomItem({
    required this.icon,
    required this.activeIcon,
    required this.name,
  });
}
