// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:razin_commerce_seller_flutter/config/app_color.dart';
import 'package:razin_commerce_seller_flutter/config/app_text_style.dart';
import 'package:razin_commerce_seller_flutter/config/theme.dart';
import 'package:razin_commerce_seller_flutter/features/order/models/order_model.dart';
import 'package:razin_commerce_seller_flutter/gen/assets.gen.dart';
import 'package:razin_commerce_seller_flutter/utils/global_function.dart';

class OrderCard extends StatelessWidget {
  final Order order;
  final VoidCallback callback;
  const OrderCard({
    super.key,
    required this.callback,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(8.dm),
      color: colors(GlobalFunction.navigatorKey.currentContext).light,
      child: InkWell(
        borderRadius: BorderRadius.circular(8.dm),
        onTap: callback,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 12.w,
            vertical: 12.h,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.dm),
            color: colors(GlobalFunction.navigatorKey.currentContext).light,
          ),
          child: Column(
            children: [
              _buildDateWidget(),
              Gap(12.h),
              _buildBottomWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDateWidget() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.dm),
        color:
            colors(GlobalFunction.navigatorKey.currentContext).secondaryColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            order.estimatedDeliveryDate,
            style: AppTextStyle.text14B400.copyWith(fontSize: 10.sp),
          ),
          Icon(
            Icons.arrow_forward_ios,
            size: 12.sp,
            color: AppStaticColor.gray,
          ),
        ],
      ),
    );
  }

  Widget _buildBottomWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          order.orderCode,
          style: AppTextStyle.text14B400.copyWith(fontWeight: FontWeight.w700),
        ),
        Container(
          height: 10.h,
          width: 2,
          color: AppStaticColor.secondary,
        ),
        SizedBox(
          child: Row(
            children: [
              SvgPicture.asset(Assets.svg.riderCircale),
              Gap(8.w),
              SizedBox(
                width: 150.w,
                child: Text(
                  order.user.name,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyle.text14B400
                      .copyWith(fontWeight: FontWeight.w500),
                ),
              )
            ],
          ),
        ),
        _statusCard()
      ],
    );
  }

  Widget _statusCard() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: GlobalFunction.getOrderStatsusColor(order.orderStatus),
        borderRadius: BorderRadius.circular(6.dm),
      ),
      child: Text(
        order.orderStatus,
        style: AppTextStyle.text12B700.copyWith(
          fontWeight: FontWeight.w400,
          color: AppStaticColor.white,
        ),
      ),
    );
  }
}
