import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:razin_commerce_seller_flutter/features/wallet/models/wallet_details.dart';
import 'package:razin_commerce_seller_flutter/features/wallet/repositories/wallet_repository.dart';
import 'package:razin_commerce_seller_flutter/features/wallet/wallet_service/wallet_service.dart';

// Wallet repository provider

final walletRepositoryProvider = Provider<WalletRepository>((ref) {
  return WalletRepository(ref: ref);
});

// Wallet service provider

final walletDetailsServiceProvider = StateNotifierProviderFamily<
    WalletDetailsService, AsyncValue<WalletDetails>, String>((ref, filter) {
  final service = WalletDetailsService(ref: ref);
  service.getWalletDetails(filterType: filter);
  return service;
});

final walletHistoryServiceProvider =
    StateNotifierProvider<WalletHistoryService, bool>(
        (ref) => WalletHistoryService(ref: ref));
