import 'package:hive_flutter/hive_flutter.dart';
import 'package:razinshop_rider/config/app_constants.dart';
import 'package:razinshop_rider/models/master_model/master_model.dart';
import 'package:razinshop_rider/models/privacy_policy_model/privacy_policy_model.dart';
import 'package:razinshop_rider/services/other_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'others_controller.g.dart';

@riverpod
class PrivacyPolicy extends _$PrivacyPolicy {
  @override
  FutureOr<PrivacyPolicyModel> build() async {
    return await ref
        .read(othersServiceProvider)
        .getPrivacyPolicy()
        .then((value) {
      return PrivacyPolicyModel.fromMap(value.data);
    });
  }
}

@riverpod
class TermsAndConditions extends _$TermsAndConditions {
  @override
  FutureOr<PrivacyPolicyModel> build() async {
    return await ref
        .read(othersServiceProvider)
        .getTermsAndConditions()
        .then((value) {
      return PrivacyPolicyModel.fromMap(value.data);
    });
  }
}

@riverpod
class MasterData extends _$MasterData {
  @override
  FutureOr<MasterModel> build() async {
    return await ref.read(othersServiceProvider).getMasterData().then((value) {
      final MasterModel masterModel = MasterModel.fromJson(value.data);
      final String? color = masterModel.data.themeColors.primaryColor;
      final String? currency = masterModel.data.currency.symbol;
      Hive.box(AppConstants.appSettingsBox)
          .put(AppConstants.primaryColor, color);
      Hive.box(AppConstants.appSettingsBox)
          .put(AppConstants.currency, currency);
      return masterModel;
    });
  }
}
