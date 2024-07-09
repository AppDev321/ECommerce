import 'dart:convert';

import 'package:razin_shop/models/eCommerce/product/product.dart' as product;
import 'package:razin_shop/models/eCommerce/shop/shop_details.dart';

import '../category/category.dart';
import '../shop/shop.dart';

class Dashboard {
  final List<Banner> banners;
  final List<Category> categories;
  final List<product.Product> popularProducts;
  final List<Shop> shops;
  final JustForYou justForYou;
  Dashboard({
    required this.banners,
    required this.categories,
    required this.popularProducts,
    required this.shops,
    required this.justForYou,
  });

  Dashboard copyWith({
    List<Banner>? banners,
    List<Category>? categories,
    List<product.Product>? popularProducts,
    List<Shop>? shops,
    JustForYou? justForYou,
  }) {
    return Dashboard(
      banners: banners ?? this.banners,
      categories: categories ?? this.categories,
      shops: shops ?? this.shops,
      popularProducts: popularProducts ?? this.popularProducts,
      justForYou: justForYou ?? this.justForYou,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'banners': banners.map((x) => x.toMap()).toList(),
      'categories': categories.map((x) => x.toMap()).toList(),
      'popularProducts': popularProducts.map((x) => x.toMap()).toList(),
      'justForYou': justForYou.toMap(),
    };
  }

  factory Dashboard.fromMap(Map<String, dynamic> map) {
    return Dashboard(
      banners: List<Banner>.from(
        (map['banners'] as List<dynamic>).map<Banner>(
          (x) => Banner.fromMap(x as Map<String, dynamic>),
        ),
      ),
      categories: List<Category>.from(
        (map['categories'] as List<dynamic>).map<Category>(
          (x) => Category.fromMap(x as Map<String, dynamic>),
        ),
      ),
      shops: List<Shop>.from(
        (map['shops'] as List<dynamic>).map<Shop>(
          (x) => Shop.fromMap(x as Map<String, dynamic>),
        ),
      ),
      popularProducts: List<product.Product>.from(
        (map['popular_products'] as List<dynamic>).map<product.Product>(
          (x) => product.Product.fromMap(x as Map<String, dynamic>),
        ),
      ),
      justForYou:
          JustForYou.fromMap(map['just_for_you'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory Dashboard.fromJson(String source) =>
      Dashboard.fromMap(json.decode(source) as Map<String, dynamic>);
}

class JustForYou {
  final int total;
  List<product.Product> products;
  JustForYou({
    required this.total,
    required this.products,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'total': total,
      'products': products.map((x) => x.toMap()).toList(),
    };
  }

  factory JustForYou.fromMap(Map<String, dynamic> map) {
    return JustForYou(
      total: map['total'] as int,
      products: List<product.Product>.from(
        (map['products'] as List<dynamic>).map<product.Product>(
          (x) => product.Product.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory JustForYou.fromJson(String source) =>
      JustForYou.fromMap(json.decode(source) as Map<String, dynamic>);
}
