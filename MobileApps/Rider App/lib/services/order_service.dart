import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:razinshop_rider/config/app_constants.dart';
import 'package:razinshop_rider/utils/api_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'order_service.g.dart';

@riverpod
OrderService orderService(OrderServiceRef ref) {
  return OrderService(ref);
}

abstract class OrderRepo {
  Future<Response> getOrders({required int page, required int perPage});
  Future<Response> getOrderDetails(int orderId);
  Future<Response> updateOrderStatus({required int orderId});
  Future<Response> orderHistory({String? query, String? status, String? date,int? page,int? perPage});
}

class OrderService implements OrderRepo {
  final Ref ref;
  OrderService(this.ref);

  @override
  Future<Response> getOrders({required int page, required int perPage}) async {
    return await ref
        .read(apiClientProvider)
        .get(AppConstants.ordersUrl, query: {
      'page': page,
      'per_page': perPage,
    });
  }

  @override
  Future<Response> getOrderDetails(int orderId) {
    return ref
        .read(apiClientProvider)
        .get(AppConstants.orderDetailsUrl, query: {'order_id': orderId});
  }

  @override
  Future<Response> updateOrderStatus({required int orderId}) {
    return ref
        .read(apiClientProvider)
        .post(AppConstants.orderStatusUpdateUrl, data: {'order_id': orderId});
  }

  @override
  Future<Response> orderHistory({String? query, String? status, String? date,int? page,int? perPage}) {
    if (status != null) {
      return ref
          .read(apiClientProvider)
          .get(AppConstants.myOrders, query: {'order_status': status});
    }
    if (query != null) {
      return ref
          .read(apiClientProvider)
          .get(AppConstants.myOrders, query: {'search': query});
    }
    if (date != null) {
      return ref
          .read(apiClientProvider)
          .get(AppConstants.myOrders, query: {'start_date': date});
    }
    return ref.read(apiClientProvider).get(AppConstants.myOrders, query: {
      'page': page,
      'per_page': perPage,
    });
  }
}
