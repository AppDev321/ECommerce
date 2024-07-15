import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:razin_commerce_seller_flutter/config/app_color.dart';
import 'package:razin_commerce_seller_flutter/config/app_text_style.dart';
import 'package:razin_commerce_seller_flutter/config/theme.dart';
import 'package:razin_commerce_seller_flutter/features/common/widgets/custom_button.dart';
import 'package:razin_commerce_seller_flutter/features/common/widgets/transparent_button.dart';
import 'package:razin_commerce_seller_flutter/features/order/models/order_model.dart';
import 'package:razin_commerce_seller_flutter/features/order/providers/order_provider.dart';
import 'package:razin_commerce_seller_flutter/features/order/widgets/item_card.dart';
import 'package:razin_commerce_seller_flutter/features/order/widgets/order_status_widget.dart';
import 'package:razin_commerce_seller_flutter/features/order/widgets/pending_order_card.dart';
import 'package:razin_commerce_seller_flutter/gen/assets.gen.dart';
import 'package:razin_commerce_seller_flutter/utils/global_function.dart';

class OrderDetails extends ConsumerWidget {
  final int orderId;
  const OrderDetails(this.orderId, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Details'),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: ref.watch(orderDetailsServiceProvider(orderId)).whenOrNull(
                  data: (data) => OrderStatusWidget(
                    orderStatus: data.orderStatus,
                  ),
                  error: (error, stackTrace) => Text(error.toString()),
                ),
          ),
        ],
      ),
      bottomNavigationBar:
          ref.watch(orderDetailsServiceProvider(orderId)).whenOrNull(
                data: (data) => data.orderStatus == 'Pending'
                    ? _buildBottomNavigationBar()
                    : null,
              ),
      body: ref.watch(orderDetailsServiceProvider(orderId)).when(
            data: (orderDetails) => SingleChildScrollView(
              padding: EdgeInsets.only(top: 12.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildOrderItemsWidget(order: orderDetails),
                  Gap(14.h),
                  _buildOrderSummaryWidget(order: orderDetails),
                  Gap(8.h),
                  _buildShippingInfoWidget(order: orderDetails),
                  Gap(12.h),
                ],
              ),
            ),
            error: (error, stackTrace) => Text(error.toString()),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
          ),
    );
  }

  Widget _buildOrderItemsWidget({required Order order}) {
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
            itemBuilder: (context, index) =>
                ItemCard(product: order.products[index]),
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

  Widget _buildOrderSummaryWidget({required Order order}) {
    return Container(
      color: colors(GlobalFunction.navigatorKey.currentContext).light,
      padding: EdgeInsets.symmetric(vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RichText(
            text: TextSpan(
              text: 'ORDER ID ',
              style: AppTextStyle.text24B700.copyWith(
                color: colors(GlobalFunction.navigatorKey.currentContext)
                    .primaryColor,
                fontWeight: FontWeight.w500,
              ),
              children: [
                TextSpan(
                  text: order.orderCode,
                  style: AppTextStyle.text24B700.copyWith(
                    color: colors(GlobalFunction.navigatorKey.currentContext)
                        .primaryColor,
                  ),
                ),
              ],
            ),
          ),
          Gap(16.h),
          _buildInfo(order: order),
          Gap(16.h),
          _buildDotDividerWidget(),
          Gap(12.h),
          Visibility(
              visible: false,
              child: Align(alignment: Alignment.topCenter, child: _buildDownloadButton())),
        ],
      ),
    );
  }

  Widget _buildInfo({required Order order}) {
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
          _buildInfoRowWidget(key: 'Order Amount', value: '\$${order.amount}'),
          Gap(12.h),
          _buildInfoRowWidget(
              key: 'Payment Method', value: order.paymentMethod),
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

  Widget _buildShippingInfoWidget({required Order order}) {
    return Container(
      color: colors(GlobalFunction.navigatorKey.currentContext).light,
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Shipping info:',
            style:
                AppTextStyle.text14B400.copyWith(fontWeight: FontWeight.w700),
          ),
          Gap(8.h),
          _buildShippingInfoCardWidget(order: order),
          Gap(12.h),
          _deliveryInfoWidget(order: order)
        ],
      ),
    );
  }

  Widget _buildShippingInfoCardWidget({required Order order}) {
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
      child: Column(
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: CircleAvatar(
              radius: 18.sp,
              backgroundImage:
                  CachedNetworkImageProvider(order.user.profilePhoto),
            ),
            title: Text(
              order.user.name,
              style: AppTextStyle.text12B700,
            ),
            subtitle: Text(
              order.user.phone,
              style: AppTextStyle.text12B700.copyWith(
                  fontWeight: FontWeight.w500,
                  color: colors(GlobalFunction.navigatorKey.currentContext)
                      .primaryColor),
            ),
          ),
          Divider(
            height: 0,
            color: colors(GlobalFunction.navigatorKey.currentContext)
                .secondaryColor,
            thickness: 2,
          ),
          Gap(4.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
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
        ],
      ),
    );
  }

  Widget _deliveryInfoWidget({required Order order}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
      decoration: BoxDecoration(
        color:
            colors(GlobalFunction.navigatorKey.currentContext).secondaryColor,
        borderRadius: BorderRadius.circular(8.dm),
        border: Border.all(color: AppStaticColor.gray),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Flexible(
                flex: 1,
                child: _dateColumn(
                  title: order.orderStatus != 'Delivered'
                      ? 'Delivery between'
                      : 'Picked up',
                  date: order.orderStatus != 'Delivered'
                      ? order.estimatedDeliveryDate
                      : order.pickupDate ?? 'null',
                ),
              ),
              if (order.orderStatus == 'Delivered' ||
                  order.pickupDate != null) ...[
                Flexible(
                  flex: 1,
                  child: _dateColumn(
                      title: order.orderStatus == 'Delivered'
                          ? 'Delivered'
                          : 'Picked up',
                      date: order.orderStatus == 'Delivered'
                          ? order.estimatedDeliveryDate
                          : order.pickupDate ?? 'null'),
                ),
              ]
            ],
          ),
          if (order.rider != null) Gap(8.h),
          if (order.rider != null) _buildDotDividerWidget(),
          if (order.rider != null) Gap(8.h),
          if (order.rider != null)
            Row(
              children: [
                SvgPicture.asset(
                  Assets.svg.bike,
                  height: 18.h,
                  width: 18.w,
                  colorFilter: const ColorFilter.mode(
                      AppStaticColor.gray, BlendMode.srcIn),
                ),
                if (order.rider != null) Gap(5.w),
                const Text('Assign for Delivery')
              ],
            ),
          if (order.rider != null) Gap(5.h),
          if (order.rider != null) _buildRiderCard(rider: order.rider!)
        ],
      ),
    );
  }

  Widget _buildDotDividerWidget() {
    return Row(
      children: List.generate(
        150 ~/ 2,
        (index) => Expanded(
          child: Container(
            color: index % 2 == 0
                ? AppStaticColor.lightGray.withOpacity(0.5)
                : colors(GlobalFunction.navigatorKey.currentContext).light,
            height: 1,
          ),
        ),
      ),
    );
  }

  Widget _buildRiderCard({required Rider rider}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      decoration: BoxDecoration(
          color: AppStaticColor.white,
          borderRadius: BorderRadius.circular(8.dm)),
      child: ListTile(
        visualDensity: VisualDensity.compact,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.sp),
        ),
        contentPadding: EdgeInsets.zero,
        leading: CircleAvatar(
          radius: 18.sp,
          backgroundImage: CachedNetworkImageProvider(rider.profilePhoto),
        ),
        title: Text(
          rider.name,
          style: AppTextStyle.text14B400.copyWith(fontWeight: FontWeight.w500),
        ),
        subtitle: Text(
          rider.assignedAt,
          style: AppTextStyle.text12B700
              .copyWith(fontWeight: FontWeight.w400, fontSize: 10.sp),
        ),
        trailing: SvgPicture.asset(Assets.svg.callCircale),
      ),
    );
  }

  Widget _dateColumn({required String title, required String date}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyle.text12B700.copyWith(
            fontSize: 12.sp,
            color: AppStaticColor.gray,
          ),
        ),
        Gap(4.h),
        Row(
          children: [
            Row(
              children: [
                const Icon(Icons.calendar_month_rounded),
                Gap(8.w),
                Text(
                  date,
                  style: AppTextStyle.text14B700,
                )
              ],
            )
          ],
        )
      ],
    );
  }

  Widget _buildDownloadButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(Assets.svg.cloud),
        Gap(8.w),
        Text(
          'Download Invoice',
          style: AppTextStyle.text14B400,
        )
      ],
    );
  }

  Widget _buildBottomNavigationBar() {
    return Consumer(builder: (context, ref, _) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        color: AppStaticColor.white,
        height: 86.h,
        child: ref.watch(orderServiceProvider)
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: TransparentButton(
                      textColor: AppStaticColor.red,
                      color: AppStaticColor.white,
                      borderColor: AppStaticColor.red,
                      buttonName: 'Cancel',
                      onTap: () {
                        ref
                            .read(orderStatusProvider.notifier)
                            .updateOrderStatus(
                              orderId: orderId,
                              status: Status.cancel.name,
                            )
                            .then((value) => ref
                                .refresh(orderDetailsServiceProvider(orderId)));
                      },
                    ),
                  ),
                  Gap(12.w),
                  Flexible(
                    flex: 1,
                    child: CustomButton(
                      buttonName: 'Confirm',
                      onTap: () {
                        ref
                            .read(orderStatusProvider.notifier)
                            .updateOrderStatus(
                              orderId: orderId,
                              status: Status.confirm.name,
                            )
                            .then((value) => ref
                                .refresh(orderDetailsServiceProvider(orderId)));
                      },
                    ),
                  )
                ],
              ),
      );
    });
  }
}
