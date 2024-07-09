import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:razin_shop/models/eCommerce/category/category.dart';
import 'package:razin_shop/services/eCommerce/category_service/category_service.dart';

final categoryControllerProvider =
    StateNotifierProvider<CategoryController, AsyncValue<List<Category>>>(
        (ref) {
  final controller = CategoryController(ref);
  controller.getCategories();
  return controller;
});

class CategoryController extends StateNotifier<AsyncValue<List<Category>>> {
  final Ref ref;
  CategoryController(this.ref) : super(const AsyncLoading());

  Future<void> getCategories() async {
    try {
      final response = await ref.read(categoryServiceProvider).getCategories();
      final List<dynamic> data = response.data['data']['categories'];
      List<Category> categories =
          data.map((category) => Category.fromMap(category)).toList();
      state = AsyncData(categories);
    } catch (error, stackTrace) {
      debugPrint(error.toString());
      state = AsyncError(error.toString(), stackTrace);
    }
  }
}
