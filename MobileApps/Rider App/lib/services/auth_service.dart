import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:razinshop_rider/config/app_constants.dart';
import 'package:razinshop_rider/utils/api_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'auth_service.g.dart';

@riverpod
AuthService authService(AuthServiceRef ref) {
  return AuthService(ref);
}

abstract class AuthRepo {
  Future<Response> login({required String phone, required String password});
  Future<Response> sendOTP({required String phone, required bool isForgetPass});
  Future<Response> verifyOTP({required String phone, required String otp});
  Future<Response> registration({required Map<String, dynamic> data});
  Future<Response> checkUserStatus({required String phone});
  Future<Response> createPassword({required Map<String, dynamic> data});
  Future<Response> userDetails();
  Future<Response> changePassword({required Map<String, dynamic> data});
  Future<Response> logOut();
}

class AuthService implements AuthRepo {
  final Ref ref;
  AuthService(this.ref);

  @override
  Future<Response> login({required String phone, required String password}) {
    return ref.read(apiClientProvider).post(AppConstants.loginUrl,
        data: {'phone': phone, 'password': password});
  }

  @override
  Future<Response> sendOTP(
      {required String phone, required bool isForgetPass}) async {
    return ref.read(apiClientProvider).post(AppConstants.sendOTPUrl, data: {
      'phone': phone,
      'forgot_password': isForgetPass,
    });
  }

  @override
  Future<Response> verifyOTP({required String phone, required String otp}) {
    return ref.read(apiClientProvider).post(AppConstants.verifyOTPUrl, data: {
      'phone': phone,
      'otp': otp,
    });
  }

  @override
  Future<Response> registration({required Map<String, dynamic> data}) {
    return ref
        .read(apiClientProvider)
        .post(AppConstants.registrationUrl, data: FormData.fromMap(data));
  }

  @override
  Future<Response> checkUserStatus({required String phone}) {
    return ref
        .read(apiClientProvider)
        .get(AppConstants.checkUserStatusUrl, query: {'phone': phone});
  }

  @override
  Future<Response> logOut() {
    return ref.read(apiClientProvider).get(AppConstants.logoutUrl);
  }

  @override
  Future<Response> createPassword({required Map<String, dynamic> data}) {
    return ref
        .read(apiClientProvider)
        .post(AppConstants.createPassowrdUrl, data: data);
  }

  @override
  Future<Response> userDetails() {
    return ref.read(apiClientProvider).get(AppConstants.userDetails);
  }

  @override
  Future<Response> changePassword({required Map<String, dynamic> data}) {
    return ref
        .read(apiClientProvider)
        .post(AppConstants.changePassword, data: data);
  }
}
