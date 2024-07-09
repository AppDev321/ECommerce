import 'package:flutter/material.dart';
import 'package:razin_shop/views/common/authentication/layouts/confirm_otp_layout.dart';

class ConfirmOTPView extends StatelessWidget {
  final ConfirmOTPScreenArguments arguments;
  const ConfirmOTPView({Key? key, required this.arguments}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConfirmOTPLayout(arguments: arguments);
  }
}
