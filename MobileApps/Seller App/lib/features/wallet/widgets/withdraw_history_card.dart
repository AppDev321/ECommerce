import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:razin_commerce_seller_flutter/config/app_color.dart';
import 'package:razin_commerce_seller_flutter/config/app_text_style.dart';
import 'package:razin_commerce_seller_flutter/features/wallet/models/wallet_history.dart';

class WithdrawHistoryCard extends StatelessWidget {
  final WalletHistory walletHistory;
  const WithdrawHistoryCard({super.key, required this.walletHistory});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 12.w,
        vertical: 12.h,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: AppStaticColor.white,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                walletHistory.createdAt,
                style: AppTextStyle.text12B700.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text('\$${walletHistory.amount}', style: AppTextStyle.text14B700),
            ],
          ),
          Gap(2.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Bill ID ${walletHistory.billNo}',
                style: AppTextStyle.text12B700.copyWith(
                    fontWeight: FontWeight.w400, color: AppStaticColor.gray),
              ),
              Visibility(
                visible: false,
                child: GestureDetector(
                  onTap: () => debugPrint('context'),
                  child: Text(
                    'Download Invoice',
                    style: AppTextStyle.text12B700.copyWith(
                      fontWeight: FontWeight.w400,
                      color: AppStaticColor.blue,
                      decorationColor: AppStaticColor.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
