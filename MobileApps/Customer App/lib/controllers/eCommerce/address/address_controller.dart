import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:razin_shop/models/eCommerce/address/add_address.dart';
import 'package:razin_shop/models/eCommerce/common/common_response.dart';
import 'package:razin_shop/services/common/hive_service_provider.dart';
import 'package:razin_shop/services/eCommerce/address_service/address_service.dart';

final addressControllerProvider =
    StateNotifierProvider<AddressController, bool>(
        (ref) => AddressController(ref));

class AddressController extends StateNotifier<bool> {
  final Ref ref;
  AddressController(this.ref) : super(false);

  List<AddAddress> _addressList = [];
  List<AddAddress> get addressList => _addressList;

  Future<CommonResponse> addAddress({required AddAddress addAddress}) async {
    try {
      state = true;
      final response = await ref
          .read(addressServiceProvider)
          .addAddress(addAddress: addAddress);
      state = false;
      return CommonResponse(isSuccess: true, message: response.data['message']);
    } catch (error) {
      debugPrint(error.toString());
      state = false;
      return CommonResponse(isSuccess: false, message: error.toString());
    }
  }

  Future<CommonResponse> updateAddress({required AddAddress addAddress}) async {
    try {
      state = true;
      final response = await ref
          .read(addressServiceProvider)
          .updateAddress(addAddress: addAddress);
      state = false;
      return CommonResponse(isSuccess: true, message: response.data['message']);
    } catch (error) {
      debugPrint(error.toString());
      state = false;
      return CommonResponse(isSuccess: false, message: error.toString());
    }
  }

  Future<CommonResponse> deleteAddress({required int addressId}) async {
    try {
      state = true;
      final response = await ref
          .read(addressServiceProvider)
          .deleteAddress(addressId: addressId);
      state = false;
      return CommonResponse(isSuccess: true, message: response.data['message']);
    } catch (error) {
      debugPrint(error.toString());
      state = false;
      return CommonResponse(isSuccess: false, message: error.toString());
    }
  }

  Future<CommonResponse> getAddress() async {
    try {
      state = true;
      final response = await ref.read(addressServiceProvider).getAddress();
      final List<dynamic> addressData = response.data['data']['addresses'];
      _addressList =
          addressData.map((address) => AddAddress.fromMap(address)).toList();
      if (_addressList.isEmpty) {
        ref.read(hiveServiceProvider).clearDefaultAddress();
      }
      for (AddAddress address in _addressList) {
        if (address.isDefault == true) {
          ref
              .read(hiveServiceProvider)
              .saveDefaultDeliveryAddress(address: address);
        }
      }

      state = false;
      return CommonResponse(isSuccess: true, message: response.data['message']);
    } catch (error) {
      debugPrint(error.toString());
      state = false;
      return CommonResponse(isSuccess: false, message: error.toString());
    }
  }
}
