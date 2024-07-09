// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:razin_shop/models/eCommerce/category/category.dart';
import 'package:razin_shop/views/eCommerce/shops/layouts/shop_products_layout.dart';

class EcommerceShopProductsView extends StatelessWidget {
  final int shopId;
  final String shopName;
  final int categoryId;
  final List<Category> categories;
  const EcommerceShopProductsView({
    Key? key,
    required this.shopId,
    required this.shopName,
    required this.categoryId,
    required this.categories,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return EcommerceShopProductsLayout(
      shopId: shopId,
      shopName: shopName,
      categoryId: categoryId,
      categories: categories,
    );
  }
}
