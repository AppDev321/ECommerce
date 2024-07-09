import 'dart:convert';

import 'package:hive/hive.dart';

class HiveCartModel {
  int shopId;
  String shopLogo;
  String shopName;
  double deliveryCharge;
  double review;
  int productId;
  String productLogo;
  String title;
  double price;
  double currentPrice;
  double discountPrice;
  String color;
  String size;
  String unit;
  int productsQTY;
  HiveCartModel({
    required this.shopId,
    required this.shopLogo,
    required this.deliveryCharge,
    required this.shopName,
    required this.review,
    required this.productId,
    required this.productLogo,
    required this.title,
    required this.price,
    required this.currentPrice,
    required this.discountPrice,
    required this.color,
    required this.productsQTY,
    required this.size,
    required this.unit,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'shopId': shopId,
      'shopLogo': shopLogo,
      'deliveryCharge': deliveryCharge,
      'shopName': shopName,
      'review': review,
      'productId': productId,
      'productLogo': productLogo,
      'title': title,
      'price': price,
      'currentPrice': currentPrice,
      'oldPrice': discountPrice,
      'color': color,
      'size': size,
      'unit': unit,
      'productsQTY': productsQTY,
    };
  }

  factory HiveCartModel.fromMap(Map<dynamic, dynamic> map) {
    return HiveCartModel(
      shopId: map['shopId'] as int,
      shopLogo: map['shopLogo'] as String,
      deliveryCharge: map['deliveryCharge'],
      shopName: map['shopName'] as String,
      review: map['review'] as double,
      productId: map['productId'] as int,
      productLogo: map['productLogo'] as String,
      title: map['title'] as String,
      price: map['price'] as double,
      currentPrice: map['currentPrice'] as double,
      discountPrice: map['oldPrice'] as double,
      color: map['color'] as String,
      size: map['size'] as String,
      unit: map['unit'] as String,
      productsQTY: map['productsQTY'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory HiveCartModel.fromJson(String source) =>
      HiveCartModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class HiveCartModelAdapter extends TypeAdapter<HiveCartModel> {
  @override
  final typeId = 0;

  @override
  HiveCartModel read(BinaryReader reader) {
    return HiveCartModel.fromMap(reader.readMap());
  }

  @override
  void write(BinaryWriter writer, HiveCartModel obj) {
    writer.writeMap(obj.toMap());
  }
}
