import 'dart:convert';

class VoucherApplyModel {
  final String? couponCode;
  final List<CouponApplyProduct> products;

  VoucherApplyModel(
    this.couponCode,
    this.products,
  );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'coupon_code': couponCode,
      'products': products.map((x) => x.toMap()).toList(),
    };
  }

  factory VoucherApplyModel.fromMap(Map<String, dynamic> map) {
    return VoucherApplyModel(
      map['couponCode'] != null ? map['couponCode'] as String : null,
      List<CouponApplyProduct>.from(
        (map['products'] as List<int>).map<CouponApplyProduct>(
          (x) => CouponApplyProduct.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory VoucherApplyModel.fromJson(String source) =>
      VoucherApplyModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class CouponApplyProduct {
  final int id;
  final int quantity;
  final int shopId;

  CouponApplyProduct(
      {required this.id, required this.quantity, required this.shopId});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'quantity': quantity,
      'shop_id': shopId,
    };
  }

  factory CouponApplyProduct.fromMap(Map<String, dynamic> map) {
    return CouponApplyProduct(
      id: map['id'] as int,
      quantity: map['quantity'] as int,
      shopId: map['shop_id'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory CouponApplyProduct.fromJson(String source) =>
      CouponApplyProduct.fromMap(json.decode(source) as Map<String, dynamic>);
}
