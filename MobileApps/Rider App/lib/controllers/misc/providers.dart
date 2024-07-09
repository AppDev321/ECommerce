import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedDate = StateProvider<DateTime?>((ref) => null);
final isSearchActiveProvider = StateProvider<bool>((ref) => false);

enum TodoListFilter {
  all,
  pending,
  delivered,
}

final orderHistoryFilterProvider = StateProvider((ref) => TodoListFilter.all);
final selectedDateFilter = StateProvider<String>((ref) => '');

final slideButtonLeftPosition = AutoDisposeStateProvider<double>((ref) => 0.0);
final slideButtonComplete = AutoDisposeStateProvider<bool>((ref) => false);
final buttonText = StateProvider<String>((ref) => '');
