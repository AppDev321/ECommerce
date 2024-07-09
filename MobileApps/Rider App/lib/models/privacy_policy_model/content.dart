import 'dart:convert';

class Content {
  String? title;
  String? description;

  Content({this.title, this.description});

  factory Content.fromMap(Map<String, dynamic> data) => Content(
        title: data['title'] as String?,
        description: data['description'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'title': title,
        'description': description,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Content].
  factory Content.fromJson(String data) {
    return Content.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Content] to a JSON string.
  String toJson() => json.encode(toMap());
}
