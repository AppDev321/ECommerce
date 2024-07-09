// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:razin_shop/models/eCommerce/address/add_address.dart';
import 'package:razin_shop/views/eCommerce/address/layouts/add_update_address_layout.dart';

class AddUpdateAddressView extends StatelessWidget {
  final AddAddress? address;
  const AddUpdateAddressView({
    Key? key,
    required this.address,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AddUpdateAddressLayout(
      address: address,
    );
  }
}
