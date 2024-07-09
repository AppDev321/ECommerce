import 'package:flutter/material.dart';
import 'package:razin_shop/views/eCommerce/products/layouts/product_details_layout.dart';

class EcommerceProductDetailsView extends StatelessWidget {
  final int productId;
  const EcommerceProductDetailsView({
    Key? key,
    required this.productId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EcommerceProductDetailsLayout(
      productId: productId,
    );
  }
}
