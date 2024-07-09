import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:razin_commerce_seller_flutter/features/dashboard/models/dashboard_data_model.dart';
import 'package:razin_commerce_seller_flutter/features/dashboard/repositories/dashoard_repository.dart';

class DashboardService extends StateNotifier<AsyncValue<DashboardDataModel>> {
  DashboardService({required this.ref}) : super(const AsyncValue.loading());
  final Ref ref;

  Future<void> getDashboardData({required String filter}) async {
    try {
      final response = await ref
          .read(dashboardRepositoryProvider)
          .getDashboardData(filter: filter);
      state =
          AsyncValue.data(DashboardDataModel.fromJson(response.data['data']));
    } catch (e) {
      debugPrint(e.toString());
      state = AsyncValue.error(e.toString(), StackTrace.current);
    }
  }
}
