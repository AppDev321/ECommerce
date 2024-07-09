import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:razin_commerce_seller_flutter/features/order/models/order_model.dart';
import 'package:razin_commerce_seller_flutter/features/order/order_service/order_service.dart';
import 'package:razin_commerce_seller_flutter/features/order/repositories/order_repository.dart';

// Order repository provider

final orderRepositoryProvider = Provider<OrderRepository>((ref) {
  return OrderRepository(ref: ref);
});

// Order service provider

final orderServiceProvider = StateNotifierProvider<OrderService, bool>((ref) {
  return OrderService(ref: ref);
});

final orderStatusProvider =
    StateNotifierProvider<OrderStatusService, bool>((ref) {
  return OrderStatusService(ref: ref);
});

final orderDetailsServiceProvider = StateNotifierProvider.family
    .autoDispose<OrderDetailsService, AsyncValue<Order>, int>((ref, orderId) {
  final service = OrderDetailsService(ref: ref);
  service.getOrderDetails(orderId: orderId);
  return service;
});
