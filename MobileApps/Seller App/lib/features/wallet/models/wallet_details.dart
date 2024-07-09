class WalletDetails {
  WalletDetails({
    required this.totalSales,
    required this.commission,
    required this.profit,
    required this.lifetimeSales,
    required this.withdrawableAmount,
    required this.growthPercentage,
  });
  late final String totalSales;
  late final String commission;
  late final String profit;
  late final String lifetimeSales;
  late final String withdrawableAmount;
  late final String growthPercentage;
  late final double minWithdrawableAmount;
  late final bool isWithdrawable;
  late final PendingWithdraw? pendingWithdraw;

  WalletDetails.fromJson(Map<String, dynamic> json) {
    totalSales = json['total_sales'];
    commission = json['commission'];
    profit = json['profit'];
    lifetimeSales = json['lifetime_sales'];
    withdrawableAmount = json['withdrawable_amount'];
    growthPercentage = json['growth_percentage'];
    minWithdrawableAmount = json['min_withdraw_amount'];
    isWithdrawable = json['is_withdrawable'];
    pendingWithdraw = json['pending_withdraw'] != null
        ? PendingWithdraw.fromJson(json['pending_withdraw'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['total_sales'] = totalSales;
    data['commission'] = commission;
    data['profit'] = profit;
    data['lifetime_sales'] = lifetimeSales;
    data['withdrawable_amount'] = withdrawableAmount;
    data['growth_percentage'] = growthPercentage;
    data['min_withdraw_amount'] = minWithdrawableAmount;
    data['is_withdrawable'] = isWithdrawable;
    data['pending_withdraw'] = pendingWithdraw?.toJson();
    return data;
  }
}

class PendingWithdraw {
  PendingWithdraw({
    required this.id,
    required this.createdAt,
    required this.billNo,
    required this.amount,
    required this.status,
    required this.reason,
  });
  late final int id;
  late final String createdAt;
  late final String billNo;
  late final String amount;
  late final String status;
  late final String reason;

  PendingWithdraw.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    billNo = json['bill_no'];
    amount = json['amount'];
    status = json['status'];
    reason = json['reason'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['created_at'] = createdAt;
    data['bill_no'] = billNo;
    data['amount'] = amount;
    data['status'] = status;
    data['reason'] = reason;
    return data;
  }
}
