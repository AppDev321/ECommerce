import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:razin_shop/models/eCommerce/category/category.dart';
import 'package:razin_shop/models/eCommerce/common/product_filter_model.dart';
import 'package:razin_shop/models/eCommerce/product/product.dart';
import 'package:razin_shop/models/eCommerce/shop/shop.dart' as shop_model;
import 'package:razin_shop/models/eCommerce/shop/shop_details.dart';
import 'package:razin_shop/models/eCommerce/shop/shop_review.dart';
import 'package:razin_shop/services/eCommerce/shop_service/shop_service.dart';

final shopControllerProvider =
    StateNotifierProvider<ShopController, bool>((ref) {
  return ShopController(ref);
});

class ShopController extends StateNotifier<bool> {
  final Ref ref;
  ShopController(this.ref) : super(false);

  int? _total;
  int? get total => _total;

  List<shop_model.Shop> _shops = [];
  List<shop_model.Shop> get shops => _shops;

  int? _totalShopProducts;
  int? get totalShopProducts => _totalShopProducts;

  List<Product> _products = [];
  List<Product> get products => _products;

  int? _totalReviews;
  int? get totalReviews => _totalReviews;

  AverageRatingPercentage? _averageRatingPercentagew;
  AverageRatingPercentage? get averageRatingPercentagew =>
      _averageRatingPercentagew;

  List<Review> _reviews = [];
  List<Review> get review => _reviews;

  Future<void> getShops({
    required int page,
    required int perPage,
    required bool isPagination,
  }) async {
    try {
      state = true;
      final response = await ref
          .read(shopServiceProvider)
          .getShops(page: page, perPage: perPage);

      _total = response.data['data']['total'];
      final List<dynamic> data = response.data['data']['shops'];
      List<shop_model.Shop> shops =
          data.map((shop) => shop_model.Shop.fromMap(shop)).toList();
      if (isPagination) {
        _shops.addAll(shops);
      } else {
        _shops = shops;
      }
      state = false;
    } catch (error, stackTrace) {
      debugPrint(error.toString());
      debugPrint(stackTrace.toString());
      state = false;
    }
  }

  Future<void> getShopProducts({
    required ProductFilterModel productFilterModel,
    required bool isPagination,
  }) async {
    try {
      state = true;
      final response = await ref
          .read(shopServiceProvider)
          .getProducts(productFilterModel: productFilterModel);
      _totalShopProducts = response.data['data']['total'];
      final List<dynamic> data = response.data['data']['products'];
      List<Product> products =
          data.map((shop) => Product.fromMap(shop)).toList();
      if (isPagination) {
        _products.addAll(products);
      } else {
        _products = products;
      }
      state = false;
    } catch (error, stackTrace) {
      debugPrint(error.toString());
      debugPrint(stackTrace.toString());
      state = false;
    }
  }

  Future<void> getReviews({
    required ProductFilterModel productFilterModel,
    required bool isPagination,
  }) async {
    try {
      state = true;
      final response = await ref
          .read(shopServiceProvider)
          .getShopReviews(productFilterModel: productFilterModel);
      _totalReviews = response.data['data']['total'];

      List<dynamic> reviewsData = response.data['data']['reviews'];
      List<Review> reviews =
          reviewsData.map((review) => Review.fromMap(review)).toList();
      if (isPagination) {
        _reviews.addAll(reviews);
      } else {
        _reviews = reviews;
        _averageRatingPercentagew = AverageRatingPercentage.fromMap(
            response.data['data']['average_rating_percentage']);
      }
      state = false;
    } catch (error, stackTrace) {
      debugPrint(error.toString());
      debugPrint(stackTrace.toString());
      state = false;
    }
  }
}

final shopDetailsControllerProvider = StateNotifierProvider.family
    .autoDispose<ShopDetailsController, AsyncValue<ShopDetails>, int>(
        (ref, shopId) {
  final controller = ShopDetailsController(ref);
  controller.getShopDetails(shopId: shopId);
  return controller;
});

class ShopDetailsController extends StateNotifier<AsyncValue<ShopDetails>> {
  final Ref ref;

  ShopDetailsController(
    this.ref,
  ) : super(const AsyncValue.loading());

  Future<void> getShopDetails({required int shopId}) async {
    try {
      final response =
          await ref.read(shopServiceProvider).getShopDetails(shopId: shopId);
      state = AsyncData(ShopDetails.fromMap(response.data['data']['shop']));
    } catch (error, stackTrace) {
      debugPrint(error.toString());
      state = AsyncError(error, stackTrace);
    }
  }
}

final shopCategoriesControllerProvider = StateNotifierProvider.family
    .autoDispose<ShopCategoriesController, AsyncValue<List<Category>>, int>(
        (ref, shopId) {
  final controller = ShopCategoriesController(ref);
  controller.getShopCategories(shopId: shopId);
  return controller;
});

class ShopCategoriesController
    extends StateNotifier<AsyncValue<List<Category>>> {
  final Ref ref;

  ShopCategoriesController(
    this.ref,
  ) : super(const AsyncValue.loading());

  Future<void> getShopCategories({required int shopId}) async {
    try {
      final response =
          await ref.read(shopServiceProvider).getShopCategories(shopId: shopId);
      final List<dynamic> categoriesData = response.data['data']['categories'];
      state = AsyncData(categoriesData
          .map((category) => Category.fromMap(category))
          .toList());
    } catch (error, stackTrace) {
      debugPrint(error.toString());
      state = AsyncError(error, stackTrace);
    }
  }
}
