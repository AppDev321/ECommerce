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
import 'package:razin_commerce_seller_flutter/features/common/widgets/custom_button.dart';
import 'package:razin_commerce_seller_flutter/features/order/models/order_filter_model.dart';
import 'package:razin_commerce_seller_flutter/features/order/models/order_model.dart';
import 'package:razin_commerce_seller_flutter/features/order/providers/order_provider.dart';
import 'package:razin_commerce_seller_flutter/features/order/screens/orders.dart';
import 'package:razin_commerce_seller_flutter/features/order/widgets/item_card.dart';
import 'package:razin_commerce_seller_flutter/features/order/widgets/pending_order_card.dart';
import 'package:razin_commerce_seller_flutter/gen/assets.gen.dart';
import 'package:razin_commerce_seller_flutter/utils/global_function.dart';

class OrderDetailsBottomSheet extends StatelessWidget {
  final Order order;
  const OrderDetailsBottomSheet({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      return Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 1.3,
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              vertical: 16.h,
            ),
            decoration: BoxDecoration(
              color: colors(context).light,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.dm),
                topRight: Radius.circular(16.dm),
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'New Order',
                    style: AppTextStyle.text24B700,
                  ),
                  Gap(12.h),
                  Divider(
                    height: 0,
                    thickness: 2,
                    color: colors(context).secondaryColor,
                  ),
                  Gap(8.h),
                  _buildOrderItemsWidget(),
                  Gap(20.h),
                  RichText(
                    text: TextSpan(
                      text: 'ORDER ID ',
                      style: AppTextStyle.text24B700.copyWith(
                        color: colors(context).primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                      children: [
                        TextSpan(
                            text: order.orderCode,
                            style: AppTextStyle.text24B700
                                .copyWith(color: colors(context).primaryColor)),
                      ],
                    ),
                  ),
                  Gap(16.h),
                  _buildOrderSummaryWidget(),
                  Gap(12.h),
                  _buildShippingInfoWidget(),
                  Gap(12.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: ref.watch(orderStatusProvider)
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : CustomButton(
                            color: AppStaticColor.green,
                            buttonName: 'Confirm',
                            onTap: () {
                              ref
                                  .read(orderStatusProvider.notifier)
                                  .updateOrderStatus(
                                      orderId: order.id,
                                      status: Status.confirm.name)
                                  .then((response) => [
                                        GlobalFunction.showCustomSnackbar(
                                          message: response.message,
                                          isSuccess: response.status,
                                        ),
                                        ref
                                            .read(orderServiceProvider.notifier)
                                            .getOrders(
                                              filter: OrderFilterModel(
                                                page: 1,
                                                perPage: 20,
                                                status: ref.read(
                                                    selectedOrderStatusProvider),
                                              ),
                                            ),
                                        GoRouter.of(context).pop(context),
                                      ]);
                            },
                          ),
                  ),
                  Gap(16.h),
                  TextButton(
                    onPressed: () {
                      GoRouter.of(context).pop(context);
                      GoRouter.of(context)
                          .push(Routes.orderDetails, extra: order.id);
                    },
                    child: Text(
                      'View Details',
                      style: AppTextStyle.text16B700
                          .copyWith(color: AppStaticColor.primary),
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            right: 0.w,
            top: 0.h,
            child: IconButton(
              onPressed: () {
                GoRouter.of(context).pop(context);
              },
              icon: const Icon(Icons.close),
            ),
          )
        ],
      );
    });
  }

  Widget _buildOrderItemsWidget() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.only(top: 12.h),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: colors(GlobalFunction.navigatorKey.currentContext).light,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x1E000000),
            blurRadius: 4,
            offset: Offset(0, 2),
            spreadRadius: 0,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 12.w),
            child: Text(
              'Order Items (${order.products.length})',
              style: AppTextStyle.text14B400.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Gap(12.h),
          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: order.products.length,
            itemBuilder: (context, index) => ItemCard(
              product: order.products[index],
            ),
            separatorBuilder: (context, index) => Divider(
              thickness: 2,
              indent: 16,
              endIndent: 16,
              color: colors(GlobalFunction.navigatorKey.currentContext)
                  .secondaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderSummaryWidget() {
    return Container(
      padding: EdgeInsets.all(12.dm),
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: ShapeDecoration(
        color:
            colors(GlobalFunction.navigatorKey.currentContext).secondaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.dm),
        ),
      ),
      child: Column(
        children: [
          _buildInfoRowWidget(key: 'Order Placed', value: order.orderPlaced),
          Gap(12.h),
          _buildInfoRowWidget(
              key: 'Delivery between', value: order.estimatedDeliveryDate),
          Gap(12.h),
          _buildInfoRowWidget(key: 'Order Amount', value: '\$${order.amount}'),
          Gap(12.h),
          _buildInfoRowWidget(
              key: 'Payment Method', value: order.paymentMethod),
        ],
      ),
    );
  }

  Widget _buildShippingInfoWidget() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Shipping info:',
            style:
                AppTextStyle.text14B400.copyWith(fontWeight: FontWeight.w700),
          ),
          Gap(8.h),
          _buildShippingInfoCardWidget(),
        ],
      ),
    );
  }

  Widget _buildShippingInfoCardWidget() {
    return Container(
      padding: EdgeInsets.all(8.dm),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1,
            color: colors(GlobalFunction.navigatorKey.currentContext)
                .secondaryColor!,
          ),
          borderRadius: BorderRadius.circular(8.dm),
        ),
      ),
      child: Row(
        children: [
          Flexible(
            flex: 1,
            child: SvgPicture.asset(Assets.svg.location),
          ),
          Gap(8.w),
          Flexible(
            flex: 7,
            child: Text(
              GlobalFunction.getFormattedAddress(order.user.address),
              style: AppTextStyle.text14B400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRowWidget({
    required String key,
    required String value,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          key,
          style: AppTextStyle.text16B400.copyWith(
            color: AppStaticColor.gray,
          ),
        ),
        Text(value, style: AppTextStyle.text16B700)
      ],
    );
  }
}
