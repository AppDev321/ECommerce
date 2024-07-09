import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:razinshop_rider/components/my_custom_button.dart';
import 'package:razinshop_rider/config/app_color.dart';
import 'package:razinshop_rider/config/app_text.dart';
import 'package:razinshop_rider/gen/assets.gen.dart';
import 'package:razinshop_rider/utils/context_less_navigate.dart';

class NewOrderDialog extends ConsumerStatefulWidget {
  const NewOrderDialog({
    super.key,
  });

  @override
  ConsumerState<NewOrderDialog> createState() => _NewOrderDialogState();
}

class _NewOrderDialogState extends ConsumerState<NewOrderDialog> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(16.r),
              width: double.infinity,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 75.r,
                    width: 75.r,
                    padding: EdgeInsets.all(10.r),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColor.primaryColor.withOpacity(0.1),
                    ),
                    child: SvgPicture.asset(Assets.svgs.cubeScan),
                  ),
                  Gap(15.h),
                  SizedBox(
                    width: 250.w,
                    child: Text(
                      'You have been assigned a new job',
                      textAlign: TextAlign.center,
                      style: AppTextStyle.title,
                    ),
                  ),
                  Gap(15.h),
                  Container(
                    padding: const EdgeInsets.all(12).r,
                    decoration: ShapeDecoration(
                      color: Color(0xFFF7F7F7),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 1, color: Color(0xFFF1F1F5)),
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(
                                  Assets.svgs.box,
                                  height: 12.r,
                                  width: 12.r,
                                ),
                                Gap(4.w),
                                Text(
                                  'Pickup',
                                  style: TextStyle(
                                    color: Color(0xFF617885),
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                )
                              ],
                            ),
                            IntrinsicHeight(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 5.r),
                                    child: SvgPicture.asset(
                                      Assets.svgs.line2,
                                      width: 1.w,
                                      height: 45.h,
                                      fit: BoxFit.fitHeight,
                                    ),
                                  ),
                                  Gap(10.w),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'DhakaMart',
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            'Muskan Boutiques Tailors & Fabrics, H 52/1, Rd 12, PC Culture Housing, Adabor',
                                            style: TextStyle(
                                              color: Color(0xFF617885),
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w400,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(
                                  Assets.svgs.pin,
                                  height: 12.r,
                                  width: 12.r,
                                ),
                                Gap(4.w),
                                Expanded(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'Drop-off',
                                          style: TextStyle(
                                            color: Color(0xFF617885),
                                            fontSize: 10.sp,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: SizedBox(
                                          width: 137,
                                          child: Text(
                                            '10 May, 2024',
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                              color: Color(0xFF8322FF),
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 6.r),
                                  child: null,
                                ),
                                Gap(10.w),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Mehedi Hasan',
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      Text(
                                        'BRP Jame Masjid, Police Station Rd, Vashantek',
                                        style: TextStyle(
                                          color: Color(0xFF617885),
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Gap(16.h),
                  MyCustomButton(
                    onTap: () {
                      context.nav.pop();
                    },
                    btnText: "OK",
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          right: 0,
          top: 0,
          child: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ],
    );
  }
}
