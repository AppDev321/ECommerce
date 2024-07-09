import 'package:dio/dio.dart';

abstract class CategoryProviderBase {
  Future<Response> getCategories();
}
