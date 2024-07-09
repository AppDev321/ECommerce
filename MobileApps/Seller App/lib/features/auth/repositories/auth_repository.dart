import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:razin_commerce_seller_flutter/config/app_constants.dart';
import 'package:razin_commerce_seller_flutter/features/auth/models/sign_up_model.dart';
import 'package:razin_commerce_seller_flutter/utils/api_client.dart';

abstract class AuthRepositoryInterface {
  Future<Response> login({required String contact, required String password});
  Future<Response> signUp({
    required SignUpModel signUpModel,
    required XFile profile,
    required XFile shopLogo,
    required XFile shopBanner,
  });
  Future<Response> sendOTP(
      {required String email, required bool isForgotPassword});
  Future<Response> verifyOTP({required String email, required String otp});
  Future<Response> forgotPassword({
    required String password,
    required String confirmPassword,
    required String token,
  });
}

class AuthRepository implements AuthRepositoryInterface {
  final Ref ref;
  AuthRepository({required this.ref});
  @override
  Future<Response> login(
      {required String contact, required String password}) async {
    final response = await ref.read(apiClientProvider).post(
      AppConstants.login,
      data: {'contact': contact, 'password': password},
    );
    return response;
  }

  @override
  Future<Response> signUp({
    required SignUpModel signUpModel,
    required XFile profile,
    required XFile shopLogo,
    required XFile shopBanner,
  }) async {
    FormData formData = FormData.fromMap({
      'profile_photo': await MultipartFile.fromFile(profile.path),
      'shop_logo': await MultipartFile.fromFile(shopLogo.path),
      'shop_banner': await MultipartFile.fromFile(shopBanner.path),
      ...signUpModel.toMap(),
    });
    final response = await ref
        .read(apiClientProvider)
        .post(AppConstants.signUp, data: formData);

    return response;
  }

  @override
  Future<Response> sendOTP(
      {required String email, required bool isForgotPassword}) async {
    final response = await ref.read(apiClientProvider).post(
      AppConstants.sendOTP,
      data: {
        'email': email,
        'forgot_password': isForgotPassword,
      },
    );
    return response;
  }

  @override
  Future<Response> verifyOTP(
      {required String email, required String otp}) async {
    final response =
        await ref.read(apiClientProvider).post(AppConstants.verifyOTP, data: {
      'email': email,
      'otp': otp,
    });
    return response;
  }

  @override
  Future<Response> forgotPassword(
      {required String password,
      required String confirmPassword,
      required String token}) async {
    final response = await ref
        .read(apiClientProvider)
        .post(AppConstants.forgotPassword, data: {
      'password': password,
      'password_confirmation': confirmPassword,
      'token': token
    });
    return response;
  }
}
