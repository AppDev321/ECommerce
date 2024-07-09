import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:razin_shop/controllers/eCommerce/cart/cart_controller.dart';
import 'package:razin_shop/controllers/eCommerce/voucher/voucher_controller.dart';
import 'package:razin_shop/models/eCommerce/address/add_address.dart';
import 'package:razin_shop/models/eCommerce/cart/cart_product.dart';
import 'package:razin_shop/models/eCommerce/cart/hive_cart_model.dart';
import 'package:razin_shop/models/eCommerce/voucher/voucher_apply_model.dart';

// Bottom Navigation Tab Controller
final bottomTabControllerProvider =
    Provider<PageController>((ref) => PageController());

// All State Provider
final selectedTabIndexProvider = StateProvider<int>((ref) => 0);
final selectedMyOrderIndexProvider = StateProvider<int>((ref) => 0);
final currentPageController = StateProvider<int>((ref) => 0);
final selectedProductColorIndex = StateProvider<int?>((ref) => 0);
final selectedProductSizeIndex = StateProvider<int>((ref) => 0);
final isOnboardingLastPage = StateProvider<bool>((ref) => false);
final obscureText1 = StateProvider<bool>((ref) => true);
final obscureText2 = StateProvider<bool>((ref) => true);
final obscureText3 = StateProvider<bool>((ref) => true);
final selectedDeliveryAddress = StateProvider<AddAddress?>((ref) => null);
final selectedUserProfileImage = StateProvider<XFile?>((ref) => null);
final finalCheckoutProducts = StateProvider<List<HiveCartModel>>((ref) => []);
final selectedPayment = StateProvider<String>((ref) => '');

// Product Filter State
final selectedReviewIndex = StateProvider<int?>((ref) => null);
final selectedSortByIndex = StateProvider<int?>((ref) => null);
final selectedMinPrice = StateProvider<double>((ref) => 0.0);
final selectedMaxPrice = StateProvider<double>((ref) => 4485.0);

class ShopIdsNotifier extends StateNotifier<Set<int>> {
  final Ref ref;
  ShopIdsNotifier(this.ref) : super({});

  void toogleAllShopId() {
    if (state.length < ref.watch(cartController).cartItems.length) {
      for (CartItem cartItem in ref.watch(cartController).cartItems) {
        state = Set<int>.from(state)..add(cartItem.shopId);
      }
    } else {
      state = Set<int>.from(state)..clear();
    }
  }

  void addAllShopIds() {
    for (CartItem cartItem in ref.watch(cartController).cartItems) {
      state = Set<int>.from(state)..add(cartItem.shopId);
    }
  }

  void toggleShopId(int shopId) {
    if (state.contains(shopId)) {
      state = Set<int>.from(state)..remove(shopId);
    } else {
      state = Set<int>.from(state)..add(shopId);
    }
  }

  void clearCalculation() {
    if (state.isNotEmpty) {
      state = Set<int>.from(state)..clear();
      ref.read(finalCheckoutProducts).clear();
      ref.read(subTotalProvider.notifier).calculateSummery();
    }
  }
}

final shopIdsProvider = StateNotifierProvider<ShopIdsNotifier, Set<int>>(
    (ref) => ShopIdsNotifier(ref));

class SubTotalNotifier extends StateNotifier<Map<String, dynamic>> {
  final Ref ref;
  SubTotalNotifier(this.ref)
      : super({
          "subtotal": 0,
          "discount": 0,
          "deliveryCharge": 0,
          "couponDiscount": 0,
          "isCouponApply": false,
        });

  calculateSummery({String? couponCode}) async {
    double subTotal = 0;
    double discount = 0;
    double deliveryCharge = 0;
    Set<int> shopIds = {};
    List<CouponApplyProduct> products = [];

    for (var product in ref.read(finalCheckoutProducts)) {
      subTotal += product.price * product.productsQTY;
      debugPrint('This is a discount value:${product.discountPrice}');
      if (product.discountPrice > 0) {
        discount += (product.currentPrice - product.discountPrice) *
            product.productsQTY;
      }

      products.add(
        CouponApplyProduct(
            id: product.productId,
            quantity: product.productsQTY,
            shopId: product.shopId),
      );

      if (!shopIds.contains(product.shopId)) {
        deliveryCharge += product.deliveryCharge;
        shopIds.add(product.shopId);
      }
    }
    if (products.isNotEmpty &&
        ref.read(finalCheckoutProducts).length == products.length) {
      final VoucherApplyModel voucherApplyModel =
          VoucherApplyModel(couponCode, products);
      ref
          .read(applyVoucherProvider.notifier)
          .applyVoucher(
              voucherApplyModel: voucherApplyModel, showSnakbar: false)
          .then((couponDiscunt) {
        debugPrint("this is a discount price:$couponDiscunt");
        state = {
          "subtotal": subTotal - couponDiscunt.item1,
          "discount": discount,
          "deliveryCharge": deliveryCharge,
          "couponDiscount": couponDiscunt.item1,
          "isCouponApply": couponCode != null && couponDiscunt.item2,
        };
        print("Misc Controller: ${couponDiscunt.item2}");
      });
    } else {
      state = {
        "subtotal": subTotal,
        "discount": discount,
        "deliveryCharge": deliveryCharge,
        "couponDiscount": 0,
        "isCouponApply": false,
      };
    }
  }

  double? getSubTotal() {
    final formattedSubtotal = state["subtotal"]?.toStringAsFixed(2);
    return formattedSubtotal != null
        ? double.tryParse(formattedSubtotal)
        : null;
  }

  double? getDiscount() {
    final formattedDiscount = state["discount"]?.toStringAsFixed(2);
    return formattedDiscount != null
        ? double.tryParse(formattedDiscount)
        : null;
  }

  double? getDeliveryCharge() {
    final formattedDeliveryCharge = state["deliveryCharge"]?.toStringAsFixed(2);
    return formattedDeliveryCharge != null
        ? double.tryParse(formattedDeliveryCharge)
        : null;
  }

  double? getCouponDiscount() {
    final formattedDeliveryCharge = state["couponDiscount"]?.toStringAsFixed(2);
    return formattedDeliveryCharge != null
        ? double.tryParse(formattedDeliveryCharge)
        : null;
  }
}

final subTotalProvider =
    StateNotifierProvider<SubTotalNotifier, Map<String, dynamic>>(
        (ref) => SubTotalNotifier(ref));

class CouponIdsNotifer extends StateNotifier<Set<int>> {
  final Ref ref;
  CouponIdsNotifer(this.ref) : super({});

  void addCouponId({required int couponId}) {
    state = Set<int>.from(state)..add(couponId);
  }
}

final couponIdsProvider =
    StateNotifierProvider.autoDispose<CouponIdsNotifer, Set<int>>(
        (ref) => CouponIdsNotifer(ref));
