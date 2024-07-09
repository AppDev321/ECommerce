import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:razin_shop/services/eCommerce/payment/payment_service.dart';

class PaymentController extends StateNotifier<bool> {
  final Ref ref;
  PaymentController(this.ref) : super(false);

  Future<String?> orderPayment({
    required int orderId,
    required String paymentMethod,
  }) async {
    try {
      state = true;
      final response = await ref.read(paymentServiceProvider).orderPayment(
            orderId: orderId,
            paymentMethod: paymentMethod,
          );

      state = false;
      return response.data['data']['order_payment_url'];
    } catch (error) {
      state = false;
      debugPrint(error.toString());
      return null;
    }
  }
}

final paymentControllerProvider =
    StateNotifierProvider<PaymentController, bool>(
        (ref) => PaymentController(ref));
