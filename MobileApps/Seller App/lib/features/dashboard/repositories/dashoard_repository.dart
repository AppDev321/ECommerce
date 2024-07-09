import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:razin_commerce_seller_flutter/config/app_constants.dart';
import 'package:razin_commerce_seller_flutter/utils/api_client.dart';

abstract class DashboardRepositoryInterface {
  Future<Response> getDashboardData({required String filter});
}

class DashboardRepository implements DashboardRepositoryInterface {
  DashboardRepository({required this.ref});
  final Ref ref;
  @override
  Future<Response> getDashboardData({required String filter}) async {
    final response = await ref
        .read(apiClientProvider)
        .get(AppConstants.sellerDashboard, query: {'filter_type': filter});
    return response;
  }
}

final dashboardRepositoryProvider = Provider<DashboardRepository>((ref) {
  return DashboardRepository(ref: ref);
});
