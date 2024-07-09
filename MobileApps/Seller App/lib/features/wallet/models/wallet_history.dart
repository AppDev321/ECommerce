class WalletHistory {
  WalletHistory({
    required this.id,
    required this.createdAt,
    required this.billNo,
    required this.amount,
    required this.invoiceUrl,
  });
  late final int id;
  late final String createdAt;
  late final String billNo;
  late final String amount;
  late final String invoiceUrl;

  WalletHistory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    billNo = json['bill_no'];
    amount = json['amount'];
    invoiceUrl = json['invoice_url'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['created_at'] = createdAt;
    data['bill_no'] = billNo;
    data['amount'] = amount;
    data['invoice_url'] = invoiceUrl;
    return data;
  }
}
