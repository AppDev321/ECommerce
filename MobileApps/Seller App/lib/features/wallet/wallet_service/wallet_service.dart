import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:razin_commerce_seller_flutter/features/wallet/models/wallet_details.dart';
import 'package:razin_commerce_seller_flutter/features/wallet/models/wallet_history.dart';
import 'package:razin_commerce_seller_flutter/features/wallet/models/wallet_history_filter_model.dart';
import 'package:razin_commerce_seller_flutter/features/wallet/providers/wallet_provider.dart';

class WalletDetailsService extends StateNotifier<AsyncValue<WalletDetails>> {
  final Ref ref;

  WalletDetailsService({
    required this.ref,
  }) : super(const AsyncValue.loading());

  Future<void> getWalletDetails({required String? filterType}) async {
    try {
      final response = await ref
          .read(walletRepositoryProvider)
          .getWalletDetails(filterType: filterType);
      final data = WalletDetails.fromJson(response.data['data']);
      state = AsyncValue.data(data);
    } catch (e) {
      debugPrint(e.toString());
      state = AsyncValue.error(e.toString(), StackTrace.current);
    }
  }
}

class WalletHistoryService extends StateNotifier<bool> {
  final Ref ref;
  WalletHistoryService({required this.ref}) : super(false);

  int _totalHistoryCount = 0;

  int get totalHistoryCount => _totalHistoryCount;

  List<WalletHistory> _walletHistoryList = [];

  List<WalletHistory> get walletHistoryList => _walletHistoryList;

  Future<void> getWalletHistory(
      {required WalletHistoryFilterModel filterModel}) async {
    state = true;
    try {
      final response = await ref
          .read(walletRepositoryProvider)
          .getWalletHistory(filterModel: filterModel);
      _totalHistoryCount = response.data['data']['total'];

      List<dynamic> data = response.data['data']['withdraws'];

      if (filterModel.page > 1) {
        _walletHistoryList = [
          ..._walletHistoryList,
          ...data.map((order) => WalletHistory.fromJson(order))
        ];
      } else {
        _walletHistoryList =
            data.map((history) => WalletHistory.fromJson(history)).toList();
      }
      state = false;
    } catch (e) {
      debugPrint(e.toString());
      state = false;
    }
  }
}
