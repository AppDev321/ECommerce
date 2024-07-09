import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:razin_commerce_seller_flutter/config/app_constants.dart';
import 'package:razin_commerce_seller_flutter/features/wallet/models/wallet_history_filter_model.dart';
import 'package:razin_commerce_seller_flutter/utils/api_client.dart';

abstract class WalletRepositoryInterface {
  Future<Response> getWalletDetails({required String? filterType});
  Future<Response> getWalletHistory(
      {required WalletHistoryFilterModel filterModel});
}

class WalletRepository implements WalletRepositoryInterface {
  final Ref ref;
  WalletRepository({required this.ref});
  @override
  Future<Response> getWalletDetails({required String? filterType}) async {
    final response = await ref
        .read(apiClientProvider)
        .get(AppConstants.walletDetails, query: {'filter_type': filterType});
    return response;
  }

  @override
  Future<Response> getWalletHistory(
      {required WalletHistoryFilterModel filterModel}) async {
    final response = await ref
        .read(apiClientProvider)
        .get(AppConstants.walletHistory, query: filterModel.toMap());
    return response;
  }
}
