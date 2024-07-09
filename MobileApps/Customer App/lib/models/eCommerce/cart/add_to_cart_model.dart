import 'dart:convert';

class AddToCartModel {
  final int productId;
  final int quantity;
  final String? size;
  final String? color;
  final String? unit;
  AddToCartModel({
    required this.productId,
    required this.quantity,
    this.size,
    this.color,
    this.unit,
  });

  AddToCartModel copyWith({
    int? productId,
    int? quantity,
    String? size,
    String? color,
    String? unit,
  }) {
    return AddToCartModel(
      productId: productId ?? this.productId,
      quantity: quantity ?? this.quantity,
      size: size ?? this.size,
      color: color ?? this.color,
      unit: unit ?? this.unit,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'product_id': productId,
      'quantity': quantity,
      'size': size,
      'color': color,
      'unit': unit,
    };
  }

  factory AddToCartModel.fromMap(Map<String, dynamic> map) {
    return AddToCartModel(
      productId: map['productId'] as int,
      quantity: map['quantity'] as int,
      size: map['size'] != null ? map['size'] as String : null,
      color: map['color'] != null ? map['color'] as String : null,
      unit: map['unit'] != null ? map['unit'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AddToCartModel.fromJson(String source) =>
      AddToCartModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
