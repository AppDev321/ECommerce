import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:razin_commerce_seller_flutter/config/app_constants.dart';
import 'package:razin_commerce_seller_flutter/utils/api_client.dart';

abstract class CommonRepositoryInterface {
  Future<Response> checkUserStatus({required String phone});
  Future<Response> getMasterData();
}

class CommonRepository implements CommonRepositoryInterface {
  final Ref ref;
  CommonRepository({required this.ref});
  @override
  Future<Response> checkUserStatus({required String phone}) async {
    final response = await ref
        .read(apiClientProvider)
        .get(AppConstants.checkUserStatus, query: {'phone': phone});
    return response;
  }

  @override
  Future<Response> getMasterData() async {
    final response = await ref.read(apiClientProvider).get(AppConstants.master);
    return response;
  }
}
