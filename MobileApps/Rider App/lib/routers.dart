import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:razinshop_rider/views/auth/layouts/confirm_otp_layout.dart';
import 'package:razinshop_rider/views/auth/layouts/create_password_layout.dart';
import 'package:razinshop_rider/views/auth/layouts/forgot_password.dart';
import 'package:razinshop_rider/views/auth/layouts/review_layout.dart';
import 'package:razinshop_rider/views/auth/login_view.dart';
import 'package:razinshop_rider/views/auth/registration_view.dart';
import 'package:razinshop_rider/views/home/components/notifications.dart';
import 'package:razinshop_rider/views/home/components/privacy_policy.dart';
import 'package:razinshop_rider/views/home/components/terms_and_conditions.dart';
import 'package:razinshop_rider/views/home/layouts/change_password.dart';
import 'package:razinshop_rider/views/home/layouts/home_layout.dart';
import 'package:razinshop_rider/views/home/layouts/order_details.dart';
import 'package:razinshop_rider/views/home/layouts/order_history.dart';
import 'package:razinshop_rider/views/splash/splash_view.dart';

class Routes {
  Routes._();
  static const splash = '/';
  static const login = '/login';
  static const registration = '/registration';
  static const confirmOTP = '/confirm-otp';
  static const createPassword = '/create-password';
  static const review = '/review';
  static const home = '/home';
  static const orderDetails = '/order-details';
  static const changePassword = '/change-password';
  static const orderHistory = '/order-history';
  static const forgotPassword = '/forgot-password';
  static const notification = '/notification';
  static const privayPolicay = '/privacy-policy';
  static const termsAndCondition = '/terms-and-condition';
}

Route generatedRoutes(RouteSettings settings) {
  Widget child;

  switch (settings.name) {
    case Routes.splash:
      child = const SplashView();
      break;
    case Routes.login:
      child = const LoginView();
      break;

    case Routes.registration:
      bool isProfileUpdate = settings.arguments as bool? ?? false;
      child = RegistrationView(isProfileUpdate: isProfileUpdate);
      break;

    case Routes.confirmOTP:
      child = ConfirmOTPLayout(
        arguments: settings.arguments as ConfirmOTPScreenArguments,
      );
      break;

    case Routes.createPassword:
      child = CreatePasswordLayout(
        userData: settings.arguments as ConfirmOTPScreenArguments,
      );
      break;

    case Routes.review:
      child = ReviewLayout(
        phoneNumber: settings.arguments as String,
      );
      break;

    case Routes.home:
      child = const HomeLayout();
      break;

    case Routes.orderDetails:
      child = OrderDetailsView(
        orderID: settings.arguments as int,
      );
      break;

    case Routes.changePassword:
      child = ChangePasswordScreen();
      break;

    case Routes.orderHistory:
      child = OrderHistory();
      break;

    case Routes.forgotPassword:
      child = ForgotPassword();
      break;

    case Routes.privayPolicay:
      child = PrivayPolicayView();
      break;
    case Routes.termsAndCondition:
      child = TermsAndConditionsView();
      break;

    case Routes.notification:
      child = NotificationScreen();
      break;

    default:
      throw Exception('Invalid route: ${settings.name}');
  }
  debugPrint('Route: ${settings.name}');

  return PageTransition(
    child: child,
    type: PageTransitionType.fade,
    settings: settings,
    duration: const Duration(milliseconds: 300),
    reverseDuration: const Duration(milliseconds: 300),
  );
}
