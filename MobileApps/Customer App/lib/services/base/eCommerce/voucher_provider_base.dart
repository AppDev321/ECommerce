import 'package:dio/dio.dart';
import 'package:razin_shop/models/eCommerce/voucher/voucher_apply_model.dart';

abstract class VoucherProviderBase {
  Future<Response> getVouchers({required int shopId});
  Future<Response> collectVoucher({required int couponCode});
  Future<Response> applyVoucher({required VoucherApplyModel voucherApplyModel});
}
