import 'dart:convert';

import 'package:razin_shop/models/eCommerce/product/product_details.dart';

class Product {
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
  final List<Color> colors;
  final List<SizeModel> productSizeList;
  final String? brand;
  final Shop shop;
  Product({
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
    required this.colors,
    required this.productSizeList,
    required this.isFavorite,
    required this.brand,
    required this.shop,
  });

  Product copyWith({
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
    List<Color>? colors,
    List<SizeModel>? productSizeList,
    bool? isFavorite,
    String? brand,
    Shop? shop,
  }) {
    return Product(
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
      colors: colors ?? this.colors,
      productSizeList: productSizeList ?? this.productSizeList,
      isFavorite: isFavorite ?? this.isFavorite,
      brand: brand ?? this.brand,
      shop: shop ?? this.shop,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'thumbnail': thumbnail,
      'price': price,
      'discount_price': discountPrice,
      'discount_percentage': discountPercentage,
      'rating': rating,
      'total_reviews': totalReviews,
      'total_sold': totalSold,
      'quantity': quantity,
      'is_favorite': isFavorite,
      'shop': shop.toMap(),
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'].toInt() as int,
      name: map['name'] as String,
      thumbnail: map['thumbnail'] as String,
      price: map['price'].toDouble() as double,
      discountPrice: map['discount_price'].toDouble() as double,
      discountPercentage: map['discount_percentage'].toDouble() as double,
      rating: map['rating'] as double,
      totalReviews: map['total_reviews'] as String,
      totalSold: map['total_sold'] as String,
      quantity: map['quantity'].toInt() as int,
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
      isFavorite: map['is_favorite'] as bool,
      brand: map['brand'] ?? '',
      shop: Shop.fromMap(map['shop'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Product(id: $id, name: $name, thumbnail: $thumbnail, price: $price, discountPrice: $discountPrice, discountPercentage: $discountPercentage, rating: $rating, totalReviews: $totalReviews, totalSold: $totalSold, quantity: $quantity, isFavorite: $isFavorite, shop: $shop)';
  }

  @override
  bool operator ==(covariant Product other) {
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

class Shop {
  final int id;
  final String name;
  final String logo;
  final double rating;
  final double deliveryCharge;
  final String deliveryChargeType;
  Shop({
    required this.id,
    required this.name,
    required this.logo,
    required this.rating,
    required this.deliveryCharge,
    required this.deliveryChargeType,
  });

  Shop copyWith({
    int? id,
    String? name,
    String? logo,
    double? rating,
    double? deliveryCharge,
    String? deliveryChargeType,
  }) {
    return Shop(
      id: id ?? this.id,
      name: name ?? this.name,
      logo: logo ?? this.logo,
      rating: rating ?? this.rating,
      deliveryCharge: deliveryCharge ?? this.deliveryCharge,
      deliveryChargeType: deliveryChargeType ?? this.deliveryChargeType,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'logo': logo,
      'rating': rating,
      'delivery_charge': deliveryCharge,
      'delivery_charge_type': deliveryChargeType,
    };
  }

  factory Shop.fromMap(Map<String, dynamic> map) {
    return Shop(
      id: map['id'].toInt() as int,
      name: map['name'] as String,
      logo: map['logo'] as String,
      rating: map['rating'].toDouble() as double,
      deliveryCharge: map['delivery_charge'].toDouble() as double,
      deliveryChargeType: map['estimated_delivery_time'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Shop.fromJson(String source) =>
      Shop.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Shop(id: $id, name: $name, logo: $logo, rating: $rating, deliveryCharge: $deliveryCharge, deliveryChargeType: $deliveryChargeType)';
  }

  @override
  bool operator ==(covariant Shop other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.logo == logo &&
        other.rating == rating &&
        other.deliveryCharge == deliveryCharge &&
        other.deliveryChargeType == deliveryChargeType;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        logo.hashCode ^
        rating.hashCode ^
        deliveryCharge.hashCode ^
        deliveryChargeType.hashCode;
  }
}
