import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:razin_shop/config/app_constants.dart';
import 'package:razin_shop/models/eCommerce/cart/add_to_cart_model.dart';
import 'package:razin_shop/services/base/eCommerce/cart_provider_base.dart';
import 'package:razin_shop/utils/api_client.dart';

class CartService implements CartProviderBase {
  final Ref ref;
  CartService(this.ref);

  @override
  Future<Response> addToCart({required AddToCartModel addToCartModel}) async {
    final response = await ref.read(apiClientProvider).post(
          AppConstants.addToCart,
          data: addToCartModel.toMap(),
        );
    return response;
  }

  @override
  Future<Response> increentQty({required int productId}) async {
    final response = await ref
        .read(apiClientProvider)
        .post(AppConstants.incrementQty, data: {'product_id': productId});

    return response;
  }

  @override
  Future<Response> decrementQty({required int productId}) async {
    final response = await ref
        .read(apiClientProvider)
        .post(AppConstants.decrementQty, data: {
      'product_id': productId,
    });
    return response;
  }

  @override
  Future<Response> cartSummery(
      {required String? couponId, required List<int> shopIds}) async {
    final response = await ref.read(apiClientProvider).post(
      AppConstants.cartSummery,
      data: {
        'coupon_code': couponId,
        'shop_ids': shopIds,
      },
    );
    return response;
  }

  @override
  Future<Response> getAllCarts() async {
    final response =
        await ref.read(apiClientProvider).get(AppConstants.getAllCarts);
    return response;
  }

  @override
  Future<Response> buyNow({
    required int productId,
    required String? couponCode,
    required int quantity,
  }) async {
    final response = await ref.read(apiClientProvider).post(
      AppConstants.buyNow,
      data: {
        'product_id': productId,
        'coupon_code': couponCode,
        'quantity': quantity,
      },
    );
    return response;
  }
}

final cartServiceProvider = Provider((ref) => CartService(ref));
