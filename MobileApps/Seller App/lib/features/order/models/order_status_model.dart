import 'dart:convert';

class OrderStatusModel {
  final String name;
  final int value;
  final String status;
  OrderStatusModel({
    required this.name,
    required this.value,
    required this.status,
  });

  OrderStatusModel copyWith({
    String? name,
    int? value,
    String? status,
  }) {
    return OrderStatusModel(
      name: name ?? this.name,
      value: value ?? this.value,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'value': value,
      'status': status,
    };
  }

  factory OrderStatusModel.fromMap(Map<String, dynamic> map) {
    return OrderStatusModel(
      name: map['name'] as String,
      value: map['value'] as int,
      status: map['status'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderStatusModel.fromJson(String source) =>
      OrderStatusModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
