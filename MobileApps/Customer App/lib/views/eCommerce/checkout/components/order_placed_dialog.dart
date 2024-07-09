import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:razin_shop/components/ecommerce/custom_button.dart';
import 'package:razin_shop/config/app_color.dart';
import 'package:razin_shop/config/app_constants.dart';
import 'package:razin_shop/config/app_text_style.dart';
import 'package:razin_shop/controllers/misc/misc_controller.dart';
import 'package:razin_shop/models/eCommerce/cart/hive_cart_model.dart';
import 'package:razin_shop/routes.dart';
import 'package:razin_shop/utils/context_less_navigation.dart';

class OrderPlacedDialog extends ConsumerWidget {
  const OrderPlacedDialog({super.key});

  get ref => null;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 60.w,
              height: 60.h,
              padding: const EdgeInsets.all(14),
              decoration: ShapeDecoration(
                color: const Color(0xFF1EDD31),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Center(
                child: Icon(
                  Icons.done,
                  color: EcommerceAppColor.white,
                ),
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              'Your order has been\n placed',
              textAlign: TextAlign.center,
              style: AppTextStyle(context).subTitle.copyWith(fontSize: 22.sp),
            ),
            SizedBox(height: 16.h),
            Text(
              'You will receive an order confirmation\nemail with details of your order',
              textAlign: TextAlign.center,
              style: AppTextStyle(context).bodyText,
            ),
            SizedBox(height: 16.h),
            CustomButton(
              buttonText: 'Continue Shopping',
              onPressed: () {
                Hive.box<HiveCartModel>(AppConstants.cartModelBox).clear();
                ref.refresh(selectedTabIndexProvider.notifier).state;
                context.nav.pushNamedAndRemoveUntil(
                    Routes.getCoreRouteName(AppConstants.appServiceName),
                    (route) => false);
              },
            )
          ],
        ),
      ),
    );
  }
}
