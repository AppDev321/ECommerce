import 'package:dio/dio.dart';

abstract class MasterProviderBase {
  Future<Response> getMasterSettings();
}
