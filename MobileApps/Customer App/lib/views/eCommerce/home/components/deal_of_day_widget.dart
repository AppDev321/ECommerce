import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:razin_shop/config/app_color.dart';
import 'package:razin_shop/config/app_text_style.dart';
import 'package:razin_shop/config/theme.dart';
import 'package:razin_shop/gen/assets.gen.dart';
import 'package:razin_shop/generated/l10n.dart';

class DealOfDayWidget extends StatefulWidget {
  final DateTime targetDate;

  const DealOfDayWidget({
    Key? key,
    required this.targetDate,
  }) : super(key: key);

  @override
  State<DealOfDayWidget> createState() => _DealOfDayWidgetState();
}

class _DealOfDayWidgetState extends State<DealOfDayWidget> {
  late Timer countdownTimer;
  Duration remainingTime = const Duration();

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  void startTimer() {
    countdownTimer =
        Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());
  }

  void setCountDown() {
    setState(() {
      final now = DateTime.now();
      remainingTime = now.isBefore(widget.targetDate)
          ? widget.targetDate.difference(now)
          : const Duration();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // _buildDealHeader(),
        // Gap(16.h),
        _buildScrollingContainers(),
      ],
    );
  }

  Widget _buildDealHeader() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: EcommerceAppColor.carrotOrange,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildDealInfo(),
          SizedBox(height: 44.h, width: 120.w, child: _buildViewMoreButton()),
        ],
      ),
    );
  }

  Widget _buildDealInfo() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).dealOfTheDay,
          style: AppTextStyle(context).subTitle.copyWith(
                color: colors(context).light,
              ),
        ),
        Gap(8.h),
        Row(
          children: [
            Text(
              S.of(context).endingIn,
              style: AppTextStyle(context).bodyText.copyWith(
                    color: colors(context).light,
                  ),
            ),
            Gap(10.w),
            _buildCountdownDisplay(),
          ],
        )
      ],
    );
  }

  Widget _buildCountdownDisplay() {
    return SizedBox(
      child: Row(
        children: [
          ..._buildCountdownUnit(remainingTime.inHours),
          Text(
            ': ',
            style: AppTextStyle(context).bodyText.copyWith(
                  fontWeight: FontWeight.w600,
                  color: colors(context).light,
                ),
          ),
          ..._buildCountdownUnit(remainingTime.inMinutes.remainder(60)),
          Text(
            ': ',
            style: AppTextStyle(context).bodyText.copyWith(
                  fontWeight: FontWeight.w600,
                  color: colors(context).light,
                ),
          ),
          ..._buildCountdownUnit(remainingTime.inSeconds.remainder(60)),
        ],
      ),
    );
  }

  List<Widget> _buildCountdownUnit(int value) {
    return [
      Container(
        padding: const EdgeInsets.all(3).copyWith(left: 4.w, right: 4.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3.r),
          color: colors(context).light,
        ),
        child: Center(
          child: Text(
            _twoDigits(value),
            style: AppTextStyle(context).bodyText.copyWith(
                  color: EcommerceAppColor.carrotOrange,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
      ),
      Gap(5.w),
    ];
  }

  Widget _buildViewMoreButton() {
    return OutlinedButton(
      onPressed: () {},
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        side: const BorderSide(color: EcommerceAppColor.white, width: 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            S.of(context).viewMore,
            style: AppTextStyle(context)
                .bodyTextSmall
                .copyWith(color: colors(context).light),
          ),
          Gap(3.w),
          SvgPicture.asset(
            Assets.svg.arrowRight,
            colorFilter:
                ColorFilter.mode(colors(context).light!, BlendMode.srcIn),
          )
        ],
      ),
    );
  }

  Widget _buildScrollingContainers() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const NeverScrollableScrollPhysics(),
      child: Row(
        children: List.generate(
          60,
          (index) => Container(
            margin: const EdgeInsets.symmetric(horizontal: 2),
            height: 2.h,
            width: 5.w,
            color: EcommerceAppColor.lightGray.withOpacity(0.5),
          ),
        ),
      ),
    );
  }

  String _twoDigits(int n) {
    return n.toString().padLeft(2, '0');
  }

  @override
  void dispose() {
    countdownTimer.cancel();
    super.dispose();
  }
}
