import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:razin_shop/config/app_constants.dart';
import 'package:razin_shop/models/eCommerce/order/add_product_review_model.dart';
import 'package:razin_shop/models/eCommerce/order/buy_now_order_place.dart';
import 'package:razin_shop/models/eCommerce/order/order_place_model.dart';
import 'package:razin_shop/services/base/eCommerce/order_provider_base.dart';
import 'package:razin_shop/utils/api_client.dart';

class OrderService implements OrderProviderBase {
  final Ref ref;
  OrderService(this.ref);
  @override
  Future<Response> placeOrder(
      {required OrderPlaceModel orderPlaceModel}) async {
    final response = await ref.read(apiClientProvider).post(
          AppConstants.placeOrderV1,
          data: orderPlaceModel.toMap(),
        );
    return response;
  }

  @override
  Future<Response> getOrders({
    required String? orderStatus,
    required int page,
    required int perPage,
  }) async {
    Map<String, dynamic>? query = {};
    query['page'] = page;
    query['per_page'] = perPage;
    if (orderStatus != null) query['order_status'] = orderStatus;
    final response = await ref
        .read(apiClientProvider)
        .get(AppConstants.getOrders, query: query);
    return response;
  }

  @override
  Future<Response> getOrderDetails({required int orderId}) async {
    final response = await ref.read(apiClientProvider).get(
      AppConstants.getOrderDetails,
      query: {
        'order_id': orderId,
      },
    );
    return response;
  }

  @override
  Future<Response> cancelOrder({required int orderId}) async {
    final response =
        await ref.read(apiClientProvider).post(AppConstants.cancelOrder, data: {
      'order_id': orderId,
    });
    return response;
  }

  @override
  Future<Response> addProductReview(
      {required AddProductReviewModel addProductReviewModel}) async {
    final response = await ref.read(apiClientProvider).post(
          AppConstants.addProductReview,
          data: addProductReviewModel.toMap(),
        );
    return response;
  }

  @override
  Future<Response> orderAgain({required int orderId}) async {
    final response =
        await ref.read(apiClientProvider).post(AppConstants.orderAgain, data: {
      'order_id': orderId,
    });
    return response;
  }

  @override
  Future<Response> buyNow({required BuyNowOrderPlace orderPlaceModel}) async {
    final response = await ref.read(apiClientProvider).post(
          AppConstants.buyNowOrderPlace,
          data: orderPlaceModel.toMap(),
        );

    return response;
  }
}

final orderServiceProvider = Provider((ref) => OrderService(ref));
