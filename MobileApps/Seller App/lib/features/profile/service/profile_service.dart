import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:razin_commerce_seller_flutter/features/common/models/common_model.dart';
import 'package:razin_commerce_seller_flutter/features/profile/models/profile_details.dart';
import 'package:razin_commerce_seller_flutter/features/profile/models/shop_info_update_model.dart';
import 'package:razin_commerce_seller_flutter/features/profile/models/shop_settings_update_model.dart';
import 'package:razin_commerce_seller_flutter/features/profile/models/user_info_update_model.dart';
import 'package:razin_commerce_seller_flutter/features/profile/providers/profile_provider.dart';

class ProfileDetailsService
    extends StateNotifier<AsyncValue<UserAccountDetails>> {
  final Ref ref;

  ProfileDetailsService({required this.ref})
      : super(const AsyncValue.loading()) {
    getProfileDetails();
  }

  Future<void> getProfileDetails() async {
    try {
      state = const AsyncValue.loading();
      final response =
          await ref.read(profileRepositoryProvider).getProfileDetails();
      state = AsyncValue.data(
          UserAccountDetails.fromJson(response.data['data']['user']));
    } catch (e) {
      state = AsyncValue.error(e.toString(), StackTrace.current);
    }
  }
}

class UserInfoUpdateService extends StateNotifier<bool> {
  final Ref ref;

  UserInfoUpdateService({required this.ref}) : super(false);

  Future<CommonResponseModel> updateUserInfo(
      {required UserInfoUpdateMode model, required XFile? image}) async {
    try {
      state = true;
      final response = await ref
          .read(profileRepositoryProvider)
          .updateUserInfo(model: model, image: image);
      final status = response.statusCode == 200;
      final message = response.data['message'];
      state = false;
      return CommonResponseModel(status: status, message: message);
    } catch (e) {
      state = false;
      return CommonResponseModel(status: false, message: e.toString());
    }
  }
}

class ShopInfoService extends StateNotifier<bool> {
  final Ref ref;

  ShopInfoService({required this.ref}) : super(false);

  Future<CommonResponseModel> updateShopInfo(
      {required ShopInfoUpdateModel model, required XFile? image}) async {
    try {
      state = true;
      final response = await ref
          .read(profileRepositoryProvider)
          .updateShopInfo(model: model, image: image);
      final status = response.statusCode == 200;
      final message = response.data['message'];
      state = false;
      return CommonResponseModel(status: status, message: message);
    } catch (e) {
      state = false;
      return CommonResponseModel(status: false, message: e.toString());
    }
  }
}

class ShopSettingsService extends StateNotifier<bool> {
  final Ref ref;

  ShopSettingsService({required this.ref}) : super(false);

  Future<CommonResponseModel> updateShopSettings(
      {required ShopSettingsUpdateModel model}) async {
    try {
      state = true;
      final response = await ref
          .read(profileRepositoryProvider)
          .updateShopSettings(model: model);
      final status = response.statusCode == 200;
      final message = response.data['message'];
      state = false;
      return CommonResponseModel(status: status, message: message);
    } catch (e) {
      state = false;
      return CommonResponseModel(status: false, message: e.toString());
    }
  }
}

class ShopBannerService extends StateNotifier<bool> {
  final Ref ref;

  ShopBannerService({required this.ref}) : super(false);

  List<Banner> _banners = [];

  List<Banner> get banners => _banners;

  // get shop banner
  Future<CommonResponseModel> getShopBanners() async {
    try {
      state = true;
      final response =
          await ref.read(profileRepositoryProvider).getShopBanners();
      final status = response.statusCode == 200;
      List<dynamic> data = response.data['data']['banners'];
      _banners = data.map((banner) => Banner.fromJson(banner)).toList();

      final message = response.data['message'];
      state = false;
      return CommonResponseModel(status: status, message: message);
    } catch (e) {
      state = false;
      return CommonResponseModel(status: false, message: e.toString());
    }
  }

  // add new banner

  Future<CommonResponseModel> addNewBanner({required XFile? image}) async {
    try {
      state = true;
      final response =
          await ref.read(profileRepositoryProvider).addNewBanner(image: image);
      final status = response.statusCode == 200;
      List<dynamic> data = response.data['data']['user']['banners'];
      _banners = data.map((banner) => Banner.fromJson(banner)).toList();
      final message = response.data['message'];
      state = false;
      return CommonResponseModel(status: status, message: message);
    } catch (e) {
      state = false;
      return CommonResponseModel(status: false, message: e.toString());
    }
  }

  // update banner

  Future<CommonResponseModel> updateBanner(
      {required XFile? image, required int id}) async {
    try {
      state = true;
      final response = await ref
          .read(profileRepositoryProvider)
          .updateBanner(image: image, id: id);
      final status = response.statusCode == 200;
      List<dynamic> data = response.data['data']['user']['banners'];
      _banners = data.map((banner) => Banner.fromJson(banner)).toList();
      final message = response.data['message'];
      state = false;
      return CommonResponseModel(status: status, message: message);
    } catch (e) {
      state = false;
      return CommonResponseModel(status: false, message: e.toString());
    }
  }

  Future<CommonResponseModel> deleteBanner({required int id}) async {
    try {
      state = true;
      final response =
          await ref.read(profileRepositoryProvider).deleteBanner(id: id);
      final status = response.statusCode == 200;
      List<dynamic> data = response.data['data']['user']['banners'];
      _banners = data.map((banner) => Banner.fromJson(banner)).toList();
      final message = response.data['message'];
      state = false;
      return CommonResponseModel(status: status, message: message);
    } catch (e) {
      state = false;
      return CommonResponseModel(status: false, message: e.toString());
    }
  }
}
