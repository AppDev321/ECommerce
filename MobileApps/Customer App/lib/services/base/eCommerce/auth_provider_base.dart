import 'dart:io';

import 'package:dio/dio.dart';
import 'package:razin_shop/models/eCommerce/authentication/sign_up.dart';
import 'package:razin_shop/models/eCommerce/authentication/user.dart';

abstract class AuthProviderBase {
  Future<Response> signUp({required SingUp singUpInfo});
  Future<Response> login({required String phone, required String password});
  Future<Response> sendOTP({required String phone});
  Future<Response> verifyOTP({required String phone, required String otp});
  Future<Response> resetPassword({
    required String password,
    required String confirmPassword,
    required String forgotPasswordToken,
  });
  Future<Response> changePassword({
    required String oldPassword,
    required String newPassword,
    required String confirmNewPassword,
  });
  Future<Response> updateProfile({required User userInfo, required File? file});
  Future<Response> logout();
}
