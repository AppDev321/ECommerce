import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:razin_commerce_seller_flutter/features/dashboard/models/dashboard_data_model.dart';
import 'package:razin_commerce_seller_flutter/features/dashboard/repositories/dashoard_repository.dart';
import 'package:razin_commerce_seller_flutter/features/dashboard/service/dashboard_service.dart';

// dashboard repositor provider

final dashboardRepositoryProvider = Provider<DashboardRepository>((ref) {
  return DashboardRepository(ref: ref);
});

// dashboard service provider

final dashboardServiceProvider = StateNotifierProviderFamily<DashboardService,
    AsyncValue<DashboardDataModel>, String>((ref, arg) {
  final filter = arg;
  final service = DashboardService(ref: ref);
  service.getDashboardData(filter: filter);
  return service;
});
