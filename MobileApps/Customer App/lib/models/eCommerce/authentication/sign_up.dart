import 'dart:convert';

class SingUp {
  final String name;
  final String phone;
  final String password;
  SingUp({
    required this.name,
    required this.phone,
    required this.password,
  });

  SingUp copyWith({
    String? name,
    String? phone,
    String? password,
  }) {
    return SingUp(
      name: name ?? this.name,
      phone: phone ?? this.phone,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'phone': phone,
      'password': password,
    };
  }

  factory SingUp.fromMap(Map<String, dynamic> map) {
    return SingUp(
      name: map['name'] as String,
      phone: map['phone'] as String,
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SingUp.fromJson(String source) =>
      SingUp.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'SingUp(name: $name, phone: $phone, password: $password)';

  @override
  bool operator ==(covariant SingUp other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.phone == phone &&
        other.password == password;
  }

  @override
  int get hashCode => name.hashCode ^ phone.hashCode ^ password.hashCode;
}
