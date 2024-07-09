import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:razin_commerce_seller_flutter/features/auth/auth_service/auth_service.dart';
import 'package:razin_commerce_seller_flutter/features/auth/repositories/auth_repository.dart';

// Auth service provider

final authServiceProvider = StateNotifierProvider<AuthService, bool>((ref) {
  return AuthService(ref: ref);
});

// Auth repository provider

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(ref: ref);
});
