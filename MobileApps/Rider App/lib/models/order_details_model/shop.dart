import 'dart:convert';

class Shop {
  String? name;
  String? logo;
  String? phone;
  String? address;

  Shop({this.name, this.logo, this.phone, this.address});

  factory Shop.fromMap(Map<String, dynamic> data) => Shop(
        name: data['name'] as String?,
        logo: data['logo'] as String?,
        phone: data['phone'] as String?,
        address: data['address'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'name': name,
        'logo': logo,
        'phone': phone,
        'address': address,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Shop].
  factory Shop.fromJson(String data) {
    return Shop.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Shop] to a JSON string.
  String toJson() => json.encode(toMap());
}
