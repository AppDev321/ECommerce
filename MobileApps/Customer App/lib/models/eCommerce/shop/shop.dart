import 'dart:convert';

class Shop {
  final int id;
  final String name;
  final String logo;
  final String banner;
  final int totalProducts;
  final int totalCategories;
  final double rating;
  final String shopStatus;
  final String totalReviews;
  Shop({
    required this.id,
    required this.name,
    required this.logo,
    required this.banner,
    required this.totalProducts,
    required this.totalCategories,
    required this.rating,
    required this.shopStatus,
    required this.totalReviews,
  });

  Shop copyWith({
    int? id,
    String? name,
    String? logo,
    String? banner,
    int? totalProducts,
    int? totalCategories,
    double? rating,
    String? shopStatus,
    String? totalReviews,
  }) {
    return Shop(
      id: id ?? this.id,
      name: name ?? this.name,
      logo: logo ?? this.logo,
      banner: banner ?? this.banner,
      totalProducts: totalProducts ?? this.totalProducts,
      totalCategories: totalCategories ?? this.totalCategories,
      rating: rating ?? this.rating,
      shopStatus: shopStatus ?? this.shopStatus,
      totalReviews: totalReviews ?? this.totalReviews,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'logo': logo,
      'banner': banner,
      'totalProducts': totalProducts,
      'totalCategories': totalCategories,
      'rating': rating,
      'shopStatus': shopStatus,
      'totalReviews': totalReviews,
    };
  }

  factory Shop.fromMap(Map<String, dynamic> map) {
    return Shop(
      id: map['id'].toInt() as int,
      name: map['name'] as String,
      logo: map['logo'] as String,
      banner: map['banner'] as String,
      totalProducts: map['total_products'].toInt() as int,
      totalCategories: map['total_categories'].toInt() as int,
      rating: map['rating'].toDouble() as double,
      shopStatus: map['shop_status'] as String,
      totalReviews: map['total_reviews'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Shop.fromJson(String source) =>
      Shop.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Shop(id: $id, name: $name, logo: $logo, banner: $banner, totalProducts: $totalProducts, totalCategories: $totalCategories, rating: $rating, shopStatus: $shopStatus, totalReviews: $totalReviews)';
  }

  @override
  bool operator ==(covariant Shop other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.logo == logo &&
        other.banner == banner &&
        other.totalProducts == totalProducts &&
        other.totalCategories == totalCategories &&
        other.rating == rating &&
        other.shopStatus == shopStatus &&
        other.totalReviews == totalReviews;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        logo.hashCode ^
        banner.hashCode ^
        totalProducts.hashCode ^
        totalCategories.hashCode ^
        rating.hashCode ^
        shopStatus.hashCode ^
        totalReviews.hashCode;
  }
}
