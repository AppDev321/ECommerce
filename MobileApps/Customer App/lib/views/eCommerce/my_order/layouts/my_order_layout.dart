import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:gap/gap.dart';
import 'package:razin_shop/config/app_color.dart';
import 'package:razin_shop/config/app_text_style.dart';
import 'package:razin_shop/config/theme.dart';
import 'package:razin_shop/controllers/eCommerce/order/order_controller.dart';
import 'package:razin_shop/controllers/misc/misc_controller.dart';
import 'package:razin_shop/generated/l10n.dart';
import 'package:razin_shop/models/eCommerce/order/order_model.dart';

import '../components/my_order_card_widget.dart';

class MyOrderLayout extends ConsumerStatefulWidget {
  const MyOrderLayout({super.key});

  static TextEditingController nameController = TextEditingController();
  static TextEditingController phoneController = TextEditingController();
  static TextEditingController emailController = TextEditingController();

  @override
  ConsumerState<MyOrderLayout> createState() => _MyOrderLayoutState();

  static List<Map<String, dynamic>> getOrderStatus(BuildContext context) {
    List<Map<String, dynamic>> orderStatus = [
      {'key': 'all', 'value': S.of(context).all},
      {'key': 'Pending', 'value': S.of(context).pending},
      {'key': 'Confirm', 'value': S.of(context).confirm},
      {'key': 'Processing', 'value': S.of(context).processig},
      {'key': 'On the Way', 'value': S.of(context).onTheWay},
      {'key': 'Delivered', 'value': S.of(context).delivered},
      {'key': 'Cancelled', 'value': S.of(context).cancelled},
    ];

    return orderStatus;
  }
}

class _MyOrderLayoutState extends ConsumerState<MyOrderLayout> {
  ScrollController orderScrollController = ScrollController();

  int page = 1;
  int perPage = 20;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.refresh(selectedMyOrderIndexProvider.notifier).state;
      ref.read(orderControllerProvider.notifier).getOrders(
            orderStatus: null,
            page: page,
            perPage: perPage,
            isPagination: false,
          );
    });
    orderScrollController.addListener(() {
      orderScrollListener();
    });
    super.initState();
  }

  void orderScrollListener() {
    if (orderScrollController.offset >=
        orderScrollController.position.maxScrollExtent) {
      if (ref.watch(orderControllerProvider.notifier).orders.length <
              ref.watch(orderControllerProvider.notifier).totalOrder! &&
          ref.watch(orderControllerProvider) == false) {
        page++;
        ref.read(orderControllerProvider.notifier).getOrders(
              isPagination: true,
              page: page,
              perPage: perPage,
              orderStatus: MyOrderLayout.getOrderStatus(context)[
                  ref.read(selectedMyOrderIndexProvider.notifier).state]['key'],
            );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isDark =
        Theme.of(context).scaffoldBackgroundColor == EcommerceAppColor.black;
    return Scaffold(
      backgroundColor:
          isDark ? EcommerceAppColor.black : EcommerceAppColor.offWhite,
      appBar: AppBar(
        title: Text(S.of(context).myOrder),
        surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Gap(3.h),
          _buildTabBarWidget(context, ref),
          Gap(5.h),
          _buildOrderListWidget()
        ],
      ),
    );
  }

  Widget _buildOrderListWidget() {
    return Expanded(
      child: ref.watch(orderControllerProvider)
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : AnimationLimiter(
              child: ref.watch(orderControllerProvider.notifier).orders.isEmpty
                  ? Center(
                      child: Text(
                        'Order not found!',
                        style: AppTextStyle(context).subTitle,
                      ),
                    )
                  : ListView.builder(
                      itemCount: ref
                          .watch(orderControllerProvider.notifier)
                          .orders
                          .length,
                      itemBuilder: ((context, index) {
                        final OrderModel order = ref
                            .watch(orderControllerProvider.notifier)
                            .orders[index];
                        return AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(milliseconds: 375),
                          child: SlideAnimation(
                            verticalOffset: 50.h,
                            child: FadeInAnimation(
                              child: MyOrderCard(
                                order: order,
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
            ),
    );
  }

  Widget _buildTabBarWidget(BuildContext context, WidgetRef ref) {
    return Container(
      height: 50.h,
      width: double.infinity,
      color: Theme.of(context).scaffoldBackgroundColor,
      child: ListView.builder(
        padding: EdgeInsets.only(left: 12.w),
        scrollDirection: Axis.horizontal,
        itemCount: MyOrderLayout.getOrderStatus(context).length,
        shrinkWrap: true,
        itemBuilder: (context, index) => InkWell(
          onTap: () {
            if (ref.read(selectedMyOrderIndexProvider.notifier).state !=
                index) {
              ref.read(selectedMyOrderIndexProvider.notifier).state = index;
              page = 1;
              ref.read(orderControllerProvider.notifier).getOrders(
                    orderStatus: index != 0
                        ? MyOrderLayout.getOrderStatus(context)[index]['key']
                        : null,
                    page: page,
                    perPage: perPage,
                    isPagination: false,
                  );
            }
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 6.w),
            padding: EdgeInsets.symmetric(
              horizontal: 16.w,
            ),
            decoration: BoxDecoration(
              color: ref.watch(selectedMyOrderIndexProvider) == index
                  ? colors(context).primaryColor
                  : EcommerceAppColor.offWhite,
              borderRadius: BorderRadius.circular(30.r),
            ),
            child: Center(
              child: Text(
                MyOrderLayout.getOrderStatus(context)[index]['value'],
                style: AppTextStyle(context).bodyTextSmall.copyWith(
                      color: ref.watch(selectedMyOrderIndexProvider) == index
                          ? EcommerceAppColor.white
                          : null,
                    ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

enum OrderStatus {
  all,
  pending,
  confirm,
  processing,
  onTheWay,
  delivered,
  canceled,
}
