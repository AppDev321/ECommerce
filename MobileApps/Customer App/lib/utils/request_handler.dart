import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:razin_shop/config/app_constants.dart';
import 'package:razin_shop/routes.dart';
import 'package:razin_shop/utils/global_function.dart';

class ApiInterceptors {
  static void addInterceptors(Dio dio) {
    dio.options.connectTimeout = const Duration(seconds: 20);
    dio.options.receiveTimeout = const Duration(seconds: 10);
    dio.options.headers['Accept'] = 'application/json';
    dio.options.headers['Content-Type'] = 'application/json';
    _addLoggerInterceptor(dio);
    _addResponseHandlerInterceptor(dio);
  }

  static void _addLoggerInterceptor(Dio dio) {
    dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
      maxWidth: 90,
    ));
  }

  static void _addResponseHandlerInterceptor(Dio dio) {
    dio.interceptors.add(InterceptorsWrapper(
      onResponse: (response, handler) {
        _handleResponse(response);
        handler.next(response);
      },
      onError: (error, handler) {
        _handleError(error);
        handler.reject(error);
      },
    ));
  }

  static void _handleResponse(Response response) {
    // Handle successful responses, if needed
    final String message = response.data['message'];
    switch (response.statusCode) {
      case 401:
        _handleUnauthorized();
        break;
      case 302:
      case 400:
      case 403:
      case 404:
      case 409:
      case 422:
        GlobalFunction.showCustomSnackbar(
          message: message,
          isSuccess: false,
        );
        break;

      default:
        break;
    }
  }

  static void _handleError(DioException exception) {
    // Handle errors
    switch (exception.type) {
      case DioExceptionType.receiveTimeout:
        GlobalFunction.showCustomSnackbar(
          message: 'Receive time out!',
          isSuccess: false,
        );
      case DioExceptionType.sendTimeout:
        GlobalFunction.showCustomSnackbar(
          message: 'Send time out!',
          isSuccess: false,
        );
      case DioExceptionType.badResponse:
        GlobalFunction.showCustomSnackbar(
          message: 'Bad response!',
          isSuccess: false,
        );
      case DioExceptionType.badCertificate:
        GlobalFunction.showCustomSnackbar(
          message: 'BadCertificate response!',
          isSuccess: false,
        );
      case DioExceptionType.cancel:
        GlobalFunction.showCustomSnackbar(
          message: 'Cancel by server!',
          isSuccess: false,
        );
      case DioExceptionType.connectionError:
        GlobalFunction.showCustomSnackbar(
          message: 'An unknown error occurred',
          isSuccess: false,
        );
      case DioExceptionType.unknown:
        GlobalFunction.showCustomSnackbar(
          message: 'An unknown error occurred',
          isSuccess: false,
        );
        break;
      default:
        GlobalFunction.showCustomSnackbar(
          message: 'An unknown error occurred',
          isSuccess: false,
        );
    }

    if (exception.response != null) {
      final message = exception.response!.data['message'];
      final statusCode = exception.response!.statusCode;
      switch (statusCode) {
        case 401:
          _handleUnauthorized();
          break;
        case 400:
        case 403:
          GlobalFunction.showCustomSnackbar(
            message: message,
            isSuccess: false,
          );
          break;
        default:
          GlobalFunction.showCustomSnackbar(
            message: 'Unexpected error',
            isSuccess: false,
          );
          break;
      }
    }
  }

  static void _handleUnauthorized() {
    Box authBox = Hive.box(AppConstants.authBox);
    authBox.delete(AppConstants.authToken);
    GlobalFunction.navigatorKey.currentState
        ?.pushNamedAndRemoveUntil(Routes.login, (route) => false);
  }
}
