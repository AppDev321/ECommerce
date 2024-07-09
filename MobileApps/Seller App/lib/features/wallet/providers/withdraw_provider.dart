import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:razin_commerce_seller_flutter/features/wallet/repositories/withdraw_repository.dart';
import 'package:razin_commerce_seller_flutter/features/wallet/wallet_service/withdraw_service.dart';

// withdraw repository provider

final withdrawRepositoryProvider = Provider<WithdrawRepository>(
  (ref) => WithdrawRepository(ref: ref),
);

// withdraw service provider

final withdrawServiceProvider = StateNotifierProvider<WithdrawService, bool>(
    (ref) => WithdrawService(ref: ref));
