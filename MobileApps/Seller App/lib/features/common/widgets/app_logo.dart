import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:razin_commerce_seller_flutter/gen/assets.gen.dart';

class AppLogo extends StatefulWidget {
  final bool isAnimation;
  final bool? withAppName;
  final bool centerAlign;
  const AppLogo({
    super.key,
    this.withAppName = true,
    this.isAnimation = true,
    this.centerAlign = true,
  });

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
    return Assets.png.splashLogo.image(height: 70.h, width: 280.w);

    //  Row(
    //   mainAxisAlignment: widget.centerAlign
    //       ? MainAxisAlignment.center
    //       : MainAxisAlignment.start,
    //   crossAxisAlignment: CrossAxisAlignment.center,
    //   children: [
    //     Container(
    //       width: 55.h,
    //       height: 55.w,
    //       decoration: const BoxDecoration(
    //         shape: BoxShape.circle,
    //         gradient: RadialGradient(
    //           colors: [
    //             Color(0xFF8322FF),
    //             Color(0xFFC622FF),
    //           ],
    //           radius: 1,
    //           center: Alignment(-1, 0),
    //         ),
    //       ),
    //       child: Center(
    //         child: SizedBox(
    //           height: 35.h,
    //           child: Row(
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               Container(
    //                 height: widget.isAnimation
    //                     ? 14 + 20 * (1 - _animation.value)
    //                     : 34.h,
    //                 width: 14.w,
    //                 decoration: BoxDecoration(
    //                   borderRadius: BorderRadius.circular(10),
    //                   color: colors(context).light,
    //                 ),
    //               ),
    //               Gap(5.w),
    //               Container(
    //                 height:
    //                     widget.isAnimation ? 14 + 20 * _animation.value : 16.h,
    //                 width: 14.w,
    //                 decoration: BoxDecoration(
    //                   borderRadius: BorderRadius.circular(10),
    //                   color: colors(context).light,
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //       ),
    //     ),
    //     if (widget.withAppName ?? false)
    //       SizedBox(
    //         child: Row(
    //           children: [
    //             Gap(14.w),
    //             SvgPicture.asset(Assets.svg.appNameLogo),
    //           ],
    //         ),
    //       )
    //   ],
    // );
  }
}
