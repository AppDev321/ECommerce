import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:razinshop_rider/config/app_text.dart';
import 'package:razinshop_rider/controllers/home_controller/home_controllers.dart';
import 'package:razinshop_rider/gen/assets.gen.dart';

class NotificationScreen extends ConsumerWidget {
  NotificationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Notifications',
          style: AppTextStyle.normalBody.copyWith(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: SvgPicture.asset(Assets.svgs.backArrow),
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8).r,
        child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              print("index: $index");
              return _NotificationCard(
                index: index,
                onTap: () {
                  ref.read(isReadProvider.notifier).remove(index);
                  print("data ${ref.read(isReadProvider)}");
                },
              );
            }),
      ),
    );
  }
}

class _NotificationCard extends ConsumerWidget {
  _NotificationCard({
    required this.index,
    required this.onTap,
  });

  final int index;
  final Function onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isRead = !ref.watch(isReadProvider).contains(index);
    return Column(
      children: [
        Stack(
          children: [
            InkWell(
              onTap: () {
                onTap();
              },
              child: Container(
                padding: const EdgeInsets.all(12).r,
                decoration: ShapeDecoration(
                  color: isRead ? Colors.white : const Color(0xFFF2E9FE),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: isRead
                          ? const Color(0xFFF1F5F9)
                          : const Color(0xFFF2E9FE),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(12).r,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      height: 45.r,
                      width: 45.r,
                      padding: const EdgeInsets.all(10),
                      clipBehavior: Clip.antiAlias,
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: SvgPicture.asset(Assets.svgs.notification),
                    ),
                    Gap(20.r),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Your order has been placed successfully . asdfasfdas asdfas dfasdf ',
                          style: AppTextStyle.normalBody.copyWith(
                              fontSize: 14.sp, fontWeight: FontWeight.w400),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '18 Mar, 2024',
                              style: AppTextStyle.normalBody.copyWith(
                                color: const Color(0xFF64748B),
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Container(
                              width: 4,
                              height: 4,
                              decoration: const ShapeDecoration(
                                color: Color(0xFF94A3B8),
                                shape: OvalBorder(),
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              'Now',
                              style: AppTextStyle.normalBody.copyWith(
                                color: const Color(0xFF64748B),
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        )
                      ],
                    ))
                  ],
                ),
              ),
            ),
            Positioned(
              right: 0,
              top: 0,
              child: isRead
                  ? const SizedBox()
                  : Container(
                      width: 10.r,
                      height: 10.r,
                      decoration: const ShapeDecoration(
                        color: Color(0xFFAC71F4),
                        shape: OvalBorder(),
                      ),
                    ),
            )
          ],
        ),
        Gap(10.h),
      ],
    );
  }
}
