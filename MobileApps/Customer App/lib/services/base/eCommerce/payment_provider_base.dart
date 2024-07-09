import 'package:dio/dio.dart';

abstract class PaymentProviderBase {
  Future<Response> orderPayment({
    required int orderId,
    required String paymentMethod,
  });
}
