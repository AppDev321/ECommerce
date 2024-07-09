import 'package:hive_flutter/hive_flutter.dart';
import 'package:razinshop_rider/config/app_constants.dart';
import 'package:razinshop_rider/services/auth_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'auth_controller.g.dart';

@riverpod
class Login extends _$Login {
  @override
  bool build() {
    return false;
  }

  Future<bool> login({required String phone, required String password}) async {
    state = true;
    final response = await ref.read(authServiceProvider).login(
          phone: phone,
          password: password,
        );
    if (response.statusCode == 200) {
      final data = response.data['data'];
      Box authBox = Hive.box(AppConstants.authBox);
      authBox.put(AppConstants.authToken, data['access']['token']);
      state = false;
      return true;
    } else {
      state = false;
      return false;
    }
  }
}

@riverpod
class SendOTP extends _$SendOTP {
  @override
  bool build() {
    return false;
  }

  Future<String?> sendOTP(
      {required String phone, required bool isForgetPass}) async {
    state = true;
    final response = await ref
        .read(authServiceProvider)
        .sendOTP(phone: phone, isForgetPass: isForgetPass);
    if (response.statusCode == 200) {
      state = false;
      return await response.data['data']['otp'].toString();
    } else {
      state = false;
      return null;
    }
  }
}

@riverpod
class VerifyOTP extends _$VerifyOTP {
  @override
  bool build() {
    return false;
  }

  Future<String?> verifyOTP(
      {required String phone, required String otp}) async {
    state = true;
    final response =
        await ref.read(authServiceProvider).verifyOTP(phone: phone, otp: otp);
    if (response.statusCode == 200) {
      state = false;
      String? token = response.data['data']['token'];
      return token;
    } else {
      state = false;
      return null;
    }
  }
}

@riverpod
class Registration extends _$Registration {
  @override
  bool build() {
    return false;
  }

  Future<bool> registration({required Map<String, dynamic> data}) async {
    state = true;
    final response =
        await ref.read(authServiceProvider).registration(data: data);
    if (response.statusCode == 200) {
      state = false;
      return true;
    } else {
      state = false;
      return false;
    }
  }
}

@riverpod
class CheckUserStatus extends _$CheckUserStatus {
  @override
  void build(String arg) async {
    Box authBox = Hive.box(AppConstants.authBox);
    final response =
        await ref.read(authServiceProvider).checkUserStatus(phone: arg);
    if (response.data['data']['user_status'] == true) {
      authBox.delete(AppConstants.isInReview);
    }
  }
}

@riverpod
class LogOut extends _$LogOut {
  @override
  bool build() {
    return false;
  }

  Future<bool> logOut() async {
    final response = await ref.read(authServiceProvider).logOut();
    Box authBox = Hive.box(AppConstants.authBox);
    state = true;
    if (response.statusCode == 200) {
      authBox.delete(AppConstants.authToken);
      authBox.delete(AppConstants.userData);
      state = false;
      return true;
    } else {
      state = false;
      return false;
    }
  }
}

@riverpod
class CreatePassword extends _$CreatePassword {
  @override
  bool build() {
    return false;
  }

  Future<bool> createPassword({required Map<String, dynamic> data}) async {
    state = true;
    final response =
        await ref.read(authServiceProvider).createPassword(data: data);
    if (response.statusCode == 200) {
      state = false;
      return true;
    } else {
      state = false;
      return false;
    }
  }
}

@Riverpod(keepAlive: true)
class UserDetils extends _$UserDetils {
  @override
  Future<void> build() async {
    final response = await ref.read(authServiceProvider).userDetails();
    if (response.statusCode == 200) {
      final data = response.data['data'];
      Box authBox = Hive.box(AppConstants.authBox);
      authBox.put(AppConstants.userData, data);
    }
    throw UnimplementedError();
  }
}

@riverpod
class ChangePassword extends _$ChangePassword {
  @override
  bool build() {
    return false;
  }

  Future<bool> changePassword({required Map<String, dynamic> data}) async {
    state = true;
    final response =
        await ref.read(authServiceProvider).changePassword(data: data);
    if (response.statusCode == 200) {
      state = false;
      return true;
    } else {
      state = false;
      return false;
    }
  }
}
