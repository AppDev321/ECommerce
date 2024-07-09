import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:razinshop_rider/config/app_color.dart';
import 'package:razinshop_rider/config/app_text.dart';
import 'package:razinshop_rider/controllers/misc/providers.dart';
import 'package:razinshop_rider/controllers/order_controller/order_controller.dart';
import 'package:razinshop_rider/gen/assets.gen.dart';
import 'package:razinshop_rider/generated/l10n.dart';
import 'package:razinshop_rider/routers.dart';
import 'package:razinshop_rider/utils/context_less_navigate.dart';
import 'package:razinshop_rider/utils/global_function.dart';
import 'package:razinshop_rider/views/home/components/date_picker_layout.dart';

class OrderHistory extends ConsumerStatefulWidget {
  OrderHistory({super.key});

  @override
  ConsumerState<OrderHistory> createState() => _OrderHistoryState();
}

class _OrderHistoryState extends ConsumerState<OrderHistory> {
  late ScrollController _scrollController;
  int pageNo = 1;
  int perPage = 10;
  int total = 0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (total > pageNo * perPage) {
          pageNo++;
          ref
              .read(orderHistoryProvider.notifier)
              .filterOrderHistory(TodoListFilter.all,
                  page: pageNo, perPage: perPage)
              .then((value) {
            setState(() {});
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.greyBackgroundColor,
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 48.r, bottom: 10.r),
            decoration: const BoxDecoration(color: Colors.white),
            child: const _MyAppBar(),
          ),
          Container(
            decoration: BoxDecoration(color: Color(0xFFF1F1F5)),
            child: Column(children: [
              // Header
              Gap(20.h),
              // Tab Section
              ref.watch(selectedDate) != null
                  ? Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 16.r, right: 16.r),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              DateFormat('yyyy-MM-dd')
                                  .format(ref.watch(selectedDate)!),
                              style: AppTextStyle.normalBody
                                  .copyWith(fontSize: 15.sp),
                            ),
                            const Spacer(),
                            IconButton(
                              onPressed: () {
                                ref.read(selectedDate.notifier).state = null;
                                ref
                                    .read(orderHistoryFilterProvider.notifier)
                                    .state = TodoListFilter.all;
                                ref.invalidate(orderHistoryProvider);
                              },
                              icon: const Icon(
                                Icons.close,
                                size: 20,
                                color: Colors.red,
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  : const _TabSection(),
              Gap(15.h),
            ]),
          ),
          Gap(10.h),
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: ref.watch(orderHistoryProvider).when(
                    skipLoadingOnRefresh: false,
                    // skipLoadingOnReload: false,
                    data: (orderList) {
                      total = orderList.total ?? 0;
                      return orderList.orders.isEmpty
                          ? const Center(
                              child: Text("No Order Found"),
                            )
                          : Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              child: ListView.builder(
                                padding: EdgeInsets.only(top: 5.h),
                                itemCount: orderList.orders.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return _OrderHistoryCard(
                                    onTap: () {
                                      context.nav.pushNamed(
                                        Routes.orderDetails,
                                        arguments: orderList.orders[index].id,
                                      );
                                    },
                                    orderId: orderList.orders[index].orderCode
                                        .toString(),
                                    customerName:
                                        orderList.orders[index].user?.name ??
                                            '',
                                    customerAddress: orderList.orders[index]
                                            .user?.address?.addressLine ??
                                        '',
                                    shopAddress:
                                        orderList.orders[index].shop?.address ??
                                            '',
                                    status:
                                        orderList.orders[index].orderStatus ??
                                            '',
                                  );
                                },
                              ),
                            );
                    },
                    error: ((error, stackTrace) {
                      return Center(
                        child: Text(
                          error.toString(),
                          style: AppTextStyle.normalBody.copyWith(
                            color: AppColor.black,
                          ),
                        ),
                      );
                    }),
                    loading: () => const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

class _OrderHistoryCard extends StatelessWidget {
  const _OrderHistoryCard({
    required this.orderId,
    required this.customerName,
    required this.customerAddress,
    required this.shopAddress,
    required this.status,
    this.onTap,
  });
  final String orderId;
  final String customerName;
  final String customerAddress;
  final String shopAddress;
  final String status;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 12.r, vertical: 12.r).r,
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8).r,
              ),
              shadows: [
                BoxShadow(
                  color: Color(0x14000000),
                  blurRadius: 2,
                  offset: Offset(0, 1),
                  spreadRadius: 0,
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IntrinsicHeight(
                  child: Row(
                    children: [
                      Text(
                        orderId,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Gap(10.w),
                      VerticalDivider(
                        color: AppColor.greyColor,
                        thickness: 1.5,
                        width: 2,
                        indent: 6,
                        endIndent: 6,
                      ),
                      Gap(10.w),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Text(
                                customerName,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8.r, vertical: 4.r),
                              decoration: ShapeDecoration(
                                color: GlobalFunction.orderStatusText(
                                        status, context)
                                    .bgColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8).r,
                                ),
                              ),
                              child: Text(
                                GlobalFunction.orderStatusText(status, context)
                                    .text,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Gap(10.h),
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            Assets.svgs.box,
                            width: 14.sp,
                            height: 14.sp,
                          ),
                          Gap(6.w),
                          Expanded(
                            child: Text(
                              shopAddress,
                              overflow: TextOverflow.ellipsis,
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 5.r),
                        constraints: BoxConstraints(
                          maxHeight: 16.h,
                        ),
                        child: SvgPicture.asset(
                          Assets.svgs.line,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            Assets.svgs.pin,
                            width: 14.sp,
                            height: 14.sp,
                          ),
                          Gap(6.w),
                          Expanded(
                            child: Text(
                              customerAddress,
                              overflow: TextOverflow.ellipsis,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        Gap(10.r),
      ],
    );
  }
}

// ignore: must_be_immutable
class _TabSection extends ConsumerWidget {
  const _TabSection();

  String localize(BuildContext context, String key, String value) {
    return switch (key) {
      "All" => "${S.of(context).all} ($value)",
      "Pending" => "${S.of(context).pending} ($value)",
      "Delivered" => "${S.of(context).delivered} ($value)",
      _ => key,
    };
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedOrderHistory = ref.watch(orderHistoryFilterProvider);
    return Container(
      padding: EdgeInsets.only(left: 16.r),
      width: 1.sw,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(
            TodoListFilter.values.length,
            (index) {
              final value = TodoListFilter.values[index].name;
              final title = value[0].toUpperCase() + value.substring(1);
              return Row(
                children: [
                  InkWell(
                    onTap: () {
                      ref
                          .read(orderHistoryFilterProvider.notifier)
                          .update((state) => TodoListFilter.values[index]);
                    },
                    child: Container(
                      padding: EdgeInsets.all(10.r),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24.r),
                        border: Border.all(
                            color: selectedOrderHistory ==
                                    TodoListFilter.values[index]
                                ? AppColor.primaryColor
                                : AppColor.greyColor),
                      ),
                      child: Text(
                        localize(
                          context,
                          title,
                          title == "All"
                              ? ref.watch(orderHistoryProvider).maybeWhen(
                                    orElse: () => '00',
                                    data: (value) => value.allOrder.toString(),
                                  )
                              : title == "Pending"
                                  ? ref.watch(orderHistoryProvider).maybeWhen(
                                        orElse: () => '00',
                                        data: (value) =>
                                            value.toDeliver.toString(),
                                      )
                                  : ref.watch(orderHistoryProvider).maybeWhen(
                                        orElse: () => '00',
                                        data: (value) =>
                                            value.delivered.toString(),
                                      ),
                        ),
                        style: AppTextStyle.title.copyWith(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: selectedOrderHistory ==
                                  TodoListFilter.values[index]
                              ? AppColor.primaryColor
                              : AppColor.greyColor,
                        ),
                      ),
                    ),
                  ),
                  Gap(10.w),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _MyAppBar extends ConsumerWidget {
  const _MyAppBar();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(isSearchActiveProvider)
        ? const _SearchAppBar()
        : const _NormalAppBar();
  }
}

class _SearchAppBar extends ConsumerWidget {
  const _SearchAppBar();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              focusNode: FocusNode(),
              decoration: InputDecoration(
                hintText: S.of(context).searchOrder,
                isDense: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: (value) {
                ref
                    .watch(orderHistoryProvider.notifier)
                    .searchOrderHistory(value);
              },
            ),
          ),
          Gap(10.w),
          InkWell(
            onTap: () {
              ref.read(isSearchActiveProvider.notifier).state = false;
              ref.read(orderHistoryFilterProvider.notifier).state =
                  TodoListFilter.all;
              ref.invalidate(orderHistoryProvider);
            },
            child: Container(
              padding: EdgeInsets.all(8.r),
              decoration: BoxDecoration(
                // color: AppColor.gray600.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.close),
            ),
          ),
        ],
      ),
    );
  }
}

class _NormalAppBar extends ConsumerWidget {
  const _NormalAppBar();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  S.of(context).orderHistory,
                  style: AppTextStyle.title,
                ),
                Text(
                  '${S.of(context).today} - ${DateFormat("d MMMM yyyy").format(DateTime.now())}',
                  style: AppTextStyle.largeBody.copyWith(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              ref.read(isSearchActiveProvider.notifier).state = true;
              ref.read(orderHistoryFilterProvider.notifier).state =
                  TodoListFilter.all;
            },
            child: Container(
              padding: EdgeInsets.all(8.r),
              decoration: BoxDecoration(
                color: AppColor.greyBackgroundColor,
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(Assets.svgs.searchNormal),
            ),
          ),
          Gap(8.w),
          InkWell(
            onTap: () {
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) {
                    return Dialog(
                      clipBehavior: Clip.antiAlias,
                      insetPadding: EdgeInsets.symmetric(
                          horizontal: 20.r, vertical: 30.r),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      child: const DatePickerLayout(),
                    );
                  });
            },
            child: Container(
              padding: EdgeInsets.all(8.r),
              decoration: BoxDecoration(
                color: AppColor.greyBackgroundColor,
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(Assets.svgs.calendarFilter),
            ),
          ),
        ],
      ),
    );
  }
}
