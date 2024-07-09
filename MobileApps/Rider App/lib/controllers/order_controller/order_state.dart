import 'package:razinshop_rider/models/order_model/order.dart';

class OrderState {
  final int todoOrder;
  final int completedOrder;
  final int total;
  final List<Order> orders;

  OrderState(
      {required this.todoOrder,
      required this.completedOrder,
      required this.total,
      required this.orders});

  OrderState copyWith(
      {int? todoOrder, int? completedOrder, List<Order>? orders}) {
    return OrderState(
        todoOrder: todoOrder ?? this.todoOrder,
        completedOrder: completedOrder ?? this.completedOrder,
        total: total,
        orders: orders ?? this.orders);
  }
}

class OrderHistoryState {
  final int allOrder;
  final int toDeliver;
  final int delivered;
  final int? total;
  final List<Order> orders;

  OrderHistoryState(
      {required this.allOrder,
      required this.toDeliver,
      required this.delivered,
      this.total,
      required this.orders});

  OrderHistoryState copyWith(
      {int? allOrder, int? toDeliver, int? delivered, List<Order>? orders}) {
    return OrderHistoryState(
        allOrder: allOrder ?? this.allOrder,
        toDeliver: toDeliver ?? this.toDeliver,
        delivered: delivered ?? this.delivered,
        orders: orders ?? this.orders);
  }
}
