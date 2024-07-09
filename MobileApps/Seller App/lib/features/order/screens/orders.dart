import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:razin_commerce_seller_flutter/config/app_color.dart';
import 'package:razin_commerce_seller_flutter/config/app_text_style.dart';
import 'package:razin_commerce_seller_flutter/config/routes.dart';
import 'package:razin_commerce_seller_flutter/config/theme.dart';
import 'package:razin_commerce_seller_flutter/features/common/screens/date_picker_screen.dart';
import 'package:razin_commerce_seller_flutter/features/order/models/order_filter_model.dart';
import 'package:razin_commerce_seller_flutter/features/order/providers/order_provider.dart';
import 'package:razin_commerce_seller_flutter/features/order/widgets/order_card.dart';
import 'package:razin_commerce_seller_flutter/features/order/widgets/order_details_bottom_sheet.dart';
import 'package:razin_commerce_seller_flutter/features/order/widgets/order_filter_card.dart';
import 'package:razin_commerce_seller_flutter/features/order/widgets/pending_order_card.dart';
import 'package:razin_commerce_seller_flutter/gen/assets.gen.dart';
import 'package:razin_commerce_seller_flutter/utils/global_function.dart';

class Orders extends ConsumerStatefulWidget {
  const Orders({super.key});

  @override
  ConsumerState<Orders> createState() => _OrdersState();
}

class _OrdersState extends ConsumerState<Orders> {
  final ScrollController pendingListController = ScrollController();
  final ScrollController listController = ScrollController();

  int page = 1;
  int perPage = 20;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
        (timeStamp) => ref.read(orderServiceProvider.notifier).getOrders(
              filter:
                  OrderFilterModel(page: page, perPage: perPage, status: 'all'),
            ));
    pendingListController.addListener(pendingOrderScrollListener);
    listController.addListener(orderScrollListener);
    super.initState();
  }

  void pendingOrderScrollListener() {
    final notifier = ref.read(orderServiceProvider.notifier);
    final orders = notifier.orders;
    final totalOrders = notifier.totalOrders;

    if (pendingListController.offset >=
            pendingListController.position.maxScrollExtent &&
        orders.length > totalOrders) {
      page++;
      notifier.getOrders(
        filter: OrderFilterModel(
          page: page,
          perPage: perPage,
          status: ref.read(selectedOrderStatusProvider),
        ),
      );
    }
  }

  void orderScrollListener() {
    final notifier = ref.read(orderServiceProvider.notifier);
    final orders = notifier.orders;
    final totalOrders = notifier.totalOrders;

    if (listController.offset >= listController.position.maxScrollExtent &&
        orders.length < totalOrders) {
      page++;
      notifier.getOrders(
        filter: OrderFilterModel(
          page: page,
          perPage: perPage,
          status: ref.read(selectedOrderStatusProvider),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return Consumer(builder: (context, ref, _) {
      return Column(
        children: [
          buildOrderStatusListWidget(),
          buildListWidget(),
          Visibility(
            visible: ref.watch(orderServiceProvider) && page > 1,
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20.h),
                child: const CircularProgressIndicator(),
              ),
            ),
          )
        ],
      );
    });
  }

  PreferredSize buildAppBar() {
    return PreferredSize(
      preferredSize: Size(double.infinity, 60.h),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
        ),
        color: colors(GlobalFunction.navigatorKey.currentContext).light,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Orders',
                  style: AppTextStyle.text16B700.copyWith(fontSize: 18.sp),
                ),
                Gap(4.h),
                Text(
                  'Today - 10 May,2024',
                  style: AppTextStyle.text14B400
                      .copyWith(fontSize: 12.sp, color: AppStaticColor.gray),
                )
              ],
            ),
            Row(
              children: [
                SvgPicture.asset(Assets.svg.searchCircale),
                Gap(16.w),
                GestureDetector(
                  onTap: () {
                    showDialog(
                        context: GlobalFunction.navigatorKey.currentContext!,
                        builder: (_) => const CustomDatePicker());
                  },
                  child: SvgPicture.asset(Assets.svg.calenderCircale),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildOrderStatusListWidget() {
    return Consumer(
      builder: (context, ref, _) {
        return Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                  color: AppStaticColor.gray.withOpacity(0.5), width: 1),
            ),
          ),
          padding: EdgeInsets.symmetric(vertical: 12.h),
          height: 62.h,
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            itemCount:
                ref.watch(orderServiceProvider.notifier).orderStatusList.length,
            shrinkWrap: false,
            scrollDirection: Axis.horizontal,
            itemBuilder: ((context, index) {
              final statusModel = ref
                  .watch(orderServiceProvider.notifier)
                  .orderStatusList[index];
              return Padding(
                padding: EdgeInsets.only(right: 6.w),
                child: OrderFilterCard(
                  isActive: ref.watch(selectedOrderStatusProvider) ==
                      statusModel.status,
                  statusModel: statusModel,
                  callback: () {
                    final selectedStatusNotifier =
                        ref.read(selectedOrderStatusProvider.notifier);
                    if (selectedStatusNotifier.state != statusModel.status) {
                      selectedStatusNotifier.state = statusModel.status;
                      page = 1;
                      ref.read(orderServiceProvider.notifier).getOrders(
                            filter: OrderFilterModel(
                              page: page,
                              perPage: perPage,
                              status: statusModel.status,
                            ),
                          );
                    }
                  },
                ),
              );
            }),
          ),
        );
      },
    );
  }

  Widget buildListWidget() {
    return Container(
      child: ref.watch(orderServiceProvider) && page == 1
          ? const Expanded(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : ref.watch(selectedOrderStatusProvider) == 'pending'
              ? buildPendingOrderList()
              : buildOrderList(),
    );
  }

  Widget buildPendingOrderList() {
    return Expanded(
      child: ListView.builder(
        controller: pendingListController,
        padding: EdgeInsets.symmetric(horizontal: 16.w).copyWith(top: 12.h),
        shrinkWrap: true,
        itemCount: ref.watch(orderServiceProvider.notifier).orders.length,
        itemBuilder: ((context, index) {
          final order = ref.watch(orderServiceProvider.notifier).orders[index];
          return Padding(
            padding: EdgeInsets.only(bottom: 8.h),
            child: PendingOrderCard(
              order: order,
              callback: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (_) => OrderDetailsBottomSheet(order: order),
                );
              },
            ),
          );
        }),
      ),
    );
  }

  Widget buildOrderList() {
    return Expanded(
      child: ListView.builder(
        controller: listController,
        padding: EdgeInsets.symmetric(horizontal: 16.w).copyWith(top: 12.h),
        shrinkWrap: true,
        itemCount: ref.watch(orderServiceProvider.notifier).orders.length,
        itemBuilder: ((context, index) {
          final order = ref.watch(orderServiceProvider.notifier).orders[index];
          return Padding(
            padding: EdgeInsets.only(bottom: 8.h),
            child: OrderCard(
              order: order,
              callback: () {
                GoRouter.of(context).push(Routes.orderDetails, extra: order.id);
              },
            ),
          );
        }),
      ),
    );
  }
}

final selectedOrderStatusProvider = StateProvider<String>((ref) => 'all');
