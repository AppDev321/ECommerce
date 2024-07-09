import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:razin_shop/config/app_color.dart';
import 'package:razin_shop/config/app_constants.dart';
import 'package:razin_shop/config/app_text_style.dart';
import 'package:razin_shop/controllers/common/master_controller.dart';
import 'package:razin_shop/gen/assets.gen.dart';
import 'package:razin_shop/generated/l10n.dart';
import 'package:razin_shop/models/eCommerce/order/order_model.dart';
import 'package:razin_shop/routes.dart';
import 'package:razin_shop/utils/context_less_navigation.dart';
import 'package:razin_shop/utils/global_function.dart';

class MyOrderCard extends StatelessWidget {
  final OrderModel order;
  const MyOrderCard({
    Key? key,
    required this.order,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 3.h),
      child: Material(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: InkWell(
          onTap: () {
            context.nav.pushNamed(
              Routes.getOrderDetailsViewRouteName(AppConstants.appServiceName),
              arguments: order.id,
            );
          },
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 14.w,
              vertical: 20.h,
            ),
            margin: EdgeInsets.only(top: 3.h),
            width: double.infinity,
            child: Column(
              children: [
                _buildAddressCardWidget(context),
                Gap(14.h),
                _buildRowWidget(
                  context: context,
                  key: S.of(context).orderId,
                  value: order.orderCode,
                ),
                Gap(14.h),
                _buildRowWidget(
                  context: context,
                  key: S.of(context).date,
                  value: DateFormat('d MMMM yyyy').format(
                    DateTime.parse(order.createdAt),
                  ),
                ),
                Gap(14.h),
                _buildRowWidget(
                  context: context,
                  key: S.of(context).amount,
                  value: order.amount,
                  isAmount: true,
                ),
                Gap(14.h),
                _buildRowWidget(
                  context: context,
                  key: S.of(context).status,
                  value: order.orderStatus.toLowerCase(),
                  isOrderStatus: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRowWidget({
    required BuildContext context,
    required String key,
    required dynamic value,
    bool isAmount = false,
    bool isOrderStatus = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          key,
          style: AppTextStyle(context).bodyTextSmall,
        ),
        if (isOrderStatus) ...[
          GlobalFunction.getStatusWidget(context: context, status: value)
        ] else ...[
          Consumer(builder: (context, ref, _) {
            return Text(
              isAmount
                  ? GlobalFunction.price(
                      currency: ref
                          .read(masterControllerProvider.notifier)
                          .materModel
                          .data
                          .currency
                          .symbol,
                      position: ref
                          .read(masterControllerProvider.notifier)
                          .materModel
                          .data
                          .currency
                          .position,
                      price: value.toString())
                  : value.toString(),
              style: AppTextStyle(context).bodyText,
            );
          }),
        ]
      ],
    );
  }

  Widget _buildAddressCardWidget(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      width: double.infinity,
      decoration: BoxDecoration(
        color: EcommerceAppColor.offWhite,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        children: [
          Flexible(flex: 1, child: SvgPicture.asset(Assets.svg.fillLocation)),
          Gap(5.w),
          Flexible(
            flex: 8,
            child: Text(
              GlobalFunction.formatDeliveryAddress(
                context: context,
                address: order.address,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyle(context).bodyText.copyWith(fontSize: 12.sp),
            ),
          )
        ],
      ),
    );
  }
}
