import 'package:flutter/cupertino.dart';
import 'package:razinshop_rider/views/auth/layouts/registration_layout.dart';

class RegistrationView extends StatelessWidget {
  const RegistrationView({super.key, this.isProfileUpdate = false});
  final bool isProfileUpdate;

  @override
  Widget build(BuildContext context) {
    return RegistrationLayout(isProfileUpdate: isProfileUpdate);
  }
}
