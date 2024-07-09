import 'dart:convert';

import 'content.dart';

class Data {
  Content? content;

  Data({this.content});

  factory Data.fromMap(Map<String, dynamic> data) => Data(
        content: data['content'] == null
            ? null
            : Content.fromMap(data['content'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toMap() => {
        'content': content?.toMap(),
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
