import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:razin_shop/config/app_constants.dart';
import 'package:razin_shop/models/eCommerce/authentication/sign_up.dart';
import 'package:razin_shop/models/eCommerce/authentication/user.dart';
import 'package:razin_shop/services/base/eCommerce/auth_provider_base.dart';
import 'package:razin_shop/utils/api_client.dart';

final authServiceProvider = Provider((ref) => AuthService(ref));

class AuthService implements AuthProviderBase {
  final Ref ref;
  AuthService(this.ref);
  @override
  Future<Response> signUp({required SingUp singUpInfo}) async {
    final response = await ref.read(apiClientProvider).post(
          AppConstants.registrationUrl,
          data: singUpInfo.toMap(),
        );
    return response;
  }

  @override
  Future<Response> sendOTP({required String phone}) async {
    final response = await ref.read(apiClientProvider).post(
      AppConstants.sendOTP,
      data: {
        "phone": phone,
      },
    );
    return response;
  }

  @override
  Future<Response> login(
      {required String phone, required String password}) async {
    final response = await ref.read(apiClientProvider).post(
      AppConstants.loginUrl,
      data: {
        "phone": phone,
        "password": password,
      },
    );
    return response;
  }

  @override
  Future<Response> verifyOTP(
      {required String phone, required String otp}) async {
    final response = await ref.read(apiClientProvider).post(
      AppConstants.verifyOtp,
      data: {
        "phone": phone,
        "otp": otp,
      },
    );
    return response;
  }

  @override
  Future<Response> resetPassword({
    required String password,
    required String confirmPassword,
    required String forgotPasswordToken,
  }) async {
    final response = await ref.read(apiClientProvider).post(
      AppConstants.resetPassword,
      data: {
        "password": password,
        "password_confirmation": confirmPassword,
        "token": forgotPasswordToken,
      },
    );
    return response;
  }

  @override
  Future<Response> logout() async {
    final response =
        await ref.read(apiClientProvider).post(AppConstants.logout);

    return response;
  }

  @override
  Future<Response> changePassword({
    required String oldPassword,
    required String newPassword,
    required String confirmNewPassword,
  }) async {
    final response = await ref.read(apiClientProvider).post(
      AppConstants.changePassword,
      data: {
        "current_password": oldPassword,
        "password": newPassword,
        "password_confirmation": confirmNewPassword,
      },
    );
    return response;
  }

  @override
  Future<Response> updateProfile(
      {required User userInfo, required File? file}) async {
    FormData formData = FormData.fromMap({
      "profile_photo": file != null
          ? await MultipartFile.fromFile(file.path,
              filename: 'profile_photo.jpg')
          : null,
      ...userInfo.toMap(),
    });
    final response = await ref
        .read(apiClientProvider)
        .post(AppConstants.updateProfile, data: formData);
    return response;
  }
}
