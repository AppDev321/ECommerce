import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:razinshop_rider/config/app_color.dart';
import 'package:razinshop_rider/config/app_constants.dart';
import 'package:razinshop_rider/config/app_text.dart';
import 'package:razinshop_rider/gen/assets.gen.dart';
import 'package:razinshop_rider/generated/l10n.dart';
import 'package:razinshop_rider/models/order_model/order.dart';
import 'package:razinshop_rider/routers.dart';
import 'package:razinshop_rider/utils/context_less_navigate.dart';
import 'package:razinshop_rider/views/home/layouts/order_list_section.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({
    super.key,
    required this.index,
    required this.orderData,
  });
  final int index;
  final Order orderData;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            context.nav.pushNamed(Routes.orderDetails, arguments: orderData.id);
          },
          child: Container(
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              shadows: [
                BoxShadow(
                  color: Color(0x14000000),
                  blurRadius: 2,
                  offset: Offset(0, 1),
                  spreadRadius: 0,
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.r, vertical: 12.r),
                  decoration: BoxDecoration(
                    color: Color(0xFFF7F7F7),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            DotAnimation(),
                            Text(
                              S.of(context).orderID,
                              style: AppTextStyle.smallBody
                                  .copyWith(color: AppColor.greyColor),
                            ),
                            Gap(5.w),
                            Text(
                              orderData.orderCode ?? '',
                              style: AppTextStyle.smallBody
                                  .copyWith(fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Text(S.of(context).viewDetails,
                            style: AppTextStyle.smallBody
                                .copyWith(color: AppColor.primaryColor)),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.r, vertical: 12.r),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SvgPicture.asset(
                            Assets.svgs.box,
                            height: 12.r,
                            width: 12.r,
                          ),
                          Gap(6.w),
                          Expanded(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 74.w,
                                      child: Text(
                                        orderData.shop?.name ?? '',
                                        style: AppTextStyle.smallBody.copyWith(
                                            fontWeight: FontWeight.w500),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 5.r),
                                        constraints: BoxConstraints(
                                          maxHeight: 16.h,
                                        ),
                                        child: SvgPicture.asset(
                                          Assets.svgs.line,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 72.w,
                                      child: Text(
                                        orderData.user?.name ?? '',
                                        style: AppTextStyle.smallBody.copyWith(
                                          fontWeight: FontWeight.w500,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Gap(2.w),
                                    SvgPicture.asset(
                                      Assets.svgs.pin,
                                      height: 12.r,
                                      width: 12.r,
                                    ),
                                  ],
                                ),
                                Gap(4.h),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        orderData.user?.address?.addressLine ??
                                            '',
                                        style: AppTextStyle.smallBody.copyWith(
                                          fontSize: 10.sp,
                                          color: AppColor.greyColor,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Gap(16.w),
                                    Expanded(
                                      child: Text(
                                        orderData.shop?.address ?? '',
                                        style: AppTextStyle.smallBody.copyWith(
                                          fontSize: 10.sp,
                                          color: AppColor.greyColor,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                CustomPaint(
                  size: Size(double.infinity, 1),
                  painter: DottedLinePainter(),
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.r, vertical: 12.r),
                  child: Row(
                    children: [
                      //TODO: Distance Here
                      Expanded(
                        child: Text(
                          '',
                          style: AppTextStyle.smallBody
                              .copyWith(fontWeight: FontWeight.w700),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Expanded(
                        child: ValueListenableBuilder(
                            valueListenable:
                                Hive.box(AppConstants.appSettingsBox)
                                    .listenable(),
                            builder: (context, box, child) {
                              return Text(
                                '${box.get(AppConstants.currency) ?? "\$"}${orderData.amount ?? 0.0}',
                                style: AppTextStyle.smallBody
                                    .copyWith(fontWeight: FontWeight.w700),
                                textAlign: TextAlign.center,
                              );
                            }),
                      ),
                      Expanded(
                        child: Text(
                          orderData.paymentMethod ?? '',
                          style: AppTextStyle.smallBody
                              .copyWith(fontWeight: FontWeight.w700),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Gap(15.h),
      ],
    ).animate().shimmer(
          delay: (index * 100).ms,
          duration: 1000.ms,
          color: Colors.grey.withOpacity(0.2),
        );
  }
}
