import 'dart:convert';

import 'order.dart';

class Data {
  int? toDoOrder;
  int? completedOrder;
  int? total;
  List<Order>? orders;

  Data({this.toDoOrder, this.completedOrder, this.total, this.orders});

  factory Data.fromMap(Map<String, dynamic> data) => Data(
        toDoOrder: data['to_do_order'] as int?,
        completedOrder: data['completed_order'] as int?,
        total: data['total'] as int?,
        orders: (data['orders'] as List<dynamic>?)
            ?.map((e) => Order.fromMap(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toMap() => {
        'to_do_order': toDoOrder,
        'completed_order': completedOrder,
        'total': total,
        'orders': orders?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Data].
  factory Data.fromJson(String data) {
    return Data.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Data] to a JSON string.
  String toJson() => json.encode(toMap());
}
