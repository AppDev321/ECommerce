import 'package:flutter/material.dart';
import 'package:razin_shop/views/eCommerce/products/layouts/products_layout.dart';

class EcommerceProductsView extends StatelessWidget {
  final int? categoryId;
  final String categoryName;
  final String? sortType;
  const EcommerceProductsView({
    Key? key,
    required this.categoryId,
    required this.categoryName,
    required this.sortType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EcommerceProductsLayout(
      categoryId: categoryId,
      categoryName: categoryName,
      sortType: sortType,
    );
  }
}
