import 'package:flutter/material.dart';
import 'package:razin_shop/models/eCommerce/order/order_now_cart_model.dart';
import 'package:razin_shop/views/eCommerce/order_now/layouts/order_now_layout.dart';

class EcommerceOrderNowView extends StatelessWidget {
  final OrderNowCartModel orderNowCartModel;
  const EcommerceOrderNowView({
    Key? key,
    required this.orderNowCartModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EcommerceOrderNowLayout(
      orderNowCartModel: orderNowCartModel,
    );
  }
}
