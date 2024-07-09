import 'dart:convert';

class ProductFilterModel {
  final int? page;
  final int? perPage;
  final String? search;
  final int? shopId;
  final int? productId;
  final int? categoryId;
  final double? rating;
  final int? minPrice;
  final int? maxPrice;
  final String? sortType;

  ProductFilterModel({
    this.page,
    this.perPage,
    this.search,
    this.shopId,
    this.productId,
    this.categoryId,
    this.rating,
    this.minPrice,
    this.maxPrice,
    this.sortType,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'page': page,
      'per_page': perPage,
      'search': search,
      'shop_id': shopId,
      'product_id': productId,
      'category_id': categoryId,
      'rating': rating,
      'min_price': minPrice,
      'max_price': maxPrice,
      'sort_type': sortType,
    };
  }

  factory ProductFilterModel.fromMap(Map<String, dynamic> map) {
    return ProductFilterModel(
      page: map['page'] as int?,
      perPage: map['per_page'] as int?,
      search: map['search'] as String?,
      shopId: map['shop_id'] as int?,
      productId: map['product_id'] as int?,
      categoryId: map['category_id'] as int?,
      rating: map['rating'] as double?,
      minPrice: map['min_price'] as int?,
      maxPrice: map['max_price'] as int?,
      sortType: map['sort_type'] as String?,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductFilterModel.fromJson(String source) =>
      ProductFilterModel.fromMap(json.decode(source) as Map<String, dynamic>);

  ProductFilterModel copyWith({
    int? page,
    int? perPage,
    String? search,
    int? shopId,
    int? productId,
    int? categoryId,
    double? rating,
    int? minPrice,
    int? maxPrice,
    String? sortType,
  }) {
    return ProductFilterModel(
      page: page ?? this.page,
      perPage: perPage ?? this.perPage,
      search: search ?? this.search,
      shopId: shopId ?? this.shopId,
      productId: productId ?? this.productId,
      categoryId: categoryId ?? this.categoryId,
      rating: rating ?? this.rating,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
      sortType: sortType ?? this.sortType,
    );
  }
}
