// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:razin_shop/components/ecommerce/confirmation_dialog.dart';
import 'package:razin_shop/components/ecommerce/custom_button.dart';
import 'package:razin_shop/config/app_color.dart';
import 'package:razin_shop/config/app_text_style.dart';
import 'package:razin_shop/config/theme.dart';
import 'package:razin_shop/controllers/common/master_controller.dart';
import 'package:razin_shop/controllers/eCommerce/cart/cart_controller.dart';
import 'package:razin_shop/controllers/eCommerce/order/order_controller.dart';
import 'package:razin_shop/controllers/misc/misc_controller.dart';
import 'package:razin_shop/gen/assets.gen.dart';
import 'package:razin_shop/models/eCommerce/order/buy_now_order_place.dart';
import 'package:razin_shop/models/eCommerce/order/order_place_model.dart';
import 'package:razin_shop/routes.dart';
import 'package:razin_shop/services/common/hive_service_provider.dart';
import 'package:razin_shop/utils/context_less_navigation.dart';
import 'package:razin_shop/utils/global_function.dart';
import 'package:razin_shop/views/eCommerce/checkout/components/add_address_button.dart';
import 'package:razin_shop/views/eCommerce/checkout/components/address_card.dart';
import 'package:razin_shop/views/eCommerce/checkout/components/address_modal_bottom_sheet.dart';
import 'package:razin_shop/views/eCommerce/checkout/components/build_payment_card.dart';
import 'package:razin_shop/views/eCommerce/checkout/components/order_placed_dialog.dart';
import 'package:razin_shop/views/eCommerce/checkout/components/pay_card.dart';
import 'package:razin_shop/views/eCommerce/checkout/layouts/web_payment_page.dart';

class EcommerceCheckoutLayout extends ConsumerStatefulWidget {
  final double payableAmount;
  final String? couponCode;
  final OrderNowArguments? orderNowArguments;
  const EcommerceCheckoutLayout({
    Key? key,
    required this.payableAmount,
    required this.couponCode,
    this.orderNowArguments,
  }) : super(key: key);

  @override
  ConsumerState<EcommerceCheckoutLayout> createState() =>
      _EcommerceCheckoutLayoutState();
}

