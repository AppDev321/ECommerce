import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:razin_shop/controllers/misc/misc_controller.dart';
import 'package:razin_shop/models/eCommerce/cart/add_to_cart_model.dart';
import 'package:razin_shop/models/eCommerce/cart/cart_product.dart';
import 'package:razin_shop/services/eCommerce/cart_service/cart_service.dart';
import 'package:razin_shop/utils/global_function.dart';

class CartController extends StateNotifier<CartState> {
  final Ref ref;
  CartController(this.ref) : super(CartState(isLoading: false, cartItems: []));

  List<CartItem> _cartItems = [];
  List<CartItem> get cartItems => _cartItems;

  Future<void> addToCart({
    required AddToCartModel addToCartModel,
  }) async {
    state = CartState(isLoading: true, cartItems: cartItems);
    try {
      final response = await ref
          .read(cartServiceProvider)
          .addToCart(addToCartModel: addToCartModel);
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data']['cart_items'];
        _cartItems =
            data.map((cartItem) => CartItem.fromJson(cartItem)).toList();
        ref.read(shopIdsProvider.notifier).toogleAllShopId();
      }
      GlobalFunction.showCustomSnackbar(
        message: response.data['message'],
        isSuccess: response.statusCode == 200 ? true : false,
      );
      state = CartState(isLoading: false, cartItems: cartItems);
    } catch (error) {
      state = CartState(isLoading: false, cartItems: cartItems);
      debugPrint(error.toString());
    }
  }

  Future<void> increment({required int productId}) async {
    try {
      state = CartState(isLoading: true, cartItems: cartItems);
      final response =
          await ref.read(cartServiceProvider).increentQty(productId: productId);
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data']['cart_items'];
        _cartItems =
            data.map((cartItem) => CartItem.fromJson(cartItem)).toList();
      }
      // GlobalFunction.showCustomSnackbar(
      //   message: response.data['message'],
      //   isSuccess: response.statusCode == 200 ? true : false,
      // );
      state = CartState(isLoading: false, cartItems: cartItems);
    } catch (error) {
      state = CartState(isLoading: false, cartItems: cartItems);
      debugPrint(error.toString());
    }
  }

  Future<void> decrement({required int productId}) async {
    try {
      state = CartState(isLoading: true, cartItems: cartItems);
      final response = await ref
          .read(cartServiceProvider)
          .decrementQty(productId: productId);
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data']['cart_items'];
        _cartItems =
            data.map((cartItem) => CartItem.fromJson(cartItem)).toList();
      }
      // GlobalFunction.showCustomSnackbar(
      //   message: response.data['message'],
      //   isSuccess: response.statusCode == 200 ? true : false,
      // );
      state = CartState(isLoading: false, cartItems: cartItems);
    } catch (error) {
      state = CartState(isLoading: false, cartItems: cartItems);

      debugPrint(error.toString());
    }
  }

  Future<void> getAllCarts() async {
    try {
      final response = await ref.read(cartServiceProvider).getAllCarts();
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data']['cart_items'];
        _cartItems =
            data.map((cartItem) => CartItem.fromJson(cartItem)).toList();
      }
      state = CartState(isLoading: false, cartItems: cartItems);
    } catch (error) {
      state = CartState(isLoading: false, cartItems: cartItems);

      debugPrint(error.toString());
    }
  }
}

final cartController = StateNotifierProvider<CartController, CartState>(
    (ref) => CartController(ref));

class CartSummeryController extends StateNotifier<Map<String, dynamic>> {
  final Ref ref;
  CartSummeryController(this.ref)
      : super({
          "totalAmount": 0.0,
          "payableAmount": 0.0,
          "discount": 0.0,
          "deliveryCharge": 0.0,
          "applyCoupon": false,
        });

  Future<void> calculateCartSummery({
    required String? couponCode,
    required List<int> shopIds,
    bool showSnackbar = false,
  }) async {
    try {
      final response = await ref.read(cartServiceProvider).cartSummery(
            couponId: couponCode,
            shopIds: shopIds,
          );
      if (response.statusCode == 200) {
        state = {
          'totalAmount': response.data['data']['checkout']['total_amount'],
          'payableAmount': response.data['data']['checkout']['payable_amount'],
          'discount': response.data['data']['checkout']['coupon_discount'],
          'deliveryCharge': response.data['data']['checkout']
              ['delivery_charge'],
          'applyCoupon': response.data['data']['apply_coupon'],
        };
      }
      if (showSnackbar) {
        GlobalFunction.showCustomSnackbar(
          message: response.data['message'],
          isSuccess: response.data['data']['apply_coupon'],
        );
      }
    } catch (error) {
      debugPrint(error.toString());
    }
  }
}

final cartSummeryController =
    StateNotifierProvider<CartSummeryController, Map<String, dynamic>>(
        (ref) => CartSummeryController(ref));

class BuyNowSummeryController extends StateNotifier<Map<String, dynamic>> {
  final Ref ref;
  BuyNowSummeryController(this.ref)
      : super({
          "totalAmount": 0.0,
          "payableAmount": 0.0,
          "discount": 0.0,
          "deliveryCharge": 0.0,
          "applyCoupon": false,
        });

  Future<void> calculateCartSummery({
    required String? couponCode,
    required int productId,
    required int quantity,
    bool showSnackbar = false,
  }) async {
    try {
      final response = await ref.read(cartServiceProvider).buyNow(
            couponCode: couponCode,
            productId: productId,
            quantity: quantity,
          );
      if (response.statusCode == 200) {
        state = {
          'totalAmount': response.data['data']['total_amount'],
          'payableAmount': response.data['data']['total_payable_amount'],
          'discount': response.data['data']['coupon_discount'],
          'deliveryCharge': response.data['data']['delivery_charge'],
          'applyCoupon': response.data['data']['apply_coupon'],
        };
      }
      if (showSnackbar) {
        GlobalFunction.showCustomSnackbar(
          message: response.data['message'],
          isSuccess: response.data['data']['apply_coupon'],
        );
      }
    } catch (error) {
      debugPrint(error.toString());
    }
  }
}

final buyNowSummeryController =
    StateNotifierProvider<BuyNowSummeryController, Map<String, dynamic>>(
        (ref) => BuyNowSummeryController(ref));

class CartState {
  final bool isLoading;
  final List<CartItem> cartItems;
  CartState({
    required this.isLoading,
    required this.cartItems,
  });
}
