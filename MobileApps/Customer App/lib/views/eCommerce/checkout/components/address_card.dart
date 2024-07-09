// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:razin_shop/config/app_color.dart';
import 'package:razin_shop/config/app_text_style.dart';
import 'package:razin_shop/config/theme.dart';
import 'package:razin_shop/gen/assets.gen.dart';
import 'package:razin_shop/generated/l10n.dart';
import 'package:razin_shop/models/eCommerce/address/add_address.dart';

class AddressCard extends StatelessWidget {
  final AddAddress? address;
  final bool showEditButton;
  final void Function()? onTap;
  final void Function()? editTap;

  final Color cardColor;
  final Color borderColor;
  const AddressCard({
    Key? key,
    required this.address,
    this.showEditButton = false,
    this.onTap,
    this.editTap,
    this.cardColor = EcommerceAppColor.offWhite,
    this.borderColor = EcommerceAppColor.offWhite,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(10.r),
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 14.h).copyWith(left: 40.w),
            decoration: ShapeDecoration(
              color: cardColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
                side: BorderSide(color: borderColor),
              ),
            ),
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildAddressTagCard(context: context),
                Gap(10.h),
                _buildAddressInfoWidget(context: context),
              ],
            ),
          ),
        ),
        if (showEditButton)
          Positioned(
            right: 14.w,
            top: 12.h,
            child: _buildEditButton(context: context),
          ),
        Positioned(
          top: 16.h,
          left: 14.w,
          child: SvgPicture.asset(
            Assets.svg.locationPurple,
            colorFilter: ColorFilter.mode(
                colors(context).primaryColor!, BlendMode.srcIn),
          ),
        )
      ],
    );
  }

  Widget _buildAddressTagCard({required BuildContext context}) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
          decoration: ShapeDecoration(
            color: EcommerceAppColor.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.r),
            ),
          ),
          child: Text(
            address!.addressType.toUpperCase(),
            style: AppTextStyle(context)
                .bodyTextSmall
                .copyWith(color: EcommerceAppColor.white, fontSize: 13.sp),
          ),
        ),
        if (address!.isDefault) ...[
          Gap(8.w),
          Text(
            S.of(context).defaultAddress,
            style: AppTextStyle(context).bodyTextSmall.copyWith(
                  fontStyle: FontStyle.italic,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
          )
        ]
      ],
    );
  }

  Widget _buildEditButton({required BuildContext context}) {
    return InkWell(
      borderRadius: BorderRadius.circular(30.r),
      onTap: editTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.r),
            side: BorderSide(color: EcommerceAppColor.primary),
          ),
        ),
        child: Center(
          child: Text(
            'Edit',
            style: AppTextStyle(context)
                .bodyText
                .copyWith(color: EcommerceAppColor.primary, fontSize: 12.sp),
          ),
        ),
      ),
    );
  }

  Widget _buildAddressInfoWidget({required BuildContext context}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          address!.name,
          style: AppTextStyle(context)
              .bodyTextSmall
              .copyWith(color: EcommerceAppColor.black, fontSize: 12.sp),
        ),
        Gap(5.h),
        Text(
          address!.phone,
          style: AppTextStyle(context).bodyTextSmall.copyWith(fontSize: 12.sp),
        ),
        Gap(5.h),
        Text(
          "${address!.addressLine},${address!.flatNo},${address!.addressLine2},${address!.area}-${address!.postCode}",
          style: AppTextStyle(context).bodyTextSmall.copyWith(fontSize: 12.sp),
        )
      ],
    );
  }
}
