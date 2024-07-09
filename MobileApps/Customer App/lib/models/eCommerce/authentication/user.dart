import 'dart:convert';

class User {
  final int? id;
  final String? name;
  final String? phone;
  final String? email;
  final bool? isActive;
  final String? profilePhoto;
  final String? gender;
  final String? dateOfBirth;
  User({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.isActive,
    required this.profilePhoto,
    required this.gender,
    required this.dateOfBirth,
  });

  User copyWith({
    int? id,
    String? name,
    String? phone,
    String? email,
    bool? isActive,
    String? profilePhoto,
    String? gender,
    String? dateOfBirth,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      isActive: isActive ?? this.isActive,
      profilePhoto: profilePhoto ?? this.profilePhoto,
      gender: gender ?? this.gender,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      if (id != null) 'id': id,
      'name': name,
      'phone': phone,
      'email': email,
      'is_active': isActive,
      'profile_photo': profilePhoto,
      'gender': gender,
      'date_of_birth': dateOfBirth,
    }..removeWhere((key, value) => value == null);
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id']?.toInt(),
      name: map['name'] as String?,
      phone: map['phone'] as String?,
      email: map['email'] as String?,
      isActive: map['is_active'] as bool?,
      profilePhoto: map['profile_photo'] as String?,
      gender: map['gender'] as String?,
      dateOfBirth: map['date_of_birth'] as String?,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(id: $id, name: $name, phone: $phone, email: $email, isActive: $isActive, profilePhoto: $profilePhoto, gender: $gender, dateOfBirth: $dateOfBirth)';
  }

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.phone == phone &&
        other.email == email &&
        other.isActive == isActive &&
        other.profilePhoto == profilePhoto &&
        other.gender == gender &&
        other.dateOfBirth == dateOfBirth;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        phone.hashCode ^
        email.hashCode ^
        isActive.hashCode ^
        profilePhoto.hashCode ^
        gender.hashCode ^
        dateOfBirth.hashCode;
  }
}
