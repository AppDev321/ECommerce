import 'dart:convert';

import 'data.dart';

class OrderDetailsModel {
  String? message;
  Data? data;

  OrderDetailsModel({this.message, this.data});

  factory OrderDetailsModel.fromMap(Map<String, dynamic> data) {
    return OrderDetailsModel(
      message: data['message'] as String?,
      data: data['data'] == null
          ? null
          : Data.fromMap(data['data'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toMap() => {
        'message': message,
        'data': data?.toMap(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [OrderDetailsModel].
  factory OrderDetailsModel.fromJson(String data) {
    return OrderDetailsModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [OrderDetailsModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
