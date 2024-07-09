class CartItem {
  CartItem({
    required this.shopId,
    required this.shopName,
    required this.shopLogo,
    required this.shopRating,
    required this.cartProduct,
  });
  late final int shopId;
  late final String shopName;
  late final String shopLogo;
  late final String shopRating;
  late final List<CartProduct> cartProduct;

  CartItem.fromJson(Map<String, dynamic> json) {
    shopId = json['shop_id'];
    shopName = json['shop_name'];
    shopLogo = json['shop_logo'];
    shopRating = json['shop_rating'].toString();
    cartProduct = (json['products'] as List<dynamic>)
        .map((product) => CartProduct.fromJson(product))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['shop_id'] = shopId;
    data['shop_name'] = shopName;
    data['shop_logo'] = shopLogo;
    data['shop_rating'] = shopRating;
    data['products'] = cartProduct.map((product) => product.toJson()).toList();
    return data;
  }
}

class CartProduct {
  CartProduct({
    required this.id,
    required this.quantity,
    required this.name,
    required this.thumbnail,
    required this.brand,
    required this.price,
    required this.discountPrice,
    required this.discountPercentage,
    required this.rating,
    required this.totalReviews,
    required this.totalSold,
    required this.color,
    required this.size,
    required this.unit,
  });
  late final int id;
  late final int quantity;
  late final String name;
  late final String thumbnail;
  late final String? brand;
  late final double price;
  late final double discountPrice;
  late final double discountPercentage;
  late final double rating;
  late final String totalReviews;
  late final String totalSold;
  late final String? color;
  late final String? size;
  late final String? unit;

  CartProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    name = json['name'];
    thumbnail = json['thumbnail'];
    brand = json['brand'];
    price = json['price'];
    discountPrice = json['discount_price'];
    discountPercentage = json['discount_percentage'];
    rating = json['rating'];
    totalReviews = json['total_reviews'];
    totalSold = json['total_sold'];
    color = json['color'];
    size = json['size'];
    unit = json['unit'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['quantity'] = quantity;
    data['name'] = name;
    data['thumbnail'] = thumbnail;
    data['brand'] = brand;
    data['price'] = price;
    data['discount_price'] = discountPrice;
    data['discount_percentage'] = discountPercentage;
    data['rating'] = rating;
    data['total_reviews'] = totalReviews;
    data['total_sold'] = totalSold;
    data['color'] = color;
    data['size'] = size;
    data['unit'] = unit;
    return data;
  }
}
