import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:razin_shop/models/eCommerce/authentication/sign_up.dart';
import 'package:razin_shop/models/eCommerce/authentication/user.dart';
import 'package:razin_shop/models/eCommerce/common/common_response.dart';
import 'package:razin_shop/services/common/hive_service_provider.dart';
import 'package:razin_shop/services/eCommerce/auth_service/auth_service.dart';
import 'package:razin_shop/utils/api_client.dart';

final authControllerProvider =
    StateNotifierProvider<AuthController, bool>((ref) => AuthController(ref));

class AuthController extends StateNotifier<bool> {
  final Ref ref;
  AuthController(this.ref) : super(false);

  Future<CommonResponse> singUp({required SingUp singUpInfo}) async {
    try {
      state = true;
      final response =
          await ref.read(authServiceProvider).signUp(singUpInfo: singUpInfo);
      final String message = response.data['message'];
      final userInfo = User.fromMap(response.data['data']['user']);
      final accessToken = response.data['data']['access']['token'];
      ref.read(hiveServiceProvider).saveUserInfo(userInfo: userInfo);
      ref.read(hiveServiceProvider).saveUserAuthToken(authToken: accessToken);
      ref.read(apiClientProvider).updateToken(token: accessToken);
      state = false;
      return CommonResponse(isSuccess: true, message: message);
    } catch (error) {
      state = false;
      debugPrint(error.toString());
      return CommonResponse(isSuccess: false, message: error.toString());
    }
  }

  Future<CommonResponse> sendOTP({required String phone}) async {
    try {
      state = true;
      final response =
          await ref.read(authServiceProvider).sendOTP(phone: phone);
      final String message = response.data['message'];
      final String otp = response.data['data']['otp'].toString();
      state = false;
      return CommonResponse(isSuccess: true, message: message, data: otp);
    } catch (error) {
      state = false;
      debugPrint(error.toString());
      return CommonResponse(isSuccess: false, message: error.toString());
    }
  }

  Future<CommonResponse> verifyOTP(
      {required String phone, required String otp}) async {
    try {
      state = true;
      final response =
          await ref.read(authServiceProvider).verifyOTP(phone: phone, otp: otp);
      final String message = response.data['message'];
      final String token = response.data['data']['token'];
      state = false;
      return CommonResponse(isSuccess: true, message: message, data: token);
    } catch (error) {
      state = false;
      debugPrint(error.toString());
      return CommonResponse(isSuccess: false, message: error.toString());
    }
  }

  Future<CommonResponse> resetPassword({
    required String password,
    required String confrimPassword,
    required String forgotPasswordToken,
  }) async {
    try {
      state = true;
      final response = await ref.read(authServiceProvider).resetPassword(
            password: password,
            confirmPassword: confrimPassword,
            forgotPasswordToken: forgotPasswordToken,
          );
      final String message = response.data['message'];

      if (response.statusCode == 200) {
        state = false;
        return CommonResponse(isSuccess: true, message: message);
      }
      state = false;
      return CommonResponse(
        isSuccess: false,
        message: message,
      );
    } catch (error) {
      state = false;
      debugPrint(error.toString());
      return CommonResponse(isSuccess: false, message: error.toString());
    }
  }

  Future<CommonResponse> login(
      {required String phone, required String password}) async {
    try {
      state = true;
      final response = await ref
          .read(authServiceProvider)
          .login(phone: phone, password: password);
      final String message = response.data['message'];
      final userInfo = User.fromMap(response.data['data']['user']);
      final accessToken = response.data['data']['access']['token'];
      ref.read(hiveServiceProvider).saveUserInfo(userInfo: userInfo);
      ref.read(hiveServiceProvider).saveUserAuthToken(authToken: accessToken);
      ref.read(apiClientProvider).updateToken(token: accessToken);
      state = false;
      return CommonResponse(isSuccess: true, message: message);
    } catch (error) {
      state = false;
      debugPrint(error.toString());
      return CommonResponse(isSuccess: false, message: error.toString());
    }
  }

  Future<CommonResponse> changePassword({
    required String oldPassword,
    required String newPassword,
    required String confirmNewPassword,
  }) async {
    try {
      state = true;
      final response = await ref.read(authServiceProvider).changePassword(
            oldPassword: oldPassword,
            newPassword: newPassword,
            confirmNewPassword: confirmNewPassword,
          );
      final String message = response.data['message'];
      if (response.statusCode == 200) {
        state = false;
        return CommonResponse(isSuccess: true, message: message);
      } else {
        state = false;
        return CommonResponse(isSuccess: false, message: message);
      }
    } catch (error) {
      state = false;
      debugPrint(error.toString());
      return CommonResponse(isSuccess: false, message: error.toString());
    }
  }

  Future<CommonResponse> updateProfile(
      {required User userInfo, required File? file}) async {
    try {
      state = true;
      final response = await ref.read(authServiceProvider).updateProfile(
            userInfo: userInfo,
            file: file,
          );
      final String message = response.data['message'];
      final User userData = User.fromMap(response.data['data']['user']);
      ref.read(hiveServiceProvider).saveUserInfo(userInfo: userData);
      state = false;
      return CommonResponse(isSuccess: true, message: message);
    } catch (error) {
      state = false;
      debugPrint(error.toString());
      return CommonResponse(isSuccess: false, message: error.toString());
    }
  }

  Future<CommonResponse> logout() async {
    try {
      state = true;
      final response = await ref.read(authServiceProvider).logout();
      final String message = response.data['message'];
      state = false;
      return CommonResponse(isSuccess: true, message: message);
    } catch (error) {
      state = false;
      debugPrint(error.toString());
      return CommonResponse(isSuccess: false, message: error.toString());
    }
  }
}
