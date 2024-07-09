import 'dart:convert';

class OrderPlaceModel {
  final int? addressId;
  final String? couponId;
  final String? note;
  final String paymentMethod;
  List<int> shopIds;
  OrderPlaceModel({
    required this.addressId,
    required this.couponId,
    required this.note,
    required this.paymentMethod,
    required this.shopIds,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'address_id': addressId,
      'coupon_code': couponId,
      'note': note,
      'payment_method': paymentMethod,
      'shop_ids': shopIds,
    };
  }

  factory OrderPlaceModel.fromMap(Map<String, dynamic> map) {
    return OrderPlaceModel(
      addressId: map['address_id'] != null ? map['address_id'] as int : null,
      couponId:
          map['coupon_code'] != null ? map['coupon_code'] as String : null,
      note: map['note'] != null ? map['note'] as String : null,
      paymentMethod: map['payment_method'] as String,
      shopIds: List<int>.from(
        (map['shop_ids'] as List<int>),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderPlaceModel.fromJson(String source) =>
      OrderPlaceModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
