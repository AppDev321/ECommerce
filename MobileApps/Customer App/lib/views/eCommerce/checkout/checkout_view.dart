// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:razin_shop/views/eCommerce/checkout/layouts/checkout_layout.dart';

class EcommerceCheckoutView extends StatelessWidget {
  final double payableAmount;
  final String? couponCode;
  final OrderNowArguments? orderNowArguments;
  const EcommerceCheckoutView({
    Key? key,
    required this.payableAmount,
    required this.couponCode,
    this.orderNowArguments,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EcommerceCheckoutLayout(
      payableAmount: payableAmount,
      couponCode: couponCode,
      orderNowArguments: orderNowArguments,
    );
  }
}
