import 'package:dio/dio.dart';

abstract class DashboardProviderBase {
  Future<Response> getDashboardData();
}
