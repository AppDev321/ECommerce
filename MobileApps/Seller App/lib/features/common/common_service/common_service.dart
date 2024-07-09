import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:razin_commerce_seller_flutter/config/app_constants.dart';
import 'package:razin_commerce_seller_flutter/features/common/models/master_model.dart';
import 'package:razin_commerce_seller_flutter/features/common/providers/common_provider.dart';

class CommonService extends StateNotifier<bool> {
  final Ref ref;
  CommonService({required this.ref}) : super(false);

  Future<bool> checkUser({required String phone}) async {
    try {
      final response = await ref
          .read(commonRepositoryProvider)
          .checkUserStatus(phone: phone);
      bool userStatus = response.data['data']['user_status'];
      if (userStatus) {
        Hive.openBox(AppConstants.appSettingsBox)
            .then((box) => box.clear().then((value) => box.close()));
      }
      return response.data['data']['user_status'];
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<MasterModel?> getMasterData() async {
    try {
      final response = await ref.read(commonRepositoryProvider).getMasterData();
      MasterModel masterModel = MasterModel.fromJson(response.data);
      return masterModel;
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }
}

final commonServiceProvider = StateNotifierProvider<CommonService, bool>(
  (ref) => CommonService(ref: ref),
);
