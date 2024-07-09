import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:razin_commerce_seller_flutter/config/app_constants.dart';
import 'package:razin_commerce_seller_flutter/utils/api_client.dart';

abstract class WithdrawRepositoryInterface {
  Future<Response> withdrawWallet({
    required String amount,
  });
}

class WithdrawRepository implements WithdrawRepositoryInterface {
  final Ref ref;
  WithdrawRepository({required this.ref});
  @override
  Future<Response> withdrawWallet({
    required String amount,
  }) async {
    final response = await ref
        .read(apiClientProvider)
        .post(AppConstants.withdrawWallet, data: {'amount': amount});
    return response;
  }
}

final withdrawRepositoryProvider = Provider<WithdrawRepository>(
  (ref) => WithdrawRepository(ref: ref),
);
