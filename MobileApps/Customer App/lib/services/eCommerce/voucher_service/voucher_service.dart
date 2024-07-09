import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:razin_shop/config/app_constants.dart';
import 'package:razin_shop/models/eCommerce/voucher/voucher_apply_model.dart';
import 'package:razin_shop/services/base/eCommerce/voucher_provider_base.dart';
import 'package:razin_shop/utils/api_client.dart';

class VoucherService implements VoucherProviderBase {
  final Ref ref;
  VoucherService(this.ref);

  @override
  Future<Response> getVouchers({required int shopId}) async {
    final response =
        await ref.read(apiClientProvider).get(AppConstants.getVoucher, query: {
      'shop_id': shopId,
    });
    return response;
  }

  @override
  Future<Response> collectVoucher({required int couponCode}) async {
    final response = await ref
        .read(apiClientProvider)
        .post(AppConstants.collectVoucher, data: {
      'coupon_id': couponCode,
    });
    return response;
  }

  @override
  Future<Response> applyVoucher(
      {required VoucherApplyModel voucherApplyModel}) async {
    final response = await ref
        .read(apiClientProvider)
        .post(AppConstants.applyVoucher, data: voucherApplyModel.toJson());
    return response;
  }
}

final voucherServiceProvider = Provider((ref) => VoucherService(ref));
