import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:razin_shop/components/ecommerce/confirmation_dialog.dart';
import 'package:razin_shop/components/ecommerce/custom_button.dart';
import 'package:razin_shop/components/ecommerce/custom_transparent_button.dart';
import 'package:razin_shop/config/app_color.dart';
import 'package:razin_shop/config/app_text_style.dart';
import 'package:razin_shop/config/theme.dart';
import 'package:razin_shop/controllers/common/master_controller.dart';
import 'package:razin_shop/controllers/eCommerce/order/order_controller.dart';
import 'package:razin_shop/controllers/eCommerce/payment/payment_controller.dart';
import 'package:razin_shop/controllers/misc/misc_controller.dart';
import 'package:razin_shop/generated/l10n.dart';
import 'package:razin_shop/models/eCommerce/order/order_details_model.dart';
import 'package:razin_shop/routes.dart';
import 'package:razin_shop/utils/context_less_navigation.dart';
import 'package:razin_shop/utils/global_function.dart';
import 'package:razin_shop/views/eCommerce/checkout/components/address_card.dart';
import 'package:razin_shop/views/eCommerce/checkout/components/build_payment_card.dart';
import 'package:razin_shop/views/eCommerce/checkout/components/order_placed_dialog.dart';
import 'package:razin_shop/views/eCommerce/checkout/layouts/web_payment_page.dart';
import 'package:razin_shop/views/eCommerce/order_details/components/order_details_card.dart';
import 'package:razin_shop/views/eCommerce/order_details/components/order_product_card.dart';
import 'package:razin_shop/views/eCommerce/products/layouts/product_details_layout.dart';

class OrderDetailsLayout extends ConsumerWidget {
  final int orderId;
  const OrderDetailsLayout({super.key, required this.orderId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: GlobalFunction.getBackgroundColor(context: context),
      appBar: AppBar(
        title: Text(S.of(context).orderDetails),
        surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      bottomNavigationBar:
          ref.watch(orderDetailsControllerProvider(orderId)).when(
                data: (orderDetails) =>
                    orderDetails.data.order.orderStatus.toLowerCase() !=
                                'cancelled' &&
                            orderDetails.data.order.orderStatus.toLowerCase() !=
                                'confirm' &&
                            orderDetails.data.order.orderStatus.toLowerCase() !=
                                'processing' &&
                            orderDetails.data.order.orderStatus.toLowerCase() !=
                                'on the way'
                        ? _buildBottomNavigationWidget(
                            context: context,
                            orderId: orderDetails.data.order.id,
                            orderStatus: orderDetails.data.order.orderStatus,
                          )
                        : null,
                error: (error, s) => null,
                loading: () => const SizedBox(),
              ),
      body: Consumer(
        builder: (context, ref, _) {
          final asyncValue = ref.watch(orderDetailsControllerProvider(orderId));
          return asyncValue.when(
            data: (orderDetails) => SingleChildScrollView(
              child: Column(
                children: [
                  Gap(8.h),
                  _buildServiceItemsWidget(
                    context,
                    orderDetails.data.order.products,
                    orderDetails.data.order.orderStatus,
                  ),
                  Gap(8.h),
                  _buildShopCardWidget(
                    context: context,
                    orderDetails: orderDetails,
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                    child: AddressCard(
                      address: orderDetails.data.order.address,
                      cardColor: EcommerceAppColor.white,
                    ),
                  ),
                  OrderDetailsCard(
                    orderDetails: orderDetails,
                  ),
                  Gap(8.h),
                  Visibility(
                    visible:
                        orderDetails.data.order.paymentStatus == 'Pending' &&
                            orderDetails.data.order.paymentMethod ==
                                'Online Payment',
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: CustomTransparentButton(
                            buttonTextColor: colors(context).primaryColor,
                            borderColor: colors(context).primaryColor,
                            buttonText: 'Pay Now',
                            onTap: () {
                              showModalBottomSheet(
                                showDragHandle: true,
                                isScrollControlled: true,
                                backgroundColor: EcommerceAppColor.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(12.r),
                                    topRight: Radius.circular(12.r),
                                  ),
                                ),
                                context: context,
                                builder: (context) {
                                  return _buildPaymentBottomSheet();
                                },
                              );
                            },
                          ),
                        ),
                        Gap(8.h),
                      ],
                    ),
                  )
                ],
              ),
            ),
            error: ((error, stackTrace) => Center(
                  child: Text(error.toString()),
                )),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }

