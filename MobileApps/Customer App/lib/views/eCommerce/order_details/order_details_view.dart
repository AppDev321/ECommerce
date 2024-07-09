import 'package:flutter/material.dart';
import 'package:razin_shop/views/eCommerce/order_details/layouts/order_details_layout.dart';

class OrderDetailsView extends StatelessWidget {
  final int orderId;
  const OrderDetailsView({
    Key? key,
    required this.orderId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OrderDetailsLayout(
      orderId: orderId,
    );
  }
}
