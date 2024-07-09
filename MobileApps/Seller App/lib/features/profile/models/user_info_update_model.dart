class UserInfoUpdateMode {
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String gender;
  final String dateOfBirth;

  UserInfoUpdateMode(
      {required this.firstName,
      required this.lastName,
      required this.email,
      required this.phone,
      required this.gender,
      required this.dateOfBirth});

  Map<String, dynamic> toJson() => {
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'phone': phone,
        'gender': gender,
        'date_of_birth': dateOfBirth
      };
}
