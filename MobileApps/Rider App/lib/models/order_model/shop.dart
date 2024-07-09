import 'dart:convert';

class Shop {
  String? name;
  String? phone;
  String? address;
  String? latitude;
  String? longitude;

  Shop({
    this.name,
    this.phone,
    this.address,
    this.latitude,
    this.longitude,
  });

  factory Shop.fromMap(Map<String, dynamic> data) => Shop(
        name: data['name'] as String?,
        phone: data['phone'] as String?,
        address: data['address'] as String?,
        latitude: data['latitude'] as String?,
        longitude: data['longitude'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'name': name,
        'phone': phone,
        'address': address,
        'latitude': latitude,
        'longitude': longitude,
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
