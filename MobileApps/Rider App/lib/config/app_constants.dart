class AppConstants {
  // API Constants
  static const String baseUrl = 'https://lrvl.techcross.co/api';
  // static const String baseUrl = 'https://razin-commerce.razinsoft.com/api';
  static const String loginUrl = '$baseUrl/rider/login';
  static const String logoutUrl = '$baseUrl/rider/logout';
  static const String sendOTPUrl = '$baseUrl/rider/send-otp';
  static const String verifyOTPUrl = '$baseUrl/rider/verify-otp';
  static const String registrationUrl = '$baseUrl/rider/register';
  static const String checkUserStatusUrl = '$baseUrl/rider/check-user-status';
  static const String ordersUrl = '$baseUrl/rider/orders';
  static const String orderDetailsUrl = '$baseUrl/rider/orders/details';
  static const String createPassowrdUrl = '$baseUrl/rider/create-password';
  static const String orderStatusUpdateUrl =
      '$baseUrl/rider/orders/status-update';
  static const String userDetails = '$baseUrl/rider/details';
  static const String privacyPolicy = '$baseUrl/legal-pages/privacy-policy';
  static const String termsAndConditions =
      '$baseUrl/legal-pages/terms-and-conditions';
  static const String myOrders = '$baseUrl/rider/my-orders';
  static const String changePassword = '$baseUrl/rider/change-password';
  static const String master = '$baseUrl/master';

  // Hive Box
  static const String appSettingsBox = 'appSettings';
  static const String authBox = 'authBox';

  // Settings veriable Names
  static const String appLocal = 'appLocal';
  static const String isDarkTheme = 'isDarkTheme';
  static const String primaryColor = 'primaryColor';
  static const String currency = 'currency';

  // Auth Variable Names
  static const String authToken = 'token';
  static const String userData = 'userData';
  static const String? isInReview = 'isInReview';
}
