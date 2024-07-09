// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:razin_shop/config/app_constants.dart';
import 'package:razin_shop/config/app_text_style.dart';
import 'package:razin_shop/config/theme.dart';

class AppLogo extends StatefulWidget {
  final bool isAnimation;
  final bool? withAppName;
  final bool centerAlign;
  const AppLogo({
    Key? key,
    this.withAppName = true,
    this.isAnimation = true,
    this.centerAlign = true,
  }) : super(key: key);

  @override
  State<AppLogo> createState() => _AppLogoState();
}

class _AppLogoState extends State<AppLogo> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    if (widget.isAnimation) {
      // Initialize the controller and set the duration
      _controller = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 1000),
      );

      // Create a curved animation to control the easing
      _animation = CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      );

      // Set up a listener to rebuild the widget when animation value changes
      _animation.addListener(() {
        setState(() {});
      });

      // Repeat the animation indefinitely
      _controller.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    if (widget.isAnimation) {
      _controller.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: widget.centerAlign
          ? MainAxisAlignment.center
          : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ValueListenableBuilder(
            valueListenable: Hive.box(AppConstants.appSettingsBox).listenable(),
            builder: (context, settingBox, _) {
              final String? appLogo = settingBox.get(AppConstants.appLogo);
              if (appLogo != null) {
                return CachedNetworkImage(
                  imageUrl: appLogo,
                  height: 55.h,
                  width: 55.w,
                );
              }
              return Container(
                width: 55.h,
                height: 55.w,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      Color(0xFF8322FF),
                      Color(0xFFC622FF),
                    ],
                    radius: 1,
                    center: Alignment(-1, 0),
                  ),
                ),
                child: Center(
                  child: SizedBox(
                    height: 35.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: widget.isAnimation
                              ? 14 + 20 * (1 - _animation.value)
                              : 34.h,
                          width: 14.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: colors(context).light,
                          ),
                        ),
                        Gap(5.w),
                        Container(
                          height: widget.isAnimation
                              ? 14 + 20 * _animation.value
                              : 16.h,
                          width: 14.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: colors(context).light,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
        if (widget.withAppName ?? false)
          ValueListenableBuilder(
              valueListenable:
                  Hive.box(AppConstants.appSettingsBox).listenable(),
              builder: (context, settingsBox, _) {
                final String appName = settingsBox.get(AppConstants.appName,
                    defaultValue: 'Ready eCommerce');
                return SizedBox(
                  child: Row(
                    children: [
                      Gap(14.w),
                      Text(
                        appName,
                        style: AppTextStyle(context).title.copyWith(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.bold,
                            letterSpacing: -1),
                      )
                    ],
                  ),
                );
              })
      ],
    );
  }
}