class _EcommerceCheckoutLayoutState
    extends ConsumerState<EcommerceCheckoutLayout> {
  final TextEditingController additionalTextEditingController =
      TextEditingController();
  PaymentType selectedPaymentType = PaymentType.none;
  // String selectedPayment = '';

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      init();
    });
    super.initState();
  }

  void init() {
    ref.watch(hiveServiceProvider).getDefaultAddress().then((address) {
      ref.read(selectedDeliveryAddress.notifier).state = address;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalFunction.getBackgroundColor(context: context),
      appBar: AppBar(
        surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
        title: const Text('Checkout'),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
      body: Container(
        margin: EdgeInsets.only(top: 10.h),
        color: colors(context).light,
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: 20.w,
          vertical: 20.h,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildAddressWidget(),
              Gap(20.h),
              _buildAdditionalInfoTextField(),
              Gap(20.h),
              _buildToBePaidWidget(),
              if (selectedPaymentType == PaymentType.online) ...[
                _buildPaymentMethodsWidget()
                // const CircularProgressIndicator(),
              ]
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAddressWidget() {
    return Consumer(builder: (context, ref, _) {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Delivery Address',
                style: AppTextStyle(context).subTitle,
              ),
              ref.watch(selectedDeliveryAddress) != null
                  ? GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
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
                            return const AddressModalBottomSheet();
                          },
                        );
                      },
                      child: Text(
                        'Change',
                        style: AppTextStyle(context).bodyTextSmall.copyWith(
                              color: colors(context).primaryColor,
                            ),
                      ),
                    )
                  : const SizedBox()
            ],
          ),
          Gap(10.h),
          ref.watch(selectedDeliveryAddress) != null
              ? AddressCard(
                  address: ref.watch(selectedDeliveryAddress.notifier).state,
                )
              : _buildAddAddressCardWidget(),
        ],
      );
    });
  }

  Widget _buildAddAddressCardWidget() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 14.w,
        vertical: 14.h,
      ),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
          side: const BorderSide(color: EcommerceAppColor.offWhite),
        ),
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            Assets.svg.locationPurple,
            width: 20.w,
          ),
          Gap(10.w),
          Expanded(
            child: AddAddressButton(
              onTap: () {
                showModalBottomSheet(
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
                    return const AddressModalBottomSheet();
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _buildAdditionalInfoTextField() {
    return FormBuilderTextField(
      textAlign: TextAlign.start,
      name: 'additionalInfo',
      controller: additionalTextEditingController,
      style: AppTextStyle(context).bodyText.copyWith(
            fontWeight: FontWeight.w600,
          ),
      cursorColor: colors(context).primaryColor,
      maxLines: 5,
      minLines: 3,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16),
        alignLabelWithHint: true,
        hintText: 'Write here any additional info',
        hintStyle: AppTextStyle(context).bodyText.copyWith(
              fontWeight: FontWeight.w500,
              color: colors(context).hintTextColor,
            ),
        floatingLabelStyle: AppTextStyle(context).bodyText.copyWith(
              fontWeight: FontWeight.w400,
              color: colors(context).primaryColor,
            ),
        filled: true,
        fillColor: EcommerceAppColor.offWhite,
        errorStyle: AppTextStyle(context).bodyTextSmall.copyWith(
              fontWeight: FontWeight.w400,
              color: colors(context).errorColor,
            ),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: BorderSide.none),
      ),
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.done,
    );
  }

  Widget _buildToBePaidWidget() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              child: Row(
                children: [
                  SvgPicture.asset(Assets.svg.receipt),
                  Gap(8.w),
                  Text(
                    'To be Paid',
                    style: AppTextStyle(context).subTitle,
                  )
                ],
              ),
            ),
            Text(
              GlobalFunction.price(
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
                price: widget.orderNowArguments != null
                    ? ref
                        .read(buyNowSummeryController)['payableAmount']
                        .toString()
                    : ref
                        .read(cartSummeryController)['payableAmount']
                        .toString(),
              ),
              style: AppTextStyle(context).subTitle,
            )
          ],
        ),
        Gap(10.h),
        Row(
          children: [
            Flexible(
              flex: 1,
              child: PayCard(
                isActive:
                    selectedPaymentType == PaymentType.cash ? true : false,
                type: 'Cash on Delivery',
                image: Assets.png.cash.image(),
                onTap: () {
                  if (selectedPaymentType != PaymentType.cash) {
                    setState(() {
                      selectedPaymentType = PaymentType.cash;
                    });
                  }
                },
              ),
            ),
            Gap(10.w),
            Flexible(
              flex: 1,
              child: PayCard(
                isActive:
                    selectedPaymentType == PaymentType.online ? true : false,
                type: 'Credit or Debit Card',
                image: Assets.png.card.image(),
                onTap: () {
                  if (selectedPaymentType != PaymentType.online) {
                    setState(() {
                      selectedPaymentType = PaymentType.online;
                    });
                  }
                },
              ),
            )
          ],
        ),
      ],
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      height: 75.h,
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
      child: ref.watch(orderControllerProvider)
          ? const Center(child: CircularProgressIndicator())
          : AbsorbPointer(
              absorbing: selectedPaymentType == PaymentType.none,
              child: CustomButton(
                buttonColor: selectedPaymentType == PaymentType.none
                    ? ColorTween(
                        begin: colors(context).primaryColor,
                        end: colors(context).light,
                      ).lerp(0.5)
                    : colors(context).primaryColor,
                buttonText: 'Place Order',
                onPressed: () {
                  if (ref.watch(selectedDeliveryAddress) == null) {
                    GlobalFunction.showCustomSnackbar(
                      message: 'Please add your delivery address!',
                      isSuccess: false,
                    );
                  } else if (selectedPaymentType == PaymentType.online &&
                      ref.read(selectedPayment) == '') {
                    GlobalFunction.showCustomSnackbar(
                      message: 'Please select your payment method!',
                      isSuccess: false,
                    );
                  } else {
                    if (selectedPaymentType == PaymentType.cash) {
                      showDialog(
                          context: context,
                          builder: (context) => ConfirmationDialog(
                                title: 'Payment',
                                des:
                                    'Are you sure want to order now with cash?',
                                confirmButtonText: 'Yes',
                                cancelButtonText: 'No',
                                confirmationButtonColor:
                                    colors(context).primaryColor,
                                onPressed: () {
                                  context.nav.pop();
                                  if (widget.orderNowArguments != null) {
                                    _buyNow();
                                  } else {
                                    _placeOrder();
                                  }
                                },
                              ));
                    } else {
                      if (widget.orderNowArguments != null) {
                        _buyNow();
                      } else {
                        _placeOrder();
                      }
                    }
                  }
                },
              ),
            ),
    );
  }

  Widget _buildPaymentMethodsWidget() {
    return SizedBox(
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.only(top: 16.h),
        shrinkWrap: true,
        itemCount: ref
            .read(masterControllerProvider.notifier)
            .materModel
            .data
            .paymentGateways
            .length,
        itemBuilder: (context, index) {
          final paymentMethod = ref
              .read(masterControllerProvider.notifier)
              .materModel
              .data
              .paymentGateways[index];
          return Padding(
            padding: EdgeInsets.only(bottom: 10.h),
            child: PaymentCard(
              onTap: () {
                ref.read(selectedPayment.notifier).state = paymentMethod.name;
              },
              isActive: ref.watch(selectedPayment) == paymentMethod.name,
              paymentGateways: paymentMethod,
            ),
          );
        },
      ),
    );
  }

  void _placeOrder() {
    final OrderPlaceModel order = OrderPlaceModel(
      addressId: ref.watch(selectedDeliveryAddress)!.addressId,
      couponId: widget.couponCode,
      note: additionalTextEditingController.text,
      paymentMethod: selectedPaymentType == PaymentType.online
          ? ref.read(selectedPayment)
          : selectedPaymentType.name,
      shopIds: ref.read(shopIdsProvider).toList(),
    );
    ref
        .read(orderControllerProvider.notifier)
        .placeOrder(orderPlaceModel: order)
        .then((response) {
      if (response.isSuccess) {
        ref.read(cartController.notifier).getAllCarts();
        ref.refresh(selectedTabIndexProvider.notifier).state;
        if (response.data != null) {
          context.nav.pushNamedAndRemoveUntil(
            Routes.webPaymentScreen,
            (route) => false,
            arguments: WebPaymentScreenArg(
              paymentUrl: response.data,
              orderId: null,
            ),
          );
        } else {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => const OrderPlacedDialog(),
          );
        }
      }
    });
  }

  _buyNow() {
    final BuyNowOrderPlace buyNowOrderPlace = BuyNowOrderPlace(
      productId: widget.orderNowArguments!.productId,
      quantity: widget.orderNowArguments!.quantity,
      addressId: ref.watch(selectedDeliveryAddress)!.addressId!,
      paymentMethod: selectedPaymentType == PaymentType.online
          ? ref.read(selectedPayment)
          : selectedPaymentType.name,
      color: widget.orderNowArguments!.color,
      size: widget.orderNowArguments!.size,
    );

    ref
        .read(orderControllerProvider.notifier)
        .buyNow(orderPlaceModel: buyNowOrderPlace)
        .then((response) {
      if (response.isSuccess) {
        // ref.read(cartController.notifier).getAllCarts();
        // ref.refresh(selectedTabIndexProvider.notifier).state;
        if (response.data != null) {
          context.nav.pushNamedAndRemoveUntil(
            Routes.webPaymentScreen,
            (route) => false,
            arguments: WebPaymentScreenArg(
              paymentUrl: response.data,
              orderId: null,
            ),
          );
        } else {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => const OrderPlacedDialog(),
          );
        }
      }
    });
  }
}

class OrderNowArguments {
  final int productId;
  final int quantity;
  final String? color;
  final String? size;
  OrderNowArguments({
    required this.productId,
    required this.quantity,
    this.color,
    this.size,
  });
}

enum PaymentType { cash, online, none }
