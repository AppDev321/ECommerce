import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:razin_shop/models/eCommerce/common/common_response.dart';
import 'package:razin_shop/models/eCommerce/voucher/voucher_apply_model.dart';
import 'package:razin_shop/models/eCommerce/voucher/voucher_model.dart';
import 'package:razin_shop/services/eCommerce/voucher_service/voucher_service.dart';
import 'package:razin_shop/utils/global_function.dart';
import 'package:tuple/tuple.dart';

final voucherControllerProvider =
    StateNotifierProvider<VoucherController, bool>(
        (ref) => VoucherController(ref));

class VoucherController extends StateNotifier<bool> {
  final Ref ref;
  VoucherController(this.ref) : super(false);

  List<VoucherModel> _voucherList = [];
  List<VoucherModel> get voucherList => _voucherList;

  Future<void> getVoucher({required int shopId}) async {
    try {
      state = true;
      final response =
          await ref.read(voucherServiceProvider).getVouchers(shopId: shopId);
      final List<dynamic> voucherData = response.data['data']['coupons'];
      _voucherList =
          voucherData.map((voucher) => VoucherModel.fromJson(voucher)).toList();

      state = false;
    } catch (error) {
      state = false;
      debugPrint(error.toString());
    }
  }
}

final voucherCollectProvider =
    StateNotifierProvider<VoucherCollectController, bool>(
        (ref) => VoucherCollectController(ref));

class VoucherCollectController extends StateNotifier<bool> {
  final Ref ref;
  VoucherCollectController(this.ref) : super(false);

  Future<CommonResponse> collectVoucher({required int voucherId}) async {
    try {
      state = true;
      final response = await ref
          .read(voucherServiceProvider)
          .collectVoucher(couponCode: voucherId);
      final statusCode = response.statusCode;
      final message = response.data['message'];
      GlobalFunction.showCustomSnackbar(message: message, isSuccess: true);
      state = false;
      return CommonResponse(
        isSuccess: statusCode == 200 ? true : false,
        message: message,
      );
    } catch (error) {
      debugPrint(error.toString());
      state = false;
      return CommonResponse(
        isSuccess: false,
        message: error.toString(),
      );
    }
  }
}

final applyVoucherProvider =
    StateNotifierProvider<ApplyVoucherController, bool>(
        (ref) => ApplyVoucherController(ref));

class ApplyVoucherController extends StateNotifier<bool> {
  final Ref ref;
  ApplyVoucherController(this.ref) : super(false);

  Map<String, dynamic> data = {};

  Future<Tuple2> applyVoucher({
    required VoucherApplyModel voucherApplyModel,
    required bool showSnakbar,
  }) async {
    try {
      state = true;

      final response = await ref
          .read(voucherServiceProvider)
          .applyVoucher(voucherApplyModel: voucherApplyModel);
      data = response.data['data'];
      final double dicountValue =
          response.data['data']['total_discount_amount'];
      if (response.statusCode == 200) {
        return Tuple2<double, bool>(dicountValue, true);
      }
      if (showSnakbar == true) {
        GlobalFunction.showCustomSnackbar(
            message: response.data['message'],
            isSuccess: response.statusCode == 200);
      }
      state = false;
      return Tuple2<double, bool>(dicountValue, false);
    } catch (error) {
      debugPrint(error.toString());
      state = false;
      return const Tuple2<double, bool>(0.0, false);
    }
  }
}
