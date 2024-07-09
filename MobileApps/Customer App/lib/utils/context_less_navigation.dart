import 'package:flutter/material.dart';
import 'package:razin_shop/utils/global_function.dart';

class ContextLess {
  ContextLess._();
  static final GlobalKey<NavigatorState> navigatorkey =
      GlobalKey<NavigatorState>();

  static NavigatorState get nav {
    return Navigator.of(GlobalFunction.navigatorKey.currentContext!);
  }

  static BuildContext get context {
    return GlobalFunction.navigatorKey.currentContext!;
  }
}

//allows navigation with context.nav
extension EasyNavigator on BuildContext {
  NavigatorState get nav {
    return Navigator.of(this);
  }
}
