import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:razin_shop/config/app_constants.dart';
import 'package:razin_shop/models/eCommerce/common/product_filter_model.dart';
import 'package:razin_shop/services/base/eCommerce/product_service_base.dart';
import 'package:razin_shop/utils/api_client.dart';

class ProductService implements ProductProviderBase {
  final Ref ref;
  ProductService(this.ref);
  @override
  Future<Response> getCategoryWiseProducts(
      {required ProductFilterModel productFilterModel}) async {
    final response = await ref.read(apiClientProvider).get(
          AppConstants.getCategoryWiseProducts,
          query: productFilterModel.toMap(),
        );
    return response;
  }

  @override
  Future<Response> getProductDetails({required int productId}) async {
    final response = await ref.read(apiClientProvider).get(
      AppConstants.getProductDetails,
      query: {"product_id": productId},
    );
    return response;
  }

  @override
  Future<Response> favoriteProductAddRemove({required int productId}) async {
    final response = await ref.read(apiClientProvider).post(
      AppConstants.productFavoriteAddRemoveUrl,
      data: {'product_id': productId},
    );
    return response;
  }

  @override
  Future<Response> getFavoriteProducts() async {
    final response =
        await ref.read(apiClientProvider).get(AppConstants.getFavoriteProducts);
    return response;
  }
}

final productServiceProvider = Provider((ref) => ProductService(ref));
