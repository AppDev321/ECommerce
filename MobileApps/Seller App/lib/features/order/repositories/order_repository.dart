import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:razin_commerce_seller_flutter/config/app_constants.dart';
import 'package:razin_commerce_seller_flutter/features/order/models/order_filter_model.dart';
import 'package:razin_commerce_seller_flutter/utils/api_client.dart';

abstract class OrderRepositoryInterface {
  Future<Response> getOrders({required OrderFilterModel filter});
  Future<Response> updateOrderStatus({
    required int orderId,
    required String status,
  });
  Future<Response> getOrderDetails({required int orderId});
}

class OrderRepository implements OrderRepositoryInterface {
  final Ref ref;
  OrderRepository({required this.ref});
  @override
  Future<Response> getOrders({required OrderFilterModel filter}) async {
    final response = await ref
        .read(apiClientProvider)
        .get(AppConstants.orders, query: filter.toMap());
    return response;
  }

  @override
  Future<Response> updateOrderStatus(
      {required int orderId, required String status}) async {
    final response = await ref.read(apiClientProvider).post(
        AppConstants.updateOrderStatus,
        data: {'order_id': orderId, 'order_status': status});
    return response;
  }

  @override
  Future<Response> getOrderDetails({required int orderId}) async {
    final response = await ref
        .read(apiClientProvider)
        .get(AppConstants.getOrderDetails, query: {'order_id': orderId});
    return response;
  }
}
