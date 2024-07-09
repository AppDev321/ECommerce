import 'package:dio/dio.dart';
import 'package:razin_shop/models/eCommerce/common/product_filter_model.dart';

abstract class ShopProviderBase {
  Future<Response> getShops({required int page, required int perPage});
  Future<Response> getShopDetails({required int shopId});
  Future<Response> getProducts(
      {required ProductFilterModel productFilterModel});
  Future<Response> getShopCategories({required int shopId});
  Future<Response> getShopReviews(
      {required ProductFilterModel productFilterModel});
}
