import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:razinshop_rider/config/app_color.dart';
import 'package:razinshop_rider/gen/assets.gen.dart';
import 'package:razinshop_rider/routers.dart';
import 'package:razinshop_rider/utils/context_less_navigate.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({
    super.key,
    required this.scaffoldKey,
  });

  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.r, vertical: 16.r),
      color: AppColor.whiteColor,
      width: double.infinity,
      child: Column(
        children: [
          Gap(44.h),
          Hero(
            tag: 'logo',
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      scaffoldKey.currentState!.openDrawer();
                    },
                    child: SvgPicture.asset(Assets.svgs.menu),
                  ),
                ),
                Expanded(child: Assets.pngs.riderApp.image(height: 40.h)),
                Stack(
                  children: [
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          context.nav.pushNamed(Routes.notification);
                        },
                        child: SvgPicture.asset(
                          Assets.svgs.notification,
                          height: 24.r,
                          width: 24.r,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        height: 10.r,
                        width: 10.r,
                        padding: EdgeInsets.all(1.r),
                        decoration: BoxDecoration(
                          color: AppColor.whiteColor,
                          shape: BoxShape.circle,
                        ),
                        child: Container(
                          height: 8.r,
                          width: 8.r,
                          padding: EdgeInsets.all(1.r),
                          decoration: BoxDecoration(
                            color: AppColor.redColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
