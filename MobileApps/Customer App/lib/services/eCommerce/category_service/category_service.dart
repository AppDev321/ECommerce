import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:razin_shop/config/app_constants.dart';
import 'package:razin_shop/services/base/eCommerce/category_provider_base.dart';
import 'package:razin_shop/utils/api_client.dart';

class CategoryService implements CategoryProviderBase {
  final Ref ref;
  CategoryService(this.ref);
  @override
  Future<Response> getCategories() async {
    final response =
        await ref.read(apiClientProvider).get(AppConstants.getCategories);
    return response;
  }
}

final categoryServiceProvider = Provider((ref) => CategoryService(ref));
