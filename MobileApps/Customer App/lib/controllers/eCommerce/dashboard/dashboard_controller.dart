import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:razin_shop/models/eCommerce/dashboard/dashboard.dart';
import 'package:razin_shop/services/eCommerce/dashboard_service/dashboard_service.dart';

final dashboardControllerProvider =
    StateNotifierProvider<DashboardController, AsyncValue<Dashboard>>((ref) {
  final controller = DashboardController(ref);
  controller.getDashboardData();
  return controller;
});

class DashboardController extends StateNotifier<AsyncValue<Dashboard>> {
  final Ref ref;
  DashboardController(this.ref) : super(const AsyncLoading());

  Future<void> getDashboardData() async {
    try {
      final response =
          await ref.read(dashboardServiceProvider).getDashboardData();
      final data = response.data['data'];
      state = AsyncData(Dashboard.fromMap(data));
    } catch (error, stackTrace) {
      debugPrint(error.toString());
      state = AsyncError(error, stackTrace);
      throw Exception(stackTrace);
    }
  }
}
