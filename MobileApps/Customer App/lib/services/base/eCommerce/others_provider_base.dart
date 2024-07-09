import 'package:dio/dio.dart';

abstract class OtherProviderBase {
  Future<Response> getTermsAndConditions();
  Future<Response> getPrivacyPolicy();
  Future<Response> getRefundPolicy();
  Future<Response> support({required String subject, required String message});
  Future<Response> getContactUsinfo();
}
