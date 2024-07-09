import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:razin_commerce_seller_flutter/config/app_text_style.dart';
import 'package:razin_commerce_seller_flutter/config/theme.dart';
import 'package:razin_commerce_seller_flutter/utils/global_function.dart';

class OrderStatusWidget extends StatelessWidget {
  final String orderStatus;
  const OrderStatusWidget({super.key, required this.orderStatus});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: GlobalFunction.getOrderStatsusColor(orderStatus),
        borderRadius: BorderRadius.circular(14.dm),
      ),
      child: Text(
        orderStatus,
        style: AppTextStyle.text14B700.copyWith(color: colors(context).light),
      ),
    );
  }
}
