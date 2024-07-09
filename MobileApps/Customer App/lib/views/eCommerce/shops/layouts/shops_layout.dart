// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:razin_shop/config/app_color.dart';
import 'package:razin_shop/controllers/eCommerce/shop/shop_controller.dart';
import 'package:razin_shop/models/eCommerce/shop/shop.dart';
import 'package:razin_shop/views/eCommerce/shops/components/shop_card.dart';

class EcommerceShopsLayout extends ConsumerStatefulWidget {
  const EcommerceShopsLayout({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<EcommerceShopsLayout> createState() =>
      _EcommerceShopsLayoutState();
}

class _EcommerceShopsLayoutState extends ConsumerState<EcommerceShopsLayout> {
  final ScrollController scrollController = ScrollController();

  int page = 1;
  final int perPage = 20;
  bool scrollLoading = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (ref.read(shopControllerProvider.notifier).shops.isEmpty) {
        ref.read(shopControllerProvider.notifier).getShops(
              page: page,
              perPage: perPage,
              isPagination: false,
            );
      }
    });
    scrollController.addListener(() {
      scrolListener();
    });

    super.initState();
  }

  void scrolListener() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent) {
      if (ref.watch(shopControllerProvider.notifier).shops.length <
              ref.watch(shopControllerProvider.notifier).total!.toInt() &&
          !ref.watch(shopControllerProvider)) {
        scrollLoading = true;
        page++;
        ref.read(shopControllerProvider.notifier).getShops(
              page: page,
              perPage: perPage,
              isPagination: true,
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
    bool isDark =
        Theme.of(context).scaffoldBackgroundColor == EcommerceAppColor.black;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shops'),
      ),
      backgroundColor:
          isDark ? EcommerceAppColor.black : EcommerceAppColor.offWhite,
      body: AnimationLimiter(
        child: ref.watch(shopControllerProvider) && !scrollLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : RefreshIndicator(
                onRefresh: () async {
                  page = 1;
                  ref.read(shopControllerProvider.notifier).getShops(
                        page: page,
                        perPage: perPage,
                        isPagination: false,
                      );
                },
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  itemCount:
                      ref.watch(shopControllerProvider.notifier).shops.length,
                  itemBuilder: ((context, index) {
                    final Shop shop =
                        ref.watch(shopControllerProvider.notifier).shops[index];
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(milliseconds: 375),
                      child: SlideAnimation(
                        child: FadeInAnimation(
                          child: ShopCard(
                            shop: shop,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
      ),
    );
  }
}

final List<Map<String, dynamic>> shopList = [
  {
    'shopName': 'DhakaMart',
    'shopLogo':
        'https://thumbs.dreamstime.com/b/lets-shopping-logo-design-template-cart-icon-designs-134743663.jpg',
    'items': 4100,
    'categories': 15
  },
  {
    'shopName': 'BanglaBazaar Online',
    'shopLogo':
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTe1hHSIMq31A_wD2lWOOraNLLS2pvgvZh4a087BMWHUj0bj2-iXnPVpM242A&s',
    'items': 2500,
    'categories': 25
  },
  {
    'shopName': 'ChittagongCart',
    'shopLogo':
        'https://cdn5.vectorstock.com/i/1000x1000/73/14/letter-s-on-shop-logo-design-vector-35087314.jpg',
    'items': 2100,
    'categories': 13
  },
  {
    'shopName': 'DeshiMarket',
    'shopLogo':
        'https://c8.alamy.com/comp/2C94RDW/shopping-logo-design-vector-fast-symbol-and-hand-thumb-on-shopping-bag-abstract-concept-for-online-storeeps-10-2C94RDW.jpg',
    'items': 3100,
    'categories': 18
  },
];
