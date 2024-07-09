import 'dart:convert';

import 'data.dart';

class PrivacyPolicyModel {
  String? message;
  Data? data;

  PrivacyPolicyModel({this.message, this.data});

  factory PrivacyPolicyModel.fromMap(Map<String, dynamic> data) {
    return PrivacyPolicyModel(
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
  /// Parses the string and returns the resulting Json object as [PrivacyPolicyModel].
  factory PrivacyPolicyModel.fromJson(String data) {
    return PrivacyPolicyModel.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [PrivacyPolicyModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
