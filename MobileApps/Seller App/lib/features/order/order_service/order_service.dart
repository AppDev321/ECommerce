import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:razin_commerce_seller_flutter/features/common/models/common_model.dart';
import 'package:razin_commerce_seller_flutter/features/order/models/order_filter_model.dart';
import 'package:razin_commerce_seller_flutter/features/order/models/order_model.dart';
import 'package:razin_commerce_seller_flutter/features/order/models/order_status_model.dart';
import 'package:razin_commerce_seller_flutter/features/order/providers/order_provider.dart';

class OrderService extends StateNotifier<bool> {
  final Ref ref;
  OrderService({required this.ref}) : super(false);

  late int _totalOrders;

  int get totalOrders => _totalOrders;

  List<Order> _orders = [];

  List<Order> get orders => _orders;

  List<OrderStatusModel> _orderStatusList = [];

  List<OrderStatusModel> get orderStatusList => _orderStatusList;

  Future<void> getOrders({required OrderFilterModel filter}) async {
    state = true;
    try {
      final response =
          await ref.read(orderRepositoryProvider).getOrders(filter: filter);

      _totalOrders = response.data['data']['total_items'];
      List<dynamic> ordersData = response.data['data']['orders'];
      if (filter.page > 1) {
        _orders = [
          ..._orders,
          ...ordersData.map((order) => Order.fromJson(order))
        ];
      } else {
        _orders = ordersData.map((order) => Order.fromJson(order)).toList();
        List<dynamic> ordersStatusData = response.data['data']['status_orders'];
        _orderStatusList = ordersStatusData
            .map((orderStatus) => OrderStatusModel.fromMap(orderStatus))
            .toList();
      }
      state = false;
    } catch (e) {
      state = false;
      debugPrint('Error in getOrders: $e');
    }
  }
}

class OrderStatusService extends StateNotifier<bool> {
  final Ref ref;
  OrderStatusService({required this.ref}) : super(false);

  Future<CommonResponseModel> updateOrderStatus(
      {required int orderId, required String status}) async {
    try {
      state = true;
      final response = await ref
          .read(orderRepositoryProvider)
          .updateOrderStatus(orderId: orderId, status: status);
      final isSucceess = response.statusCode == 200;
      state = false;
      return CommonResponseModel(
          status: isSucceess, message: response.data['message']);
    } catch (e) {
      state = false;
      debugPrint(e.toString());
      return CommonResponseModel(status: false, message: e.toString());
    }
  }
}

class OrderDetailsService extends StateNotifier<AsyncValue<Order>> {
  final Ref ref;
  OrderDetailsService({required this.ref}) : super(const AsyncValue.loading());

  Future<void> getOrderDetails({required int orderId}) async {
    try {
      final response = await ref
          .read(orderRepositoryProvider)
          .getOrderDetails(orderId: orderId);
      state = AsyncValue.data(Order.fromJson(response.data['data']['order']));
    } catch (e) {
      debugPrint(e.toString());
      state = AsyncValue.error(e.toString(), StackTrace.current);
    }
  }
}
