import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:razinshop_rider/config/app_color.dart';
import 'package:razinshop_rider/config/app_constants.dart';
import 'package:razinshop_rider/config/theme.dart';
import 'package:razinshop_rider/routers.dart';
import 'package:razinshop_rider/utils/global_function.dart';

import 'generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox(AppConstants.authBox);
  await Hive.openBox(AppConstants.appSettingsBox);
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  Locale resolveLocale(String? langCode) {
    if (langCode != null) {
      return Locale(langCode);
    } else {
      return const Locale('en');
    }
  }

  @override
  Widget build(BuildContext context) {
    GlobalFunction.changeStatusBarTheme(isDark: false);
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, _) {
          return ValueListenableBuilder(
              valueListenable:
                  Hive.box(AppConstants.appSettingsBox).listenable(),
              builder: (context, appSetting, _) {
                final primaryColor = appSetting.get(AppConstants.primaryColor);
                if (primaryColor != null) {
                  AppColor.primaryColor = hexToColor(primaryColor);
                }
                final selectedLocal = appSetting.get(AppConstants.appLocal);
                return MaterialApp(
                  title: 'Ready Rider',
                  theme: AppTheme.lightTheme,
                  localizationsDelegates: [
                    S.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
                  locale: resolveLocale(selectedLocal),
                  supportedLocales: S.delegate.supportedLocales,
                  navigatorKey: GlobalFunction.navigatorKey,
                  initialRoute: Routes.splash,
                  onGenerateRoute: generatedRoutes,
                );
              });
        });
  }

  Color hexToColor(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
