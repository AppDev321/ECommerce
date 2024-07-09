import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:razin_commerce_seller_flutter/config/app_text_style.dart';
import 'package:razin_commerce_seller_flutter/config/theme.dart';
import 'package:razin_commerce_seller_flutter/features/order/models/order_model.dart';
import 'package:razin_commerce_seller_flutter/utils/global_function.dart';

class ItemCard extends StatelessWidget {
  final Products product;
  const ItemCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      child: Row(
        children: [
          Flexible(
            flex: 1,
            child: SizedBox(
              height: 48.h,
              width: 48.w,
              child: CachedNetworkImage(
                imageUrl: product.thumbnail,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Gap(12.w),
          Flexible(
            flex: 6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${product.name}\n',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyle.text12B700
                      .copyWith(fontWeight: FontWeight.w400),
                ),
                Gap(8.h),
                Row(
                  children: [
                    _buildPcsWidget(),
                    Gap(4.w),
                    _buildColorWidget(),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildPcsWidget() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.dm),
        color: colors(GlobalFunction.navigatorKey.currentContext).dark,
      ),
      child: Text(
        '${product.quantity} Pcs',
        style: AppTextStyle.text12B700.copyWith(
            fontSize: 10.sp,
            color: colors(GlobalFunction.navigatorKey.currentContext).light),
      ),
    );
  }

  Widget _buildColorWidget() {
    return Visibility(
      visible: product.color == null,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
        decoration: BoxDecoration(
          border: Border.all(
              color: colors(GlobalFunction.navigatorKey.currentContext).dark!),
          borderRadius: BorderRadius.circular(4.dm),
        ),
        child: Text(
          product.color ?? '',
          style: AppTextStyle.text12B700.copyWith(fontSize: 10.sp),
        ),
      ),
    );
  }

  final String image =
      'https://cdn1.vectorstock.com/i/1000x1000/06/70/earphones-icon-realistic-style-vector-21880670.jpg';
}
