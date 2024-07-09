import 'dart:convert';

class Address {
  int? id;
  String? name;
  String? phone;
  String? area;
  String? flatNo;
  String? addressType;
  String? addressLine;
  String? addressLine2;
  String? postCode;
  bool? isDefault;

  Address({
    this.id,
    this.name,
    this.phone,
    this.area,
    this.flatNo,
    this.addressType,
    this.addressLine,
    this.addressLine2,
    this.postCode,
    this.isDefault,
  });

  factory Address.fromMap(Map<String, dynamic> data) => Address(
        id: data['id'] as int?,
        name: data['name'] as String?,
        phone: data['phone'] as String?,
        area: data['area'] as String?,
        flatNo: data['flat_no'] as String?,
        addressType: data['address_type'] as String?,
        addressLine: data['address_line'] as String?,
        addressLine2: data['address_line2'] as String?,
        postCode: data['post_code'] as String?,
        isDefault: data['is_default'] as bool?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'phone': phone,
        'area': area,
        'flat_no': flatNo,
        'address_type': addressType,
        'address_line': addressLine,
        'address_line2': addressLine2,
        'post_code': postCode,
        'is_default': isDefault,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Address].
  factory Address.fromJson(String data) {
    return Address.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Address] to a JSON string.
  String toJson() => json.encode(toMap());
}