  Widget _buildServiceItemsWidget(
      BuildContext context, List<Products> products, String orderStatus) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 14.h,
      ),
      color: EcommerceAppColor.white,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Text(
              '${S.of(context).serviceItem} (${products.length})',
              style: AppTextStyle(context).subTitle.copyWith(fontSize: 16.sp),
            ),
          ),
          Gap(14.h),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: products.length,
            itemBuilder: (context, index) => OrderProductCard(
              orderId: orderId,
              product: products[index],
              orderStatus: orderStatus,
              index: index,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildShopCardWidget({
    required BuildContext context,
    required OrderDetails orderDetails,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
      color: EcommerceAppColor.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(S.of(context).shoppingFrom,
              style: AppTextStyle(context).bodyTextSmall),
          Gap(10.h),
          Material(
            borderRadius: BorderRadius.circular(8.r),
            color: EcommerceAppColor.offWhite,
            child: InkWell(
              borderRadius: BorderRadius.circular(8.r),
              onTap: () {
                // showDialog(
                //   context: context,
                //   builder: (context) => const SellerReviewDialog(),
                // );
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 7,
                      child: SizedBox(
                        child: Row(
                          children: [
                            Flexible(
                              flex: 2,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5.r),
                                child: CachedNetworkImage(
                                  imageUrl: orderDetails.data.order.shop.logo,
                                  height: 24.h,
                                  width: 24.w,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Gap(10.w),
                            Flexible(
                              flex: 5,
                              child: Text(
                                orderDetails.data.order.shop.name,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyle(context)
                                    .bodyTextSmall
                                    .copyWith(
                                        color: EcommerceAppColor.black,
                                        fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Spacer(),
                    Flexible(
                      flex: 2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            Icons.star_rounded,
                            color: EcommerceAppColor.carrotOrange,
                            size: 20.sp,
                          ),
                          Gap(5.w),
                          Text(
                            orderDetails.data.order.shop.rating.toString(),
                            style: AppTextStyle(context).bodyTextSmall.copyWith(
                                color: EcommerceAppColor.black,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildBottomNavigationWidget(
      {required BuildContext context,
      required int orderId,
      required String orderStatus}) {
    return Consumer(builder: (context, ref, _) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        height: 86.h,
        color: Theme.of(context).scaffoldBackgroundColor,
        child: orderStatus.toLowerCase() == 'pending'
            ? CustomTransparentButton(
                buttonText: S.of(context).cancelOrder,
                borderColor: EcommerceAppColor.offWhite,
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => ConfirmationDialog(
                      title: 'Are you sure want to cancel this order?',
                      confirmButtonText: S.of(context).confirm,
                      isLoading: ref.watch(orderControllerProvider),
                      onPressed: () {
                        ref
                            .read(orderControllerProvider.notifier)
                            .cancelOrder(orderId: orderId)
                            .then((response) {
                          final data = ref
                              .refresh(orderDetailsControllerProvider(orderId));
                          debugPrint(data.toString());
                          return context.nav.pop();
                        });
                      },
                    ),
                  );
                },
              )
            : orderStatus.toLowerCase() == 'delivered'
                ? ref.watch(orderControllerProvider)
                    ? const Center(child: CircularProgressIndicator())
                    : CustomButton(
                        buttonText: S.of(context).orderAgain,
                        onPressed: () => showDialog(
                          context: context,
                          builder: (context) => ConfirmationDialog(
                              title: 'Order Again',
                              des: 'Are you sure want to order again?',
                              confirmButtonText: S.of(context).confirm,
                              confirmationButtonColor:
                                  colors(context).primaryColor,
                              onPressed: () {
                                context.nav.pop();
                                ref
                                    .read(orderControllerProvider.notifier)
                                    .orderAgain(orderId: orderId)
                                    .then((response) => response.isSuccess ==
                                            true
                                        ? showDialog(
                                            context: GlobalFunction
                                                .navigatorKey.currentContext!,
                                            builder: (context) =>
                                                const OrderPlacedDialog())
                                        : null);
                              }),
                        ),
                      )
                : const SizedBox.shrink(),
      );
    });
  }

  Widget _buildPaymentBottomSheet() {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Consumer(builder: (context, ref, _) {
            return ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              shrinkWrap: true,
              itemCount: ref
                  .read(masterControllerProvider.notifier)
                  .materModel
                  .data
                  .paymentGateways
                  .length,
              itemBuilder: ((context, index) {
                final paymentGateway = ref
                    .read(masterControllerProvider.notifier)
                    .materModel
                    .data
                    .paymentGateways[index];
                return Padding(
                  padding: EdgeInsets.only(bottom: 7.h),
                  child: PaymentCard(
                    paymentGateways: paymentGateway,
                    isActive: ref.watch(selectedPayment) == paymentGateway.name,
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (_) => LoadingWrapperWidget(
                          isLoading: ref.watch(paymentControllerProvider),
                          child: Container(),
                        ),
                      );
                      ref.read(selectedPayment.notifier).state =
                          paymentGateway.name;

                      ref
                          .read(paymentControllerProvider.notifier)
                          .orderPayment(
                            orderId: orderId,
                            paymentMethod: ref.read(selectedPayment),
                          )
                          .then((paymentUrl) {
                        ref.refresh(selectedPayment.notifier).state;
                        if (paymentUrl != null) {
                          context.nav.pop();
                          context.nav.popAndPushNamed(
                            Routes.webPaymentScreen,
                            arguments: WebPaymentScreenArg(
                              paymentUrl: paymentUrl,
                              orderId: orderId,
                            ),
                          );
                        } else {
                          Navigator.of(context)
                            ..pop()
                            ..pop();
                          GlobalFunction.showCustomSnackbar(
                            message: 'Something went wrong!',
                            isSuccess: false,
                          );
                        }
                      });
                    },
                  ),
                );
              }),
            );
          }),
        ],
      ),
    );
  }
}
