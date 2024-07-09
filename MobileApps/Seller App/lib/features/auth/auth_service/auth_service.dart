import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:razin_commerce_seller_flutter/features/auth/models/sign_up_model.dart';
import 'package:razin_commerce_seller_flutter/features/auth/providers/auth_provider.dart';
import 'package:razin_commerce_seller_flutter/features/common/models/common_model.dart';
import 'package:razin_commerce_seller_flutter/features/common/providers/common_provider.dart';
import 'package:razin_commerce_seller_flutter/utils/api_client.dart';

class AuthService extends StateNotifier<bool> {
  final Ref ref;
  AuthService({required this.ref}) : super(false);

  Future<CommonResponseModel> login(
      {required String contact, required String password}) async {
    try {
      state = true;
      final response = await ref
          .read(authRepositoryProvider)
          .login(contact: contact, password: password);
      final status = response.statusCode == 200;
      if (status) {
        ref
            .read(hiveServiceProvider)
            .saveToken(token: response.data['data']['access']['token']);
        ref
            .read(apiClientProvider)
            .updateToken(token: response.data['data']['access']['token']);
      }
      state = false;
      return CommonResponseModel(
        status: status,
        message: status ? '' : response.data['message'],
      );
    } catch (e) {
      state = false;
      debugPrint('Error in login: $e');
      return CommonResponseModel(
        status: false,
        message: 'Error in login: $e',
      );
    }
  }

  Future<CommonResponseModel> forgotPassowrd({
    required String password,
    required String confirmPassword,
    required String token,
  }) async {
    state = true;
    try {
      final response = await ref.read(authRepositoryProvider).forgotPassword(
            password: password,
            confirmPassword: confirmPassword,
            token: token,
          );
      final status = response.statusCode == 200;
      state = false;
      return CommonResponseModel(
        status: status,
        message: response.data['message'],
      );
    } catch (e) {
      debugPrint('Error in forgotPassword: $e');
      state = false;
      return CommonResponseModel(
        status: false,
        message: 'Error in forgotPassword: $e',
      );
    }
  }

  Future<CommonResponseModel> signUp({
    required SignUpModel signUpModel,
    required XFile profile,
    required XFile shopLogo,
    required XFile shopBanner,
  }) async {
    try {
      state = true;
      final response = await ref.read(authRepositoryProvider).signUp(
            signUpModel: signUpModel,
            profile: profile,
            shopBanner: shopLogo,
            shopLogo: shopBanner,
          );

      final status = response.statusCode == 200 || response.statusCode == 201;

      state = false;

      return CommonResponseModel(
        status: status,
        message: status ? '' : 'Failed to sign up',
      );
    } catch (e) {
      state = false;
      debugPrint('Error in signUp: $e');
      return CommonResponseModel(
        status: false,
        message: 'Error in signUp: $e',
      );
    }
  }

  Future<CommonResponseModel> sendOTP(
      {required String email, required bool isForgotPassword}) async {
    try {
      state = true;
      await ref
          .read(authRepositoryProvider)
          .sendOTP(email: email, isForgotPassword: isForgotPassword);
      state = false;
      return CommonResponseModel(status: true, message: '', data: '');
    } catch (e) {
      state = false;
      return CommonResponseModel(
        status: false,
        message: e.toString(),
      );
    }
  }

  Future<CommonResponseModel> verifyOTP({
    required String email,
    required String otp,
  }) async {
    try {
      state = true;
      final response = await ref
          .read(authRepositoryProvider)
          .verifyOTP(email: email, otp: otp);

      final status = response.statusCode == 200;
      state = false;

      return CommonResponseModel(
        status: status,
        message: status ? '' : 'Failed to verify OTP',
        data: status ? response.data['data']['token'] : null,
      );
    } catch (e) {
      state = false;
      debugPrint('Error in verifyOTP: $e');
      return CommonResponseModel(
        status: false,
        message: 'Error in verifyOTP: $e',
      );
    }
  }
}
