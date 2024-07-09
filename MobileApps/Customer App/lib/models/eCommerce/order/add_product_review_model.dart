// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AddProductReviewModel {
  final int orderId;
  final int productId;
  final double rating;
  final String message;
  AddProductReviewModel({
    required this.orderId,
    required this.productId,
    required this.rating,
    required this.message,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'order_id': orderId,
      'product_id': productId,
      'rating': rating,
      'description': message,
    };
  }

  factory AddProductReviewModel.fromMap(Map<String, dynamic> map) {
    return AddProductReviewModel(
      orderId: map['orderId'] as int,
      productId: map['productId'] as int,
      rating: map['rating'] as double,
      message: map['message'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AddProductReviewModel.fromJson(String source) =>
      AddProductReviewModel.fromMap(
          json.decode(source) as Map<String, dynamic>);
}
