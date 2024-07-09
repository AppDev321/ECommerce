import 'package:razin_shop/models/eCommerce/address/add_address.dart';

class OrderDetails {
  OrderDetails({
    required this.message,
    required this.data,
  });
  late final String message;
  late final Data data;

  OrderDetails.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['message'] = message;
    data['data'] = data;
    return data;
  }
}

class Data {
  Data({
    required this.order,
  });
  late final Order order;

  Data.fromJson(Map<String, dynamic> json) {
    order = Order.fromJson(json['order']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['order'] = order.toJson();
    return data;
  }
}

class Order {
  Order({
    required this.id,
    required this.orderCode,
    required this.orderStatus,
    required this.createdAt,
    required this.paymentMethod,
    required this.paymentStatus,
    required this.totalAmount,
    required this.discount,
    required this.couponDiscount,
    required this.payableAmount,
    required this.quantity,
    required this.deliveryCharge,
    required this.shop,
    required this.products,
    this.invoiceUrl,
    required this.address,
  });
  late final int id;
  late final String orderCode;
  late final String orderStatus;
  late final String createdAt;
  late final String paymentMethod;
  late final String paymentStatus;
  late final double totalAmount;
  late final double discount;
  late final double couponDiscount;
  late final double payableAmount;
  late final int quantity;
  late final double deliveryCharge;
  late final Shop shop;
  late final List<Products> products;
  late final String? invoiceUrl;
  late final AddAddress address;

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderCode = json['order_code'];
    orderStatus = json['order_status'];
    createdAt = json['created_at'];
    paymentMethod = json['payment_method'];
    paymentStatus = json['payment_status'];
    totalAmount = json['total_amount'];
    discount = json['discount'];
    couponDiscount = json['coupon_discount'];
    payableAmount = json['payable_amount'];
    quantity = json['quantity'];
    deliveryCharge = json['delivery_charge'];
    shop = Shop.fromJson(json['shop']);
    products =
        List.from(json['products']).map((e) => Products.fromJson(e)).toList();
    invoiceUrl = json['invoice_url'];
    address = AddAddress.fromMap(json['address']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['order_code'] = orderCode;
    data['order_status'] = orderStatus;
    data['created_at'] = createdAt;
    data['payment_method'] = paymentMethod;
    data['payment_status'] = paymentStatus;
    data['total_amount'] = totalAmount;
    data['discount'] = discount;
    data['coupon_discount'] = couponDiscount;
    data['payable_amount'] = payableAmount;
    data['quantity'] = quantity;
    data['delivery_charge'] = deliveryCharge;
    data['shop'] = shop.toJson();
    data['products'] = products.map((e) => e.toJson()).toList();
    data['invoice_url'] = invoiceUrl;
    data['address'] = address.toJson();
    return data;
  }
}

class Shop {
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
  late final int id;
  late final String name;
  late final String logo;
  late final String banner;
  late final int totalProducts;
  late final int totalCategories;
  late final double rating;
  late final String shopStatus;
  late final String totalReviews;

  Shop.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    logo = json['logo'];
    banner = json['banner'];
    totalProducts = json['total_products'];
    totalCategories = json['total_categories'];
    rating = json['rating'];
    shopStatus = json['shop_status'];
    totalReviews = json['total_reviews'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['logo'] = logo;
    data['banner'] = banner;
    data['total_products'] = totalProducts;
    data['total_categories'] = totalCategories;
    data['rating'] = rating;
    data['shop_status'] = shopStatus;
    data['total_reviews'] = totalReviews;
    return data;
  }
}

class Products {
  Products({
    required this.id,
    required this.name,
    required this.brand,
    required this.thumbnail,
    required this.price,
    required this.orderQty,
    required this.color,
    required this.size,
    required this.discountPrice,
    required this.rating,
  });
  late final int id;
  late final String name;
  late final String? brand;
  late final String thumbnail;
  late final double price;
  late final int orderQty;
  late final String? color;
  late final String? size;
  late final double discountPrice;
  late final double? rating;

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    brand = json['brand'] as String?;
    thumbnail = json['thumbnail'];
    price = json['price'];
    orderQty = json['order_qty'];
    color = json['color'];
    size = json['size'];
    discountPrice = json['discount_price'];
    rating = json['rating'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['brand'] = brand;
    data['thumbnail'] = thumbnail;
    data['price'] = price;
    data['order_qty'] = orderQty;
    data['color'] = color;
    data['size'] = size;
    data['discount_price'] = discountPrice;
    data['rating'] = rating;
    return data;
  }
}
