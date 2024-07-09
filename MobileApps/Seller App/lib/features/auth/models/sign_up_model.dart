import 'dart:convert';

class SignUpModel {
  final String firstName;
  final String lastName;
  final String phone;
  final String email;
  final String gender;
  final String dateOfBirth;
  final String shopName;
  final String password;
  final String confirmPassword;
  SignUpModel({
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.email,
    required this.gender,
    required this.dateOfBirth,
    required this.shopName,
    required this.password,
    required this.confirmPassword,
  });

  SignUpModel copyWith({
    String? firstName,
    String? lastName,
    String? phone,
    String? email,
    String? gender,
    String? dateOfBirth,
    String? shopName,
    String? password,
    String? confirmPassword,
  }) {
    return SignUpModel(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      gender: gender ?? this.gender,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      shopName: shopName ?? this.shopName,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'first_name': firstName,
      'last_name': lastName,
      'phone': phone,
      'email': email,
      'gender': gender,
      'date_of_birth': dateOfBirth,
      'shop_name': shopName,
      'password': password,
      'password_confirmation': confirmPassword,
    };
  }

  factory SignUpModel.fromMap(Map<String, dynamic> map) {
    return SignUpModel(
      firstName: map['first_name'] as String,
      lastName: map['last_name'] as String,
      phone: map['phone'] as String,
      email: map['email'] as String,
      gender: map['gender'] as String,
      dateOfBirth: map['date_of_birth'] as String,
      shopName: map['shop_name'] as String,
      password: map['password'] as String,
      confirmPassword: map['password_confirmation'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SignUpModel.fromJson(String source) =>
      SignUpModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
