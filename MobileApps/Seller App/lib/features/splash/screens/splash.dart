import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:razin_commerce_seller_flutter/config/app_constants.dart';
import 'package:razin_commerce_seller_flutter/config/routes.dart';
import 'package:razin_commerce_seller_flutter/config/theme.dart';
import 'package:razin_commerce_seller_flutter/features/common/providers/common_provider.dart';
import 'package:razin_commerce_seller_flutter/gen/assets.gen.dart';
import 'package:razin_commerce_seller_flutter/utils/api_client.dart';

class Splash extends ConsumerStatefulWidget {
  const Splash({super.key});

  @override
  ConsumerState<Splash> createState() => _SplashState();
}

class _SplashState extends ConsumerState<Splash> {
  bool isIconVisible = false;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) => _init(),
    );

    super.initState();
  }

  _init() async {
    ref.read(commonServiceProvider.notifier).getMasterData().then((response) {
      if (response?.data.themeColors.primaryColor != null) {
        ref
            .read(hiveServiceProvider)
            .setPrimaryColor(color: response!.data.themeColors.primaryColor);
      }
    });
    final Box settingsBox = await Hive.openBox(AppConstants.appSettingsBox);
    var phone = await settingsBox.get(AppConstants.phone, defaultValue: '');

    if (phone.isNotEmpty) {
      var isActive = await ref
          .read(commonServiceProvider.notifier)
          .checkUser(phone: phone);
      await Future.delayed(const Duration(seconds: 3));
      if (mounted) context.go(isActive ? Routes.login : Routes.underReview);
    } else {
      await Future.delayed(const Duration(seconds: 3));
      String? token = await ref.read(hiveServiceProvider).getToken();
      ref.read(apiClientProvider).updateToken(token: token ?? '');
      if (token != null) {
        if (mounted) context.go(Routes.dashboard);
      } else {
        if (mounted) context.go(Routes.login);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: colors(context).light,
        body: Center(
            child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Assets.png.splashLogo.image(width: 280.w, height: 100.h)
                  ],
                ),
                Container(
                  color: Colors.white,
                  height: 100.r,
                  width: 280.w,
                )
                    .animate(delay: 2.seconds)
                    .moveX(duration: 500.ms, begin: 0.0, end: 280.0.w)
                    .callback(callback: (value) {
                  setState(() {
                    isIconVisible = true;
                  });
                })
              ],
            ),
          ],
        )
            // .animate(delay: 3.seconds)
            // .moveX(duration: 200.ms, begin: -20, end: 0.0),
            )
        // .animate(delay: 5.seconds)
        // .moveY(duration: 600.ms, begin: 0.0, end: -250),
        );
  }
}
