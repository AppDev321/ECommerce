import 'dart:convert';

import 'address.dart';

class User {
  String? name;
  String? phone;
  String? profilePhoto;
  Address? address;

  User({this.name, this.phone, this.profilePhoto, this.address});

  factory User.fromMap(Map<String, dynamic> data) => User(
        name: data['name'] as String?,
        phone: data['phone'] as String?,
        profilePhoto: data['profile_photo'] as String?,
        address: data['address'] == null
            ? null
            : Address.fromMap(data['address'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toMap() => {
        'name': name,
        'phone': phone,
        'profile_photo': profilePhoto,
        'address': address?.toMap(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [User].
  factory User.fromJson(String data) {
    return User.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [User] to a JSON string.
  String toJson() => json.encode(toMap());
}
