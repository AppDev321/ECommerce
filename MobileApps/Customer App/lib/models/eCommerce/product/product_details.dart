import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:razin_shop/models/eCommerce/product/product.dart'
    as productModel;

class ProductDetails {
  final Product product;
  final List<productModel.Product> relatedProducts;
  ProductDetails({
    required this.product,
    required this.relatedProducts,
  });

  ProductDetails copyWith({
    Product? product,
    List<productModel.Product>? relatedProducts,
  }) {
    return ProductDetails(
      product: product ?? this.product,
      relatedProducts: relatedProducts ?? this.relatedProducts,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'product': product.toMap(),
      'relatedProducts': relatedProducts.map((x) => x.toMap()).toList(),
    };
  }

  factory ProductDetails.fromMap(Map<String, dynamic> map) {
    return ProductDetails(
      product: Product.fromMap(map['product'] as Map<String, dynamic>),
      relatedProducts: List<productModel.Product>.from(
        (map['related_products'] as List<dynamic>).map<productModel.Product>(
          (x) => productModel.Product.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductDetails.fromJson(String source) =>
      ProductDetails.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ProductDetails(product: $product, relatedProducts: $relatedProducts)';

  @override
  bool operator ==(covariant ProductDetails other) {
    if (identical(this, other)) return true;

    return other.product == product &&
        listEquals(other.relatedProducts, relatedProducts);
  }

  @override
  int get hashCode => product.hashCode ^ relatedProducts.hashCode;
}

class Product {
  final int id;
  final String name;
  final String shortDescription;
  final double price;
  final double discountPrice;
  final double discountPercentage;
  final double rating;
  final String totalReviews;
  final String totalSold;
  final int quantity;
  final bool isFavorite;
  final List<Thumbnail> thumbnails;
  final List<Color> colors;
  final List<SizeModel> productSizeList;
  final String? brand;
  final ShopInfo shop;
  final String description;
  Product({
    required this.id,
    required this.name,
    required this.shortDescription,
    required this.price,
    required this.discountPrice,
    required this.discountPercentage,
    required this.rating,
    required this.totalReviews,
    required this.totalSold,
    required this.quantity,
    required this.isFavorite,
    required this.thumbnails,
    required this.colors,
    required this.productSizeList,
    required this.brand,
    required this.shop,
    required this.description,
  });

  Product copyWith({
    int? id,
    String? name,
    String? shortDescription,
    double? price,
    double? discountPrice,
    double? discountPercentage,
    double? rating,
    String? totalReviews,
    String? totalSold,
    int? quantity,
    bool? isFavorite,
    List<Thumbnail>? thumbnails,
    List<Color>? colors,
    List<SizeModel>? productSizeList,
    String? brand,
    ShopInfo? shop,
    String? description,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      shortDescription: shortDescription ?? this.shortDescription,
      price: price ?? this.price,
      discountPrice: discountPrice ?? this.discountPrice,
      discountPercentage: discountPercentage ?? this.discountPercentage,
      rating: rating ?? this.rating,
      totalReviews: totalReviews ?? this.totalReviews,
      totalSold: totalSold ?? this.totalSold,
      quantity: quantity ?? this.quantity,
      isFavorite: isFavorite ?? this.isFavorite,
      thumbnails: thumbnails ?? this.thumbnails,
      colors: colors ?? this.colors,
      productSizeList: productSizeList ?? this.productSizeList,
      brand: brand ?? this.brand,
      shop: shop ?? this.shop,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'shortDescription': shortDescription,
      'price': price,
      'discountPrice': discountPrice,
      'discountPercentage': discountPercentage,
      'rating': rating,
      'totalReviews': totalReviews,
      'totalSold': totalSold,
      'quantity': quantity,
      'isFavorite': isFavorite,
      'thumbnails': thumbnails.map((x) => x.toMap()).toList(),
      'colors': colors.map((x) => x.toMap()).toList(),
      'brand': brand,
      'shop': shop.toMap(),
      'description': description,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'].toInt() as int,
      name: map['name'] as String,
      shortDescription: map['short_description'] as String,
      price: map['price'].toDouble() as double,
      discountPrice: map['discount_price'].toDouble() as double,
      discountPercentage: map['discount_percentage'].toDouble() as double,
      rating: map['rating'].toDouble() as double,
      totalReviews: map['total_reviews'] as String,
      totalSold: map['total_sold'] as String,
      quantity: map['quantity'].toInt() as int,
      isFavorite: map['is_favorite'] as bool,
      thumbnails: List<Thumbnail>.from(
        (map['thumbnails'] as List<dynamic>).map<Thumbnail>(
          (x) => Thumbnail.fromMap(x as Map<String, dynamic>),
        ),
      ),
      colors: List<Color>.from(
        (map['colors'] as List<dynamic>).map<Color>(
          (x) => Color.fromMap(x as Map<String, dynamic>),
        ),
      ),
      productSizeList: List<SizeModel>.from(
        (map['sizes'] as List<dynamic>).map<SizeModel>(
          (e) => SizeModel.fromMap(e),
        ),
      ),
      brand: map['brand'] as String?,
      shop: ShopInfo.fromMap(map['shop'] as Map<String, dynamic>),
      description: map['description'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Product(id: $id, name: $name, shortDescription: $shortDescription, price: $price, discountPrice: $discountPrice, discountPercentage: $discountPercentage, rating: $rating, totalReviews: $totalReviews, totalSold: $totalSold, quantity: $quantity, isFavorite: $isFavorite, thumbnails: $thumbnails, colors: $colors, brand: $brand, shop: $shop, description: $description)';
  }

  @override
  bool operator ==(covariant Product other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.shortDescription == shortDescription &&
        other.price == price &&
        other.discountPrice == discountPrice &&
        other.discountPercentage == discountPercentage &&
        other.rating == rating &&
        other.totalReviews == totalReviews &&
        other.totalSold == totalSold &&
        other.quantity == quantity &&
        other.isFavorite == isFavorite &&
        listEquals(other.thumbnails, thumbnails) &&
        listEquals(other.colors, colors) &&
        other.brand == brand &&
        other.shop == shop &&
        other.description == description;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        shortDescription.hashCode ^
        price.hashCode ^
        discountPrice.hashCode ^
        discountPercentage.hashCode ^
        rating.hashCode ^
        totalReviews.hashCode ^
        totalSold.hashCode ^
        quantity.hashCode ^
        isFavorite.hashCode ^
        thumbnails.hashCode ^
        colors.hashCode ^
        brand.hashCode ^
        shop.hashCode ^
        description.hashCode;
  }
}

class Thumbnail {
  final int id;
  final String thumbnail;
  Thumbnail({
    required this.id,
    required this.thumbnail,
  });

  Thumbnail copyWith({
    int? id,
    String? thumbnail,
  }) {
    return Thumbnail(
      id: id ?? this.id,
      thumbnail: thumbnail ?? this.thumbnail,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'thumbnail': thumbnail,
    };
  }

  factory Thumbnail.fromMap(Map<String, dynamic> map) {
    return Thumbnail(
      id: map['id'].toInt() as int,
      thumbnail: map['thumbnail'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Thumbnail.fromJson(String source) =>
      Thumbnail.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Thumbnail(id: $id, thumbnail: $thumbnail)';

  @override
  bool operator ==(covariant Thumbnail other) {
    if (identical(this, other)) return true;

    return other.id == id && other.thumbnail == thumbnail;
  }

  @override
  int get hashCode => id.hashCode ^ thumbnail.hashCode;
}

class Color {
  final int id;
  final String name;
  Color({
    required this.id,
    required this.name,
  });

  Color copyWith({
    int? id,
    String? name,
  }) {
    return Color(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
    };
  }

  factory Color.fromMap(Map<String, dynamic> map) {
    return Color(
      id: map['id'].toInt() as int,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Color.fromJson(String source) =>
      Color.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Color(id: $id, name: $name)';

  @override
  bool operator ==(covariant Color other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}

class SizeModel {
  SizeModel({
    required this.id,
    required this.name,
    required this.price,
  });
  late final int id;
  late final String name;
  late final double price;

  SizeModel.fromMap(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = double.parse(json['price'].toString());
  }

  Map<String, dynamic> toMap() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['price'] = price;
    return data;
  }
}

class ShopInfo {
  final int id;
  final String name;
  final String logo;
  final String estimatedDeliveryTime;
  final double deliveryCharge;
  ShopInfo({
    required this.id,
    required this.name,
    required this.logo,
    required this.estimatedDeliveryTime,
    required this.deliveryCharge,
  });

  ShopInfo copyWith({
    int? id,
    String? name,
    String? logo,
    String? estimatedDeliveryTime,
    double? deliveryCharge,
    String? deliveryChargeType,
  }) {
    return ShopInfo(
      id: id ?? this.id,
      name: name ?? this.name,
      logo: logo ?? this.logo,
      estimatedDeliveryTime:
          estimatedDeliveryTime ?? this.estimatedDeliveryTime,
      deliveryCharge: deliveryCharge ?? this.deliveryCharge,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'logo': logo,
      'estimated_delivery_time': estimatedDeliveryTime,
      'delivery_charge': deliveryCharge,
    };
  }

  factory ShopInfo.fromMap(Map<String, dynamic> map) {
    return ShopInfo(
      id: map['id'].toInt() as int,
      name: map['name'] as String,
      logo: map['logo'] as String,
      estimatedDeliveryTime: map['estimated_delivery_time'] as String,
      deliveryCharge: map['delivery_charge'].toDouble() as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory ShopInfo.fromJson(String source) =>
      ShopInfo.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Shop(id: $id, name: $name, logo: $logo, estimated_delivery_time: $estimatedDeliveryTime, delivery_charge: $deliveryCharge)';
  }

  @override
  bool operator ==(covariant ShopInfo other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.logo == logo &&
        other.estimatedDeliveryTime == estimatedDeliveryTime &&
        other.deliveryCharge == deliveryCharge;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        logo.hashCode ^
        estimatedDeliveryTime.hashCode ^
        deliveryCharge.hashCode;
  }
}

class RelatedProduct {
  final int id;
  final String name;
  final String thumbnail;
  final double price;
  final double discountPrice;
  final double discountPercentage;
  final double rating;
  final String totalReviews;
  final String totalSold;
  final int quantity;
  final bool isFavorite;
  final ShopInfo shop;
  RelatedProduct({
    required this.id,
    required this.name,
    required this.thumbnail,
    required this.price,
    required this.discountPrice,
    required this.discountPercentage,
    required this.rating,
    required this.totalReviews,
    required this.totalSold,
    required this.quantity,
    required this.isFavorite,
    required this.shop,
  });

  RelatedProduct copyWith({
    int? id,
    String? name,
    String? thumbnail,
    double? price,
    double? discountPrice,
    double? discountPercentage,
    double? rating,
    String? totalReviews,
    String? totalSold,
    int? quantity,
    bool? isFavorite,
    ShopInfo? shop,
  }) {
    return RelatedProduct(
      id: id ?? this.id,
      name: name ?? this.name,
      thumbnail: thumbnail ?? this.thumbnail,
      price: price ?? this.price,
      discountPrice: discountPrice ?? this.discountPrice,
      discountPercentage: discountPercentage ?? this.discountPercentage,
      rating: rating ?? this.rating,
      totalReviews: totalReviews ?? this.totalReviews,
      totalSold: totalSold ?? this.totalSold,
      quantity: quantity ?? this.quantity,
      isFavorite: isFavorite ?? this.isFavorite,
      shop: shop ?? this.shop,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'thumbnail': thumbnail,
      'price': price,
      'discountPrice': discountPrice,
      'discountPercentage': discountPercentage,
      'rating': rating,
      'totalReviews': totalReviews,
      'totalSold': totalSold,
      'quantity': quantity,
      'isFavorite': isFavorite,
      'shop': shop.toMap(),
    };
  }

  factory RelatedProduct.fromMap(Map<String, dynamic> map) {
    return RelatedProduct(
      id: map['id'].toInt() as int,
      name: map['name'] as String,
      thumbnail: map['thumbnail'] as String,
      price: map['price'].toDouble() as double,
      discountPrice: map['discount_price'].toDouble() as double,
      discountPercentage: map['discount_percentage'].toDouble() as double,
      rating: map['rating'].toDouble() as double,
      totalReviews: map['total_reviews'] as String,
      totalSold: map['total_sold'] as String,
      quantity: map['quantity'].toInt() as int,
      isFavorite: map['is_favorite'] as bool,
      shop: ShopInfo.fromMap(map['shop'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory RelatedProduct.fromJson(String source) =>
      RelatedProduct.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'RelatedProduct(id: $id, name: $name, thumbnail: $thumbnail, price: $price, discount_price: $discountPrice, discount_percentage: $discountPercentage, rating: $rating, total_reviews: $totalReviews, total_sold: $totalSold, quantity: $quantity, is_favorite: $isFavorite, shop: $shop)';
  }

  @override
  bool operator ==(covariant RelatedProduct other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.thumbnail == thumbnail &&
        other.price == price &&
        other.discountPrice == discountPrice &&
        other.discountPercentage == discountPercentage &&
        other.rating == rating &&
        other.totalReviews == totalReviews &&
        other.totalSold == totalSold &&
        other.quantity == quantity &&
        other.isFavorite == isFavorite &&
        other.shop == shop;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        thumbnail.hashCode ^
        price.hashCode ^
        discountPrice.hashCode ^
        discountPercentage.hashCode ^
        rating.hashCode ^
        totalReviews.hashCode ^
        totalSold.hashCode ^
        quantity.hashCode ^
        isFavorite.hashCode ^
        shop.hashCode;
  }
}
