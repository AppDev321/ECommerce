import 'package:dio/dio.dart';
import 'package:razin_shop/models/eCommerce/cart/add_to_cart_model.dart';

abstract class CartProviderBase {
  Future<Response> addToCart({required AddToCartModel addToCartModel});
  Future<Response> increentQty({required int productId});
  Future<Response> decrementQty({required int productId});
  Future<Response> getAllCarts();
  Future<Response> cartSummery({
    required String? couponId,
    required List<int> shopIds,
  });
  Future<Response> buyNow({
    required int productId,
    required String couponCode,
    required int quantity,
  });
}
