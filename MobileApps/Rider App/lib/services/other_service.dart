import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:razinshop_rider/config/app_constants.dart';
import 'package:razinshop_rider/utils/api_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'other_service.g.dart';

@riverpod
OthersService othersService(OthersServiceRef ref) {
  return OthersService(ref);
}

abstract class OthersRepo {
  Future<Response> getPrivacyPolicy();
  Future<Response> getTermsAndConditions();
  Future<Response> getMasterData();
}

class OthersService implements OthersRepo {
  final Ref ref;
  OthersService(this.ref);

  @override
  Future<Response> getPrivacyPolicy() {
    return ref.read(apiClientProvider).get(AppConstants.privacyPolicy);
  }

  @override
  Future<Response> getTermsAndConditions() {
    return ref.read(apiClientProvider).get(AppConstants.termsAndConditions);
  }

  @override
  Future<Response> getMasterData() {
    return ref.read(apiClientProvider).get(AppConstants.master);
  }
}
