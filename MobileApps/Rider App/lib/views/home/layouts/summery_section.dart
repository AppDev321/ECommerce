import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:razinshop_rider/config/app_color.dart';
import 'package:razinshop_rider/config/app_text.dart';
import 'package:razinshop_rider/controllers/order_controller/order_controller.dart';
import 'package:razinshop_rider/gen/assets.gen.dart';
import 'package:razinshop_rider/generated/l10n.dart';

class SummerySection extends ConsumerWidget {
  const SummerySection({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(-0.99, -0.12),
          end: Alignment(0.99, 0.12),
          colors: [Color(0xFFB822FF), AppColor.primaryColor],
        ),
      ),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.r, vertical: 12.r),
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: AppColor.whiteColor,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    S.of(context).todaysOrders,
                    style: AppTextStyle.smallBody
                        .copyWith(fontWeight: FontWeight.w700),
                  ),
                ),
                Assets.pngs.arrow2.image(
                  height: 24.r,
                  width: 24.r,
                  color: AppColor.primaryColor,
                )
              ],
            ),
            Gap(12.h),
            Row(
              children: [
                summeryCard(
                  title: S.of(context).todo,
                  value: ref
                      .watch(orderListProvider)
                      .maybeWhen(
                        orElse: () => 0,
                        data: (value) => value.todoOrder,
                      )
                      .toString(),
                  icon: Assets.svgs.boxTime,
                ).animate().shimmer(
                      delay: (200).ms,
                      duration: 1000.ms,
                      color: Colors.grey.withOpacity(0.2),
                    ),
                Gap(12.w),
                summeryCard(
                  title: S.of(context).complete,
                  value: ref
                      .watch(orderListProvider)
                      .maybeWhen(
                        orElse: () => 0,
                        data: (value) => value.completedOrder,
                      )
                      .toString(),
                  icon: Assets.svgs.boxTick,
                ).animate().shimmer(
                      delay: (200).ms,
                      duration: 1000.ms,
                      color: Colors.grey.withOpacity(0.2),
                    ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget summeryCard(
      {required String title, required String value, required String icon}) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12).r,
        decoration: ShapeDecoration(
          color: Color(0xFFF9FAFB),
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 1, color: AppColor.borderColor),
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: AppTextStyle.smallBody
                        .copyWith(color: Color(0xFF969899)),
                  ),
                ),
                SvgPicture.asset(icon, height: 24.r, width: 24.r),
              ],
            ),
            Text(
              value,
              style:
                  AppTextStyle.normalBody.copyWith(fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }
}
