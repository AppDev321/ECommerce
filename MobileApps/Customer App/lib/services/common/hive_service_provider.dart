import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:razin_shop/config/app_constants.dart';
import 'package:razin_shop/models/eCommerce/address/add_address.dart';
import 'package:razin_shop/models/eCommerce/authentication/user.dart';

class HiveService {
  final Ref ref;

  HiveService(this.ref);

  // save the first open status
  Future setFirstOpenValue({required bool value}) async {
    final appSettingsBox = await Hive.openBox(AppConstants.appSettingsBox);
    appSettingsBox.put(AppConstants.firstOpen, value);
  }

  Future setPrimaryColor({required String color}) async {
    final appSettingsBox = Hive.box(AppConstants.appSettingsBox);
    appSettingsBox.put(AppConstants.primaryColor, color);
  }

  Future setAppLogo({required String logo}) async {
    final appSettingsBox = Hive.box(AppConstants.appSettingsBox);
    appSettingsBox.put(AppConstants.appLogo, logo);
  }

  Future setAppName({required String name}) async {
    final appSettingsBox = Hive.box(AppConstants.appSettingsBox);
    appSettingsBox.put(AppConstants.appName, name);
  }

  Future setSplashLogo({required String splashLogo}) async {
    final appSettingsBox = Hive.box(AppConstants.appSettingsBox);
    appSettingsBox.put(AppConstants.splashLogo, splashLogo);
  }

  // save access token
  Future saveUserAuthToken({required String authToken}) async {
    final authBox = await Hive.openBox(AppConstants.authBox);
    authBox.put(AppConstants.authToken, authToken);
  }

  // save app local
  Future<void> saveAppLocal({required String local}) async {
    final appSettingBox = Hive.box(AppConstants.appSettingsBox);
    appSettingBox.put(AppConstants.appLocal, local);
  }

  // get appLocal
  Future<String?> getAppLocal() async {
    final appSettingBox = Hive.box(AppConstants.appSettingsBox);
    final data = appSettingBox.get(AppConstants.appLocal);
    return data;
  }

  // get user auth token
  Future<String?> getAuthToken() async {
    final authToken = await Hive.openBox(AppConstants.authBox)
        .then((box) => box.get(AppConstants.authToken));

    if (authToken != null) {
      return authToken;
    }
    return null;
  }

  bool userIsLoggedIn() {
    final userAuthToken =
        Hive.box(AppConstants.authBox).get(AppConstants.authToken);
    return userAuthToken == null ? false : true;
  }

  // remove access token
  Future removeUserAuthToken() async {
    final authBox = await Hive.openBox(AppConstants.authBox);
    authBox.clear();
  }

  // save user information
  Future saveUserInfo({required User userInfo}) async {
    final userBox = await Hive.openBox(AppConstants.userBox);
    userBox.put(AppConstants.userData, userInfo.toMap());
  }

  // get user information
  Future<User?> getUserInfo() async {
    final userBox = await Hive.openBox(AppConstants.userBox);
    Map<dynamic, dynamic>? userInfo = userBox.get(AppConstants.userData);
    if (userInfo != null) {
      Map<String, dynamic> userInfoStringKeys =
          userInfo.cast<String, dynamic>();
      User user = User.fromMap(userInfoStringKeys);
      return user;
    }
    return null;
  }

  // save default deliveryAddress
  Future<void> saveDefaultDeliveryAddress({required AddAddress address}) async {
    DefaultAddressModel addressModel = DefaultAddressModel(
        addressId: address.addressId,
        name: address.name,
        phone: address.phone,
        area: address.area,
        flatNo: address.flatNo,
        postCode: address.postCode,
        addressLine: address.addressLine,
        addressLine2: address.addressLine2,
        addressType: address.addressType,
        isDefault: address.isDefault);
    final userBox = Hive.box(AppConstants.userBox);
    userBox.put(AppConstants.defaultAddress, addressModel.toMap());
  }

  void clearDefaultAddress() {
    final userBox = Hive.box(AppConstants.userBox);
    final data = userBox.get(AppConstants.defaultAddress);
    if (data != null) {
      userBox.delete(AppConstants.defaultAddress);
    }
  }

  // get default deliveryAddress
  Future<AddAddress?> getDefaultAddress() async {
    final userBox = Hive.box(AppConstants.userBox);
    Map<dynamic, dynamic>? defaultAddressData =
        userBox.get(AppConstants.defaultAddress);
    if (defaultAddressData != null) {
      Map<String, dynamic> addressStringKeys =
          defaultAddressData.cast<String, dynamic>();
      AddAddress address = AddAddress.fromMap(addressStringKeys);
      return address;
    }
    return null;
  }

  // Get user first open status
  Future<bool?> getUserFirstOpenStatus() async {
    final appSettingsBox = await Hive.openBox(AppConstants.appSettingsBox);
    final status = appSettingsBox.get(AppConstants.firstOpen);
    if (status != null) {
      return status;
    }
    return false;
  }

  // load token and user info
  Future<List<dynamic>?> loadTokenAndUser() async {
    final firstOpenStatus = await getUserFirstOpenStatus();
    final authToken = await getAuthToken();
    final user = await getUserInfo();
    return [firstOpenStatus, authToken, user];
  }

  // remove user data
  Future removeUserData() async {
    final userBox = await Hive.openBox(AppConstants.userBox);
    userBox.clear();
  }

  Future<bool> removeAllData() async {
    try {
      await removeUserAuthToken();
      // await removeUserData();
      return true;
    } catch (e) {
      return false;
    }
  }
}

final hiveServiceProvider = Provider((ref) => HiveService(ref));
