// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:razin_shop/views/eCommerce/my_cart/layouts/my_cart_layout.dart';

class EcommerceMyCartView extends StatelessWidget {
  final bool isRoot;
  const EcommerceMyCartView({
    Key? key,
    required this.isRoot,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EcommerceMyCartLayout(
      isRoot: isRoot,
    );
  }
}
