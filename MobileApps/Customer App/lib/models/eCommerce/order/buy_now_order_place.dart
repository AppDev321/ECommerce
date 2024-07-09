import 'dart:convert';

class BuyNowOrderPlace {
  final int productId;
  final String? couponCode;
  final int quantity;
  final int addressId;
  final String? note;
  final String paymentMethod;
  final String? color;
  final String? size;
  BuyNowOrderPlace({
    required this.productId,
    this.couponCode,
    required this.quantity,
    required this.addressId,
    this.note,
    required this.paymentMethod,
    this.color,
    this.size,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'product_id': productId,
      'coupon_code': couponCode,
      'quantity': quantity,
      'address_id': addressId,
      'note': note,
      'payment_method': paymentMethod,
      'color': color,
      'size': size,
    };
  }

  factory BuyNowOrderPlace.fromMap(Map<String, dynamic> map) {
    return BuyNowOrderPlace(
      productId: map['productId'] as int,
      couponCode:
          map['couponCode'] != null ? map['couponCode'] as String : null,
      quantity: map['quantity'] as int,
      addressId: map['addressId'] as int,
      note: map['note'] != null ? map['note'] as String : null,
      paymentMethod: map['paymentMethod'] as String,
      color: map['color'] != null ? map['color'] as String : null,
      size: map['size'] != null ? map['size'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory BuyNowOrderPlace.fromJson(String source) =>
      BuyNowOrderPlace.fromMap(json.decode(source) as Map<String, dynamic>);
}
