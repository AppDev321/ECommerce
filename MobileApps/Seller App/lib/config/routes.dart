import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:razin_commerce_seller_flutter/config/app_color.dart';
import 'package:razin_commerce_seller_flutter/features/auth/screens/confirm_otp.dart';
import 'package:razin_commerce_seller_flutter/features/auth/screens/create_new_password_layout.dart';
import 'package:razin_commerce_seller_flutter/features/auth/screens/forgot_password.dart';
import 'package:razin_commerce_seller_flutter/features/auth/screens/login.dart';
import 'package:razin_commerce_seller_flutter/features/auth/screens/registration.dart';
import 'package:razin_commerce_seller_flutter/features/auth/screens/under_review.dart';
import 'package:razin_commerce_seller_flutter/features/common/screens/date_picker_screen.dart';
import 'package:razin_commerce_seller_flutter/features/common/screens/scaffold_with_nav_bar.dart';
import 'package:razin_commerce_seller_flutter/features/dashboard/screens/dashboard.dart';
import 'package:razin_commerce_seller_flutter/features/order/screens/order_details.dart';
import 'package:razin_commerce_seller_flutter/features/order/screens/orders.dart';
import 'package:razin_commerce_seller_flutter/features/profile/models/profile_details.dart'
    as pd;
import 'package:razin_commerce_seller_flutter/features/profile/screens/banners.dart';
import 'package:razin_commerce_seller_flutter/features/profile/screens/profile.dart';
import 'package:razin_commerce_seller_flutter/features/profile/screens/shop_info.dart';
import 'package:razin_commerce_seller_flutter/features/profile/screens/shop_settings.dart';
import 'package:razin_commerce_seller_flutter/features/profile/screens/user_info.dart';
import 'package:razin_commerce_seller_flutter/features/splash/screens/splash.dart';
import 'package:razin_commerce_seller_flutter/features/wallet/screens/wallet.dart';
import 'package:razin_commerce_seller_flutter/utils/global_function.dart';

class Routes {
  Routes._();
  static const splash = '/';
  static const login = '/login';
  static const registration = '/registration';
  static const createPassword = '/createPassword';
  static const underReview = '/underReview';
  static const forgotPassword = '/forgotPassword';
  static const confirmOTP = '/confirmOTP';
  static const dashboard = '/dashboard';
  static const orders = '/orders';
  static const orderDetails = '/orderDetails';
  static const riders = '/riders';
  static const wallet = '/wallet';
  static const customDatePicker = '/customDatePicker';
  static const profile = '/profile';
  static const userInfo = '/userInfo';
  static const shopInfo = '/shopInfo';
  static const shopSettings = '/shopSettings';
  static const shopBanners = '/shopBanners';
}

final _shellNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter goRouter = GoRouter(
  navigatorKey: GlobalFunction.navigatorKey,
  initialLocation: '/',
  errorPageBuilder: (context, state) => const MaterialPage(
      child: Scaffold(
    body: Center(
      child: Text('Invalid Route'),
    ),
  )),
  routes: <RouteBase>[
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      pageBuilder: (context, state, child) {
        return NoTransitionPage(
            child: ScaffoldWithNavBar(
          location: state.matchedLocation,
          child: child,
        ));
      },
      routes: [
        GoRoute(
          path: Routes.dashboard,
          parentNavigatorKey: _shellNavigatorKey,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: Dashboard(),
          ),
        ),
        GoRoute(
          path: Routes.orders,
          parentNavigatorKey: _shellNavigatorKey,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: Orders(),
          ),
        ),
        GoRoute(
          path: Routes.wallet,
          parentNavigatorKey: _shellNavigatorKey,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: Wallet(),
          ),
        ),
        GoRoute(
          path: Routes.profile,
          parentNavigatorKey: _shellNavigatorKey,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: Profile(),
          ),
        ),
      ],
    ),
    GoRoute(
      name: 'splash',
      path: Routes.splash,
      builder: (BuildContext context, GoRouterState state) => const Splash(),
    ),
    GoRoute(
      name: 'login',
      path: Routes.login,
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          child: const Login(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            var offsetAnimation = animation.drive(
              Tween(begin: const Offset(0.0, 1.0), end: Offset.zero),
            );
            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 600),
          barrierColor: AppStaticColor.black.withOpacity(0.5),
        );
      },
    ),
    GoRoute(
      name: 'registration',
      path: Routes.registration,
      builder: (BuildContext context, GoRouterState state) =>
          const Registration(),
    ),
    GoRoute(
      name: 'createPassword',
      path: Routes.createPassword,
      builder: (BuildContext context, GoRouterState state) {
        final token = state.extra as String?;
        return CreatePassword(
          token: token,
        );
      },
    ),
    GoRoute(
      name: 'underReview',
      path: Routes.underReview,
      builder: (BuildContext context, GoRouterState state) =>
          const UnderReview(),
    ),
    GoRoute(
      name: 'forgotPassword',
      path: Routes.forgotPassword,
      builder: (BuildContext context, GoRouterState state) =>
          const ForgotPassowrd(),
    ),
    GoRoute(
      name: 'confirmOTP',
      path: Routes.confirmOTP,
      builder: (BuildContext context, GoRouterState state) {
        final email = state.extra as String;
        return ConfirmOTP(
          email: email,
        );
      },
    ),
    GoRoute(
      name: 'orderDetails',
      path: Routes.orderDetails,
      builder: (BuildContext context, GoRouterState state) {
        final orderId = state.extra;
        return OrderDetails(orderId as int);
      },
    ),
    GoRoute(
      name: 'customDatePicker',
      path: Routes.customDatePicker,
      builder: (BuildContext context, GoRouterState state) =>
          const CustomDatePicker(),
    ),
    GoRoute(
      name: 'userInfo',
      path: Routes.userInfo,
      builder: (BuildContext context, GoRouterState state) {
        final userInfo = state.extra as pd.UserAccountDetails;
        return UserInfoScreen(
          userInfo: userInfo,
        );
      },
    ),
    GoRoute(
      name: Routes.shopInfo,
      path: Routes.shopInfo,
      builder: (BuildContext context, GoRouterState state) {
        final userInfo = state.extra as pd.UserAccountDetails;
        return ShopInfoScreen(
          profileDetails: userInfo,
        );
      },
    ),
    GoRoute(
      name: Routes.shopSettings,
      path: Routes.shopSettings,
      builder: (BuildContext context, GoRouterState state) {
        final userInfo = state.extra as pd.UserAccountDetails;
        return ShopSettingsScreen(
          userAccountDetails: userInfo,
        );
      },
    ),
    GoRoute(
      name: Routes.shopBanners,
      path: Routes.shopBanners,
      builder: (BuildContext context, GoRouterState state) {
        final userInfo = state.extra as pd.UserAccountDetails;
        return BannersScreen(
          profileDetails: userInfo,
        );
      },
    ),
  ],
);
