import 'package:razin_commerce_seller_flutter/features/wallet/models/wallet_details.dart';

class DashboardDataModel {
  DashboardDataModel({
    required this.pendingOrder,
    required this.toPickupOrder,
    required this.todayOrder,
    required this.toDeliveryOrder,
    required this.thisManthSales,
    required this.walletBalance,
    required this.maxChartAmount,
    required this.minChartAmount,
    required this.salesChartMonths,
    required this.salesChartValues,
  });
  late final int pendingOrder;
  late final int toPickupOrder;
  late final int todayOrder;
  late final int toDeliveryOrder;
  late final String thisManthSales;
  late final String walletBalance;
  late final PendingWithdraw? pendingWithdraw;
  late final double maxChartAmount;
  late final double minChartAmount;
  late final List<String> salesChartMonths;
  late final List<double> salesChartValues;

  DashboardDataModel.fromJson(Map<String, dynamic> json) {
    pendingOrder = json['pending_order'];
    toPickupOrder = json['to_pickup_order'];
    todayOrder = json['today_order'];
    toDeliveryOrder = json['to_delivery_order'];
    thisManthSales = json['this_manth_sales'];
    walletBalance = json['wallet_balance'];
    pendingWithdraw = json['pending_withdraw'] != null
        ? PendingWithdraw.fromJson(json['pending_withdraw'])
        : null;
    maxChartAmount = json['max_chart_amount'];
    minChartAmount = json['min_chart_amount'];
    salesChartMonths =
        List.castFrom<dynamic, String>(json['sales_chart_months']);
    salesChartValues =
        List.castFrom<dynamic, double>(json['sales_chart_values']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['pending_order'] = pendingOrder;
    data['to_pickup_order'] = toPickupOrder;
    data['today_order'] = todayOrder;
    data['to_delivery_order'] = toDeliveryOrder;
    data['this_manth_sales'] = thisManthSales;
    data['wallet_balance'] = walletBalance;
    data['pending_withdraw'] = pendingWithdraw?.toJson();
    data['max_chart_amount'] = maxChartAmount;
    data['min_chart_amount'] = minChartAmount;
    data['sales_chart_months'] = salesChartMonths;
    data['sales_chart_values'] = salesChartValues;
    return data;
  }
}
