import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:razin_commerce_seller_flutter/config/app_constants.dart';
import 'package:razin_commerce_seller_flutter/features/profile/models/shop_info_update_model.dart';
import 'package:razin_commerce_seller_flutter/features/profile/models/shop_settings_update_model.dart';
import 'package:razin_commerce_seller_flutter/features/profile/models/user_info_update_model.dart';
import 'package:razin_commerce_seller_flutter/utils/api_client.dart';

abstract class ProfileRepositoryInterface {
  Future<Response> getProfileDetails();
  Future<Response> updateUserInfo(
      {required UserInfoUpdateMode model, required XFile image});
  Future<Response> updateShopInfo(
      {required ShopInfoUpdateModel model, required XFile image});
  Future<Response> updateShopSettings({required ShopSettingsUpdateModel model});

  Future<Response> getShopBanners();

  Future<Response> updateBanner({required XFile image, required int id});

  Future<Response> addNewBanner({required XFile? image});

  Future<Response> deleteBanner({required int id});
}

class ProfileRepository implements ProfileRepositoryInterface {
  ProfileRepository({required this.ref});
  final Ref ref;

  @override
  Future<Response> getProfileDetails() async {
    final response =
        await ref.read(apiClientProvider).get(AppConstants.profileDetails);
    return response;
  }

  @override
  Future<Response> updateUserInfo(
      {required UserInfoUpdateMode model, required XFile? image}) async {
    FormData formData = FormData.fromMap({
      'profile_photo':
          image != null ? await MultipartFile.fromFile(image.path) : null,
      ...model.toJson(),
    });
    final response = await ref
        .read(apiClientProvider)
        .post(AppConstants.updateUserInfo, data: formData);
    return response;
  }

  @override
  Future<Response> updateShopInfo(
      {required ShopInfoUpdateModel model, required XFile? image}) async {
    FormData formData = FormData.fromMap({
      'shop_logo':
          image != null ? await MultipartFile.fromFile(image.path) : null,
      ...model.toJson(),
    });
    final response = await ref
        .read(apiClientProvider)
        .post(AppConstants.updateShopInfo, data: formData);
    return response;
  }

  @override
  Future<Response> updateShopSettings(
      {required ShopSettingsUpdateModel model}) async {
    final response = await ref
        .read(apiClientProvider)
        .post(AppConstants.updateShopSettings, data: model.toJson());
    return response;
  }

  @override
  Future<Response> getShopBanners() async {
    final response =
        await ref.read(apiClientProvider).get(AppConstants.banners);
    return response;
  }

  @override
  Future<Response> deleteBanner({required int id}) async {
    final response =
        await ref.read(apiClientProvider).delete('${AppConstants.banners}/$id');
    return response;
  }

  @override
  Future<Response> updateBanner(
      {required XFile? image, required int id}) async {
    FormData formData = FormData.fromMap({
      'banner': image != null ? await MultipartFile.fromFile(image.path) : null,
      'id': id,
    });
    final response = await ref
        .read(apiClientProvider)
        .post(AppConstants.updateBanner, data: formData);
    return response;
  }

  @override
  Future<Response> addNewBanner({required XFile? image}) async {
    FormData formData = FormData.fromMap({
      'banner': image != null ? await MultipartFile.fromFile(image.path) : null,
    });
    final response = await ref
        .read(apiClientProvider)
        .post(AppConstants.addNewBanner, data: formData);

    return response;
  }
}
