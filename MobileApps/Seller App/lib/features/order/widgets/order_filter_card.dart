import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:razin_commerce_seller_flutter/config/app_color.dart';
import 'package:razin_commerce_seller_flutter/config/app_text_style.dart';
import 'package:razin_commerce_seller_flutter/config/theme.dart';
import 'package:razin_commerce_seller_flutter/features/order/models/order_status_model.dart';

class OrderFilterCard extends StatelessWidget {
  final OrderStatusModel statusModel;

  final bool isActive;

  final VoidCallback callback;
  const OrderFilterCard({
    super.key,
    required this.isActive,
    required this.callback,
    required this.statusModel,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: colors(context).light,
      borderRadius: BorderRadius.circular(44.dm),
      child: InkWell(
        borderRadius: BorderRadius.circular(44.dm),
        onTap: callback,
        child: Container(
          padding: EdgeInsets.all(8.dm),
          height: 38.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(44.dm),
            border: Border.all(
              color:
                  isActive ? colors(context).primaryColor! : Colors.transparent,
            ),
          ),
          child: Center(
            child: Text(
              "${statusModel.name}(${statusModel.value})",
              style: AppTextStyle.text14B400.copyWith(
                color: isActive
                    ? colors(context).primaryColor
                    : AppStaticColor.gray,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
