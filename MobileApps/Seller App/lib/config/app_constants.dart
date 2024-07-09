class AppConstants {
  static String baseUrl = 'https://lrvl.techcross.co/api';
  // static String baseUrl = 'https://razin-commerce.razinsoft.com/api';
  static String sendOTP = '$baseUrl/seller/send-otp';
  static String verifyOTP = '$baseUrl/seller/verify-otp';
  static String signUp = '$baseUrl/seller/registration';
  static String login = '$baseUrl/seller/login';
  static String forgotPassword = '$baseUrl/seller/forgot-password';
  static String checkUserStatus = '$baseUrl/seller/check-user-status';
  static String orders = '$baseUrl/seller/orders';
  static String updateOrderStatus = '$baseUrl/seller/orders/status-update';
  static String getOrderDetails = '$baseUrl/seller/orders/details';
  static String walletDetails = '$baseUrl/seller/wallet';
  static String walletHistory = '$baseUrl/seller/wallet/history';
  static String sellerDashboard = '$baseUrl/seller/dashboard';
  static String withdrawWallet = '$baseUrl/seller/wallet/withdraw';
  static String profileDetails = '$baseUrl/seller/details';
  static String updateUserInfo = '$baseUrl/seller/user-update';
  static String updateShopInfo = '$baseUrl/seller/shop-update';
  static String updateShopSettings = '$baseUrl/seller/shop-setting-update';
  static String banners = '$baseUrl/seller/banners';
  static String updateBanner = '$baseUrl/seller/banners/update';
  static String addNewBanner = '$baseUrl/seller/banners/store';
  static String master = '$baseUrl/master';

  // hive constants
  // Box Names
  static const String appSettingsBox = 'appSettings';
  static const String authBox = 'laundrySeller_authBox';
  static const String userBox = 'laundrySeller_userBox';
  static const String cartModelBox = 'hive_cart_model_box';

  // Settings Veriable Names
  static const String firstOpen = 'firstOpen';
  static const String appLocal = 'appLocal';
  static const String isDarkTheme = 'isDarkTheme';
  static const String phone = 'phone';
  static const String primaryColor = 'primaryColor';

  // Auth Variable Names
  static const String authToken = 'token';

  // User Variable Names
  static const String userData = 'userData';
  static const String storeData = 'storeData';
  static const String cartData = 'cartData';
  static const String defaultAddress = 'defaultAddress';

  static String appCurrency = "\$";
  static String appServiceName = 'ecommerce';
}
