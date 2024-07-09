class ShopSettingsUpdateModel {
  final int estimatedDeliveryTime;
  final String openingTime;
  final String closingTime;
  final List<String> offDays;
  final String orderPrefix;
  final String minimumOrderAmount;

  ShopSettingsUpdateModel({
    required this.estimatedDeliveryTime,
    required this.openingTime,
    required this.closingTime,
    required this.offDays,
    required this.orderPrefix,
    required this.minimumOrderAmount,
  });

  Map<String, dynamic> toJson() => {
        'estimated_delivery_time': estimatedDeliveryTime,
        'opening_time': openingTime,
        'closing_time': closingTime,
        'off_day': offDays,
        'prefix': orderPrefix,
        'min_order_amount': minimumOrderAmount
      };
}
