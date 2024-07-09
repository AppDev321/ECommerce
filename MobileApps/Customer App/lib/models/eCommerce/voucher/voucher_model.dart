class VoucherModel {
  VoucherModel({
    required this.id,
    required this.voucherType,
    required this.code,
    required this.discountType,
    required this.discount,
    required this.minOrderAmount,
    required this.maxDiscountAmount,
    required this.limitForUser,
    required this.shopId,
    required this.started,
    required this.validity,
    required this.isCollected,
  });
  late final int id;
  late final String voucherType;
  late final String code;
  late final String discountType;
  late final double discount;
  late final double minOrderAmount;
  late final double maxDiscountAmount;
  late final int limitForUser;
  late final int shopId;
  late final String started;
  late final String validity;
  late final bool isCollected;

  VoucherModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    voucherType = json['voucher_type'];
    code = json['code'];
    discountType = json['discount_type'];
    discount = json['discount'];
    minOrderAmount = json['min_order_amount'];
    maxDiscountAmount = json['max_discount_amount'];
    limitForUser = json['limit_for_user'];
    shopId = json['shop_id'];
    started = json['started'];
    validity = json['validity'];
    isCollected = json['is_collected'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['voucher_type'] = voucherType;
    data['code'] = code;
    data['discount_type'] = discountType;
    data['discount'] = discount;
    data['min_order_amount'] = minOrderAmount;
    data['max_discount_amount'] = maxDiscountAmount;
    data['limit_for_user'] = limitForUser;
    data['shop_id'] = shopId;
    data['started'] = started;
    data['validity'] = validity;
    data['is_collected'] = isCollected;
    return data;
  }
}
