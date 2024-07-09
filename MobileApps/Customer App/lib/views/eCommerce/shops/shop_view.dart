// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:razin_shop/views/eCommerce/shops/layouts/shop_layout.dart';

class EcommerceShopView extends StatelessWidget {
  final int shopId;
  const EcommerceShopView({
    Key? key,
    required this.shopId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EcommerceShopLayout(
      shopId: shopId,
    );
  }
}
