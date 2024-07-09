import 'dart:convert';

import 'shop.dart';
import 'user.dart';

class Order {
  int? id;
  String? orderCode;
  double? amount;
  String? orderStatus;
  String? paymentStatus;
  String? paymentMethod;
  String? estimatedDeliveryDate;
  dynamic pickupDate;
  User? user;
  Shop? shop;

  Order({
    this.id,
    this.orderCode,
    this.amount,
    this.orderStatus,
    this.paymentStatus,
    this.paymentMethod,
    this.estimatedDeliveryDate,
    this.pickupDate,
    this.user,
    this.shop,
  });

  factory Order.fromMap(Map<String, dynamic> data) => Order(
        id: data['id'] as int?,
        orderCode: data['order_code'] as String?,
        amount: (data['amount'] as num?)?.toDouble(),
        orderStatus: data['order_status'] as String?,
        paymentStatus: data['payment_status'] as String?,
        paymentMethod: data['payment_method'] as String?,
        estimatedDeliveryDate: data['estimated_delivery_date'] as String?,
        pickupDate: data['pickup_date'] as dynamic,
        user: data['user'] == null
            ? null
            : User.fromMap(data['user'] as Map<String, dynamic>),
        shop: data['shop'] == null
            ? null
            : Shop.fromMap(data['shop'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'order_code': orderCode,
        'amount': amount,
        'order_status': orderStatus,
        'payment_status': paymentStatus,
        'payment_method': paymentMethod,
        'estimated_delivery_date': estimatedDeliveryDate,
        'pickup_date': pickupDate,
        'user': user?.toMap(),
        'shop': shop?.toMap(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Order].
  factory Order.fromJson(String data) {
    return Order.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Order] to a JSON string.
  String toJson() => json.encode(toMap());
}
