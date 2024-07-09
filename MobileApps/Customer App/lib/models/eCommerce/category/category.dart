import 'dart:convert';

class Category {
  final int id;
  final String name;
  final String thumbnail;
  Category({
    required this.id,
    required this.name,
    required this.thumbnail,
  });

  Category copyWith({
    int? id,
    String? name,
    String? thumbnail,
  }) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
      thumbnail: thumbnail ?? this.thumbnail,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'thumbnail': thumbnail,
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'].toInt() as int,
      name: map['name'] as String,
      thumbnail: map['thumbnail'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Category.fromJson(String source) =>
      Category.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Category(id: $id, name: $name, thumbnail: $thumbnail)';

  @override
  bool operator ==(covariant Category other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name && other.thumbnail == thumbnail;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ thumbnail.hashCode;
}
