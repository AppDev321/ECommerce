import 'dart:convert';

import 'package:flutter/foundation.dart';

class ShopDetails {
  final int id;
  final String name;
  final String logo;
  final String banner;
  final String? description;
  final int totalProducts;
  final double rating;
  final String shopStatus;
  final List<Banner> banners;
  ShopDetails({
    required this.id,
    required this.name,
    required this.logo,
    required this.banner,
    required this.description,
    required this.totalProducts,
    required this.rating,
    required this.shopStatus,
    required this.banners,
  });

  ShopDetails copyWith({
    int? id,
    String? name,
    String? logo,
    String? banner,
    String? description,
    int? totalProducts,
    double? rating,
    String? shopStatus,
    List<Banner>? banners,
  }) {
    return ShopDetails(
      id: id ?? this.id,
      name: name ?? this.name,
      logo: logo ?? this.logo,
      banner: banner ?? this.banner,
      description: description ?? this.description,
      totalProducts: totalProducts ?? this.totalProducts,
      rating: rating ?? this.rating,
      shopStatus: shopStatus ?? this.shopStatus,
      banners: banners ?? this.banners,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'logo': logo,
      'banner': banner,
      'description': description,
      'totalProducts': totalProducts,
      'rating': rating,
      'shopStatus': shopStatus,
      'banners': banners.map((x) => x.toMap()).toList(),
    };
  }

  factory ShopDetails.fromMap(Map<String, dynamic> map) {
    return ShopDetails(
      id: map['id'].toInt() as int,
      name: map['name'] as String,
      logo: map['logo'] as String,
      banner: map['banner'] as String,
      description: map['description'] as String?,
      totalProducts: map['total_products'].toInt() as int,
      rating: map['rating'].toDouble() as double,
      shopStatus: map['shop_status'] as String,
      banners: List<Banner>.from(
        (map['banners'] as List<dynamic>).map<Banner>(
          (x) => Banner.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory ShopDetails.fromJson(String source) =>
      ShopDetails.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ShopDetails(id: $id, name: $name, logo: $logo, banner: $banner, description: $description, totalProducts: $totalProducts, rating: $rating, shopStatus: $shopStatus, banners: $banners)';
  }

  @override
  bool operator ==(covariant ShopDetails other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.logo == logo &&
        other.banner == banner &&
        other.description == description &&
        other.totalProducts == totalProducts &&
        other.rating == rating &&
        other.shopStatus == shopStatus &&
        listEquals(other.banners, banners);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        logo.hashCode ^
        banner.hashCode ^
        description.hashCode ^
        totalProducts.hashCode ^
        rating.hashCode ^
        shopStatus.hashCode ^
        banners.hashCode;
  }
}

class Banner {
  final int id;
  final String? title;
  final String thumbnail;
  Banner({
    required this.id,
    required this.title,
    required this.thumbnail,
  });

  Banner copyWith({
    int? id,
    String? title,
    String? thumbnail,
  }) {
    return Banner(
      id: id ?? this.id,
      title: title ?? this.title,
      thumbnail: thumbnail ?? this.thumbnail,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'thumbnail': thumbnail,
    };
  }

  factory Banner.fromMap(Map<String, dynamic> map) {
    return Banner(
      id: map['id'].toInt() as int,
      title: map['title'] ?? '',
      thumbnail: map['thumbnail'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Banner.fromJson(String source) =>
      Banner.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Banner(id: $id, title: $title, thumbnail: $thumbnail)';

  @override
  bool operator ==(covariant Banner other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.thumbnail == thumbnail;
  }

  @override
  int get hashCode => id.hashCode ^ title.hashCode ^ thumbnail.hashCode;
}
