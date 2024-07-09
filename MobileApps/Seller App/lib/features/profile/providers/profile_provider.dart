import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:razin_commerce_seller_flutter/features/profile/models/profile_details.dart';
import 'package:razin_commerce_seller_flutter/features/profile/repositories/profile_repository.dart';
import 'package:razin_commerce_seller_flutter/features/profile/service/profile_service.dart';

// profile repository providers

final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  return ProfileRepository(ref: ref);
});

// profile service providers

final profileDetailsServiceProvider = StateNotifierProvider<
    ProfileDetailsService, AsyncValue<UserAccountDetails>>((ref) {
  return ProfileDetailsService(ref: ref);
});

final userInfoUpdateServiceProvider =
    StateNotifierProvider<UserInfoUpdateService, bool>((ref) {
  return UserInfoUpdateService(ref: ref);
});

final shopInfoUpdateServiceProvider =
    StateNotifierProvider<ShopInfoService, bool>((ref) {
  return ShopInfoService(ref: ref);
});

final shopSettingsServiceProvider =
    StateNotifierProvider<ShopSettingsService, bool>((ref) {
  return ShopSettingsService(ref: ref);
});

final shopBannerServiceProvider =
    StateNotifierProvider<ShopBannerService, bool>((ref) {
  return ShopBannerService(ref: ref);
});
