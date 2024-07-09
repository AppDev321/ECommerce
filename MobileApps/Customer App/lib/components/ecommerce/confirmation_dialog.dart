import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:razin_shop/components/ecommerce/custom_button.dart';
import 'package:razin_shop/config/app_color.dart';
import 'package:razin_shop/config/app_text_style.dart';
import 'package:razin_shop/generated/l10n.dart';
import 'package:razin_shop/utils/context_less_navigation.dart';

class ConfirmationDialog extends StatelessWidget {
  final String? icon;
  final String title;
  final String? des;
  final Color? confirmationButtonColor;
  final String confirmButtonText;
  final String? cancelButtonText;
  final bool isLoading;

  final void Function()? onPressed;

  const ConfirmationDialog({
    Key? key,
    this.icon,
    required this.title,
    this.des,
    required this.confirmButtonText,
    required this.onPressed,
    this.isLoading = false,
    this.confirmationButtonColor,
    this.cancelButtonText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 16.w),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              SvgPicture.asset(icon ?? ''),
              Gap(10.h),
            ],
            Text(
              title,
              textAlign: TextAlign.center,
              style: AppTextStyle(context).subTitle.copyWith(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            if (des != null) ...[
              Gap(8.h),
              Text(
                des ?? '',
                textAlign: TextAlign.center,
                style: AppTextStyle(context)
                    .bodyTextSmall
                    .copyWith(fontSize: 14.sp),
              ),
            ],
            Gap(32.h),
            Row(
              children: [
                Flexible(
                  flex: 1,
                  child: CustomButton(
                    buttonText: cancelButtonText ?? S.of(context).cancel,
                    buttonColor: EcommerceAppColor.offWhite,
                    buttonTextColor: EcommerceAppColor.black,
                    onPressed: () {
                      context.nav.pop();
                    },
                  ),
                ),
                Gap(16.w),
                Flexible(
                  flex: 1,
                  child: isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : CustomButton(
                          buttonText: confirmButtonText,
                          buttonColor:
                              confirmationButtonColor ?? EcommerceAppColor.red,
                          onPressed: onPressed,
                        ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
