import 'package:flutter/cupertino.dart';

class ContextLess {
  ContextLess._();
  static final GlobalKey<NavigatorState> navigatorkey =
      GlobalKey<NavigatorState>();

  static NavigatorState get nav {
    return Navigator.of(navigatorkey.currentContext!);
  }

  static BuildContext get context {
    return navigatorkey.currentContext!;
  }
}

extension EasyNavigator on BuildContext {
  NavigatorState get nav {
    return Navigator.of(this);
  }
}
