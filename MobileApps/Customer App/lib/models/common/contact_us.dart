import 'dart:convert';

class ContactUsModel {
  final String message;
  final Data data;
  ContactUsModel({
    required this.message,
    required this.data,
  });

  ContactUsModel copyWith({
    String? message,
    Data? data,
  }) {
    return ContactUsModel(
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': message,
      'data': data.toMap(),
    };
  }

  factory ContactUsModel.fromMap(Map<String, dynamic> map) {
    return ContactUsModel(
      message: map['message'] as String,
      data: Data.fromMap(map['data'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory ContactUsModel.fromJson(String source) =>
      ContactUsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ContactUsModel(message: $message, data: $data)';

  @override
  bool operator ==(covariant ContactUsModel other) {
    if (identical(this, other)) return true;

    return other.message == message && other.data == data;
  }

  @override
  int get hashCode => message.hashCode ^ data.hashCode;
}

class Data {
  final String phone;
  final String email;
  final String whatsapp;
  final String messenger;
  Data({
    required this.phone,
    required this.email,
    required this.whatsapp,
    required this.messenger,
  });

  Data copyWith({
    String? phone,
    String? email,
    String? whatsapp,
    String? messenger,
  }) {
    return Data(
      phone: phone ?? this.phone,
      email: email ?? this.email,
      whatsapp: whatsapp ?? this.whatsapp,
      messenger: messenger ?? this.messenger,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'phone': phone,
      'email': email,
      'whatsapp': whatsapp,
      'messenger': messenger,
    };
  }

  factory Data.fromMap(Map<String, dynamic> map) {
    return Data(
      phone: map['phone'] as String,
      email: map['email'] as String,
      whatsapp: map['whatsapp'] as String,
      messenger: map['messenger'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Data.fromJson(String source) =>
      Data.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Data(phone: $phone, email: $email, whatsapp: $whatsapp, messenger: $messenger)';
  }

  @override
  bool operator ==(covariant Data other) {
    if (identical(this, other)) return true;

    return other.phone == phone &&
        other.email == email &&
        other.whatsapp == whatsapp &&
        other.messenger == messenger;
  }

  @override
  int get hashCode {
    return phone.hashCode ^
        email.hashCode ^
        whatsapp.hashCode ^
        messenger.hashCode;
  }
}
