import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:razin_commerce_seller_flutter/config/app_color.dart';
import 'package:razin_commerce_seller_flutter/config/app_text_style.dart';
import 'package:razin_commerce_seller_flutter/config/theme.dart';
import 'package:razin_commerce_seller_flutter/features/dashboard/models/dashboard_data_model.dart';
import 'package:razin_commerce_seller_flutter/features/dashboard/providers/dashboard_provider.dart';
import 'package:razin_commerce_seller_flutter/features/dashboard/widgets/line_chart.dart';
import 'package:razin_commerce_seller_flutter/features/dashboard/widgets/order_over_view_card.dart';
import 'package:razin_commerce_seller_flutter/gen/assets.gen.dart';
import 'package:razin_commerce_seller_flutter/utils/global_function.dart';

class Dashboard extends ConsumerWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: ref.watch(dashboardServiceProvider('this_year')).when(
            data: (dashboardData) =>
                _buildBody(dashboardDataModel: dashboardData),
            error: (error, stackTrace) => Text(error.toString()),
            loading: () => const Center(child: CircularProgressIndicator()),
          ),
    );
  }

  Widget _buildBody({required DashboardDataModel dashboardDataModel}) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildOrderOverViewWidget(dashboardDataModel: dashboardDataModel),
          Gap(12.h),
          _buildProfitWidget(dashboardDataModel: dashboardDataModel),
          Gap(28.h),
          _buildSalesStatistic(dashboardDataModel: dashboardDataModel),
        ],
      ),
    );
  }

  Widget _buildOrderOverViewWidget(
      {required DashboardDataModel dashboardDataModel}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: const Alignment(-0.99, -0.12),
          end: const Alignment(0.99, 0.12),
          colors: [
            const Color(0xFFB822FF),
            colors(GlobalFunction.context).primaryColor!,
          ],
        ),
      ),
      child: Container(
        padding: EdgeInsets.all(16.dm),
        decoration: ShapeDecoration(
          color: AppStaticColor.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'ORDER OVERVIEW',
                  style: AppTextStyle.text12B700,
                ),
                SvgPicture.asset(Assets.svg.arrowIcon)
              ],
            ),
            Gap(8.h),
            Row(
              children: [
                Flexible(
                  flex: 1,
                  child: OrderOverViewCard(
                    count: dashboardDataModel.pendingOrder.toString(),
                    status: 'Pending Orders',
                    icon: Assets.svg.pendingOrder,
                  ),
                ),
                Gap(8.w),
                Flexible(
                  flex: 1,
                  child: OrderOverViewCard(
                    count: dashboardDataModel.todayOrder.toString(),
                    status: "Today's Order",
                    icon: Assets.svg.todaysOrders,
                  ),
                )
              ],
            ),
            Gap(8.h),
            Row(
              children: [
                Flexible(
                  flex: 1,
                  child: OrderOverViewCard(
                    count: dashboardDataModel.toPickupOrder.toString(),
                    status: 'To Pickup',
                    icon: Assets.svg.truck,
                  ),
                ),
                Gap(8.w),
                Flexible(
                  flex: 1,
                  child: OrderOverViewCard(
                    count: dashboardDataModel.toDeliveryOrder.toString(),
                    status: 'To Delivery',
                    icon: Assets.svg.toDelivery,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfitWidget({required DashboardDataModel dashboardDataModel}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(12.dm),
      decoration: ShapeDecoration(
        color: AppStaticColor.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (dashboardDataModel.pendingWithdraw != null) ...[
                    Row(
                      children: [
                        Text(
                          '\$${dashboardDataModel.pendingWithdraw?.amount}',
                          style: AppTextStyle.text16B700.copyWith(
                            color: AppStaticColor.white,
                          ),
                        ),
                        Gap(5.w),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 4.dm),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.dm),
                            color: AppStaticColor.orange.withOpacity(0.9),
                          ),
                          child: Text('Pending',
                              style: AppTextStyle.text12B700
                                  .copyWith(fontWeight: FontWeight.w400)),
                        ),
                      ],
                    )
                  ] else ...[
                    Text(
                      '\$${dashboardDataModel.walletBalance}',
                      style: AppTextStyle.text16B700.copyWith(
                        color: AppStaticColor.white,
                      ),
                    ),
                  ],
                  Gap(4.h),
                  if (dashboardDataModel.pendingWithdraw != null) ...[
                    Text(
                      'Withdrawal request',
                      style: AppTextStyle.text12B700.copyWith(
                        fontWeight: FontWeight.w400,
                        color: AppStaticColor.secondary,
                      ),
                    )
                  ] else
                    Text(
                      'Withdrawable amount',
                      style: AppTextStyle.text12B700.copyWith(
                        fontWeight: FontWeight.w400,
                        color: AppStaticColor.secondary,
                      ),
                    )
                ],
              ),
            ),
            Container(),
            const VerticalDivider(
              color: AppStaticColor.gray,
              indent: 8,
              endIndent: 8,
            ),
            Gap(10.w),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '\$${dashboardDataModel.thisManthSales}',
                    style: AppTextStyle.text16B700.copyWith(
                      color: AppStaticColor.white,
                    ),
                  ),
                  Gap(4.h),
                  Text(
                    'Sales this month',
                    style: AppTextStyle.text12B700.copyWith(
                      fontWeight: FontWeight.w400,
                      color: AppStaticColor.secondary,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSalesStatistic(
      {required DashboardDataModel dashboardDataModel}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: AppStaticColor.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w)
                .copyWith(top: 16.h, right: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Sales Statistic',
                  style: AppTextStyle.text14B700,
                ),
                _buildDateWiseFilterWidget(),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 8.w, bottom: 8.h, top: 10.h),
            child: LineChartSample2(dashboardDataModel),
          ),
        ],
      ),
    );
  }

  Widget _buildDateWiseFilterWidget() {
    return Consumer(builder: (context, ref, _) {
      return Padding(
        padding: EdgeInsets.only(right: 16.w),
        child: InkWell(
          onTap: () => _popupMenuWidget(ref, context),
          borderRadius: BorderRadius.circular(8.r),
          child: Container(
            height: 36.h,
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
            decoration: BoxDecoration(
              border: Border.all(
                  color: ref.watch(isActiveFilter)
                      ? colors(GlobalFunction.navigatorKey.currentContext)
                          .primaryColor!
                      : AppStaticColor.secondary),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              children: [
                Text(
                  ref.watch(selectedFilterOption)!['value'],
                  style: AppTextStyle.text14B400
                      .copyWith(color: AppStaticColor.gray),
                ),
                Gap(5.w),
                SvgPicture.asset(ref.watch(isActiveFilter)
                    ? Assets.svg.arrowTop
                    : Assets.svg.arrowBottom)
              ],
            ),
          ),
        ),
      );
    });
  }

  Future<dynamic> _popupMenuWidget(WidgetRef ref, BuildContext context) {
    Completer<void> completer = Completer<void>();
    RenderBox buttonRenderBox = context.findRenderObject() as RenderBox;
    final buttonPosition = buttonRenderBox.localToGlobal(Offset.zero);
    final buttonSize = buttonRenderBox.size;
    ref.read(isActiveFilter.notifier).state = true;
    return showMenu(
      elevation: 1,
      color: colors(GlobalFunction.navigatorKey.currentContext).light,
      surfaceTintColor:
          colors(GlobalFunction.navigatorKey.currentContext).light,
      context: GlobalFunction.navigatorKey.currentContext!,
      position: RelativeRect.fromLTRB(
          buttonPosition.dx,
          buttonPosition.dy + buttonSize.height,
          buttonPosition.dx + buttonSize.width,
          buttonPosition.dy + buttonSize.height * 2),
      items: filterOptions.map(
        (option) {
          final value = option['value'];
          return PopupMenuItem<Map<String, dynamic>>(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            value: option,
            child: RadioListTile<Map<String, dynamic>>(
              visualDensity: VisualDensity.compact,
              value: option,
              groupValue: ref.watch(selectedFilterOption),
              onChanged: (selectedOption) {
                final selectedKey = selectedOption!['key'];
                final selectedValue = selectedOption['value'];
                debugPrint('Selected key: $selectedKey, value: $selectedValue');
                ref.read(selectedFilterOption.notifier).state = selectedOption;
                ref.refresh(dashboardServiceProvider(selectedKey).notifier);
                GoRouter.of(GlobalFunction.navigatorKey.currentContext!).pop();
              },
              title: Text(
                value,
                style: AppTextStyle.text14B400
                    .copyWith(fontWeight: FontWeight.w500),
              ),
            ),
          );
        },
      ).toList(),
    ).then((value) {
      ref.read(isActiveFilter.notifier).state = false;
      completer.complete();
    });
  }

  static final List<Map<String, dynamic>> filterOptions = [
    {'key': 'this_year', 'value': 'This Year'},
    {'key': 'last_year', 'value': 'Last Year'},
  ];

  PreferredSizeWidget? _buildAppBar() {
    return AppBar(
      centerTitle: false,
      title: Assets.png.splashLogo.image(height: 50.h, width: 140.w),
      actions: [
        GestureDetector(
            onTap: () => GlobalFunction.showCustomSnackbar(
                message: 'This feature is not available', isSuccess: false),
            child: SvgPicture.asset(Assets.svg.notification)),
        Gap(16.w),

        //  Hive.openBox(AppConstants.authBox).then((box) => [
        //           box.clear(),
        //           box.close(),
        //           GoRouter.of(GlobalFunction.context).go(Routes.login)
        //         ]),
      ],
    );
  }
}

final selectedFilterOption = StateProvider<Map<String, dynamic>?>(
    (ref) => {'key': 'this_year', 'value': 'This Year'});

final isActiveFilter = StateProvider<bool>((ref) => false);
