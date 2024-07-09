import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:razinshop_rider/config/app_color.dart';
import 'package:razinshop_rider/config/app_constants.dart';
import 'package:razinshop_rider/controllers/auth_controller/auth_controller.dart';
import 'package:razinshop_rider/controllers/others_controller/others_controller.dart';
import 'package:razinshop_rider/gen/assets.gen.dart';
import 'package:razinshop_rider/routers.dart';
import 'package:razinshop_rider/utils/context_less_navigate.dart';
import 'package:razinshop_rider/views/auth/login_view.dart';

class SplashLayout extends ConsumerStatefulWidget {
  const SplashLayout({super.key});

  @override
  ConsumerState<SplashLayout> createState() => _SplashLayoutState();
}

class _SplashLayoutState extends ConsumerState<SplashLayout> {
  late Box authBox;
  bool isIconVisible = false;
  @override
  void initState() {
    authBox = Hive.box(AppConstants.authBox);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(masterDataProvider);
    });

    Future.microtask(() {
      ref.read(checkUserStatusProvider(authBox.get(AppConstants.isInReview)));
    });

    Future.delayed(const Duration(seconds: 4), () async {
      final String? checkStatus =
          authBox.get(AppConstants.isInReview, defaultValue: null);

      if (checkStatus == null) {
        if (authBox.get(AppConstants.authToken) != null) {
          ref.read(userDetilsProvider);
          context.nav.pushNamedAndRemoveUntil(Routes.home, (route) => false);
        } else {
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  LoginView(),
              transitionDuration: const Duration(milliseconds: 600),
              barrierColor: Colors.black.withOpacity(0.5),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                var offsetAnimation = animation
                    .drive(Tween(begin: Offset(0.0, 1.0), end: Offset.zero));
                return SlideTransition(
                  position: offsetAnimation,
                  child: child,
                );
              },
            ),
          );
        }
      } else {
        context.nav.pushNamedAndRemoveUntil(Routes.review, (route) => false,
            arguments:
                authBox.get(AppConstants.isInReview, defaultValue: null));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      // body: Center(
      //   child: Row(
      //     mainAxisSize: MainAxisSize.min,
      //     crossAxisAlignment: CrossAxisAlignment.center,
      //     children: [
      //       Stack(
      //         alignment: Alignment.centerRight,
      //         children: [
      //           Visibility(
      //             visible: isIconVisible,
      //             child: SvgPicture.asset(Assets.svgs.icon),
      //           ).animate().scale(duration: 100.ms),
      //           Container(
      //             height: 100.r,
      //             width: 100.r,
      //             color: Colors.white,
      //           )
      //               .animate(delay: 3.seconds)
      //               .moveX(duration: 500.ms, begin: 0.0, end: -200.0)
      //         ],
      //       ),
      //       Gap(12.w),
      //       Stack(
      //         alignment: Alignment.centerLeft,
      //         children: [
      //           Assets.pngs.riderApp.image(),
      //           Container(
      //             color: Colors.white,
      //             height: 100.r,
      //             width: 200.r,
      //           )
      //               .animate(delay: 2.seconds)
      //               .moveX(duration: 500.ms, begin: 0.0, end: 200.0)
      //               .callback(callback: (value) {
      //             setState(() {
      //               isIconVisible = true;
      //             });
      //           })
      //         ],
      //       ),
      //     ],
      //   )
      //       .animate(delay: 3.seconds)
      //       .moveX(duration: 200.ms, begin: -20, end: 0.0),
      // )
      //     .animate(delay: 5.seconds)
      //     .moveY(duration: 600.ms, begin: 0.0, end: -250),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Assets.pngs.riderApp.image(
              width: 200.w,
              height: 200.h,
            ),
            Container(
              color: Colors.white,
              height: 200.h,
              width: 200.w,
            )
                .animate(delay: 2.seconds)
                .moveX(duration: 500.ms, begin: 0.0, end: 350.0),
          ],
        ),
      ),
    );
  }
}
