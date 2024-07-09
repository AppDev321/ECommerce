import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:razin_shop/models/eCommerce/common/common_response.dart';
import 'package:razin_shop/models/eCommerce/order/add_product_review_model.dart';
import 'package:razin_shop/models/eCommerce/order/buy_now_order_place.dart';
import 'package:razin_shop/models/eCommerce/order/order_model.dart';
import 'package:razin_shop/models/eCommerce/order/order_place_model.dart';
import 'package:razin_shop/services/eCommerce/order/order_service.dart';
import 'package:razin_shop/utils/global_function.dart';

import '../../../models/eCommerce/order/order_details_model.dart';

final orderControllerProvider =
    StateNotifierProvider<OrderController, bool>((ref) => OrderController(ref));

class OrderController extends StateNotifier<bool> {
  final Ref ref;
  OrderController(this.ref) : super(false);

  int? _totalOrder;
  int? get totalOrder => _totalOrder;
  List<OrderModel> _orders = [];
  List<OrderModel> get orders => _orders;

  Future<CommonResponse> placeOrder(
      {required OrderPlaceModel orderPlaceModel}) async {
    try {
      state = true;
      final response = await ref
          .read(orderServiceProvider)
          .placeOrder(orderPlaceModel: orderPlaceModel);
      final String? url = response.data['data']['order_payment_url'];

      state = false;
      return CommonResponse(
        isSuccess: true,
        message: response.data['message'],
        data: url,
      );
    } catch (error) {
      debugPrint(error.toString());
      state = false;
      return CommonResponse(isSuccess: false, message: error.toString());
    }
  }

  Future<CommonResponse> buyNow(
      {required BuyNowOrderPlace orderPlaceModel}) async {
    try {
      state = true;
      final response = await ref
          .read(orderServiceProvider)
          .buyNow(orderPlaceModel: orderPlaceModel);
      final String? url = response.data['data']['order_payment_url'];

      state = false;
      return CommonResponse(
        isSuccess: true,
        message: response.data['message'],
        data: url,
      );
    } catch (error) {
      debugPrint(error.toString());
      state = false;
      return CommonResponse(isSuccess: false, message: error.toString());
    }
  }

  Future<CommonResponse> orderAgain({required int orderId}) async {
    try {
      state = true;
      final response =
          await ref.read(orderServiceProvider).orderAgain(orderId: orderId);
      final status = response.statusCode == 200 ? true : false;

      state = false;
      return CommonResponse(
        isSuccess: status,
        message: response.data['message'],
      );
    } catch (error) {
      debugPrint(error.toString());
      state = false;
      return CommonResponse(isSuccess: false, message: error.toString());
    }
  }

  Future<void> getOrders({
    required String? orderStatus,
    required int page,
    required int perPage,
    required bool isPagination,
  }) async {
    try {
      state = true;
      final response = await ref.read(orderServiceProvider).getOrders(
            orderStatus: orderStatus,
            page: page,
            perPage: perPage,
          );

      _totalOrder = response.data['data']['total'];
      final List<dynamic> ordersData = response.data['data']['orders'];
      List<OrderModel> orders =
          ordersData.map((order) => OrderModel.fromJson(order)).toList();
      if (isPagination) {
        _orders.addAll(orders);
      } else {
        _orders = orders;
      }
      state = false;
    } catch (error) {
      debugPrint(error.toString());
      state = false;
    }
  }

  Future<CommonResponse> cancelOrder({required int orderId}) async {
    try {
      state = true;
      final response =
          await ref.read(orderServiceProvider).cancelOrder(orderId: orderId);
      state = false;
      return CommonResponse(
        isSuccess: true,
        message: response.data['message'],
      );
    } catch (error) {
      debugPrint(error.toString());
      state = false;
      return CommonResponse(isSuccess: false, message: error.toString());
    }
  }

  Future<CommonResponse> addProudctReview(
      {required AddProductReviewModel productReviewModel}) async {
    try {
      state = true;
      final response = await ref
          .read(orderServiceProvider)
          .addProductReview(addProductReviewModel: productReviewModel);
      state = false;
      GlobalFunction.showCustomSnackbar(
          isSuccess: true, message: response.data['message']);
      return CommonResponse(isSuccess: true, message: response.data['message']);
    } catch (error) {
      debugPrint(error.toString());
      state = false;
      return CommonResponse(isSuccess: false, message: error.toString());
    }
  }
}

final orderDetailsControllerProvider = StateNotifierProvider.family
    .autoDispose<OrderDetailsController, AsyncValue<OrderDetails>, int>(
        (ref, shopId) {
  final controller = OrderDetailsController(ref);
  controller.getOrderDetails(orderId: shopId);
  return controller;
});

class OrderDetailsController extends StateNotifier<AsyncValue<OrderDetails>> {
  final Ref ref;

  OrderDetailsController(
    this.ref,
  ) : super(const AsyncValue.loading());

  Future<void> getOrderDetails({required int orderId}) async {
    try {
      final response = await ref
          .read(orderServiceProvider)
          .getOrderDetails(orderId: orderId);
      state = AsyncData(OrderDetails.fromJson(response.data));
    } catch (error, stackTrace) {
      debugPrint(error.toString());
      state = AsyncError(error, stackTrace);
    }
  }
}
