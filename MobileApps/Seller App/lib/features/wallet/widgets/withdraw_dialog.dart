// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';
import 'package:razin_commerce_seller_flutter/config/app_color.dart';
import 'package:razin_commerce_seller_flutter/config/app_text_style.dart';
import 'package:razin_commerce_seller_flutter/config/theme.dart';
import 'package:razin_commerce_seller_flutter/features/common/widgets/custom_button.dart';
import 'package:razin_commerce_seller_flutter/features/dashboard/screens/dashboard.dart';
import 'package:razin_commerce_seller_flutter/features/wallet/models/wallet_details.dart';
import 'package:razin_commerce_seller_flutter/features/wallet/providers/wallet_provider.dart';
import 'package:razin_commerce_seller_flutter/features/wallet/providers/withdraw_provider.dart';
import 'package:razin_commerce_seller_flutter/gen/assets.gen.dart';
import 'package:razin_commerce_seller_flutter/utils/context_less_navigation.dart';

class WithdrawDialog extends StatelessWidget {
  final WalletDetails walletDetails;
  const WithdrawDialog({
    super.key,
    required this.walletDetails,
  });
  static final TextEditingController amountController = TextEditingController();

  static final formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 16.w),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.dm)),
      backgroundColor: colors(context).light,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.dm),
              color: colors(context).light,
            ),
            width: double.infinity,
            padding: EdgeInsets.all(16.dm),
            child: FormBuilder(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Gap(16.h),
                    SvgPicture.asset(Assets.svg.withdrawRequest),
                    Gap(16.h),
                    Text(
                      'Send a Withdrawal Request',
                      style: AppTextStyle.text24B700.copyWith(fontSize: 20.sp),
                    ),
                    Gap(4.h),
                    Text(
                      'Please enter withdrawal amount and tap send request button',
                      textAlign: TextAlign.center,
                      style: AppTextStyle.text16B400,
                    ),
                    Gap(16.h),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 12.h),
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: colors(context).secondaryColor!),
                        borderRadius: BorderRadius.circular(16.dm),
                      ),
                      child: Row(
                        children: [
                          Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: _buildCustomColumn(
                                lebel: 'Current Balance',
                                value: '\$${walletDetails.withdrawableAmount}'),
                          ),
                          Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: _buildCustomColumn(
                                lebel: 'Pay,ent Method',
                                value: 'Bank Transfer'),
                          ),
                        ],
                      ),
                    ),
                    Gap(16.h),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16.dm),
                      decoration: BoxDecoration(
                        color: colors(context).secondaryColor,
                        borderRadius: BorderRadius.circular(16.dm),
                      ),
                      child: Column(
                        children: [
                          Text(
                            'Enter Amount (USD)',
                            style: AppTextStyle.text16B400,
                          ),
                          Gap(8.h),
                          _buildAmuntField(),
                          Gap(4.h),
                          Text(
                            'Minimum withdrawal amount is \$${walletDetails.minWithdrawableAmount}',
                            style: AppTextStyle.text12B700.copyWith(
                                fontWeight: FontWeight.w400,
                                color: AppStaticColor.lightGray),
                          ),
                        ],
                      ),
                    ),
                    Gap(32.h),
                    Consumer(builder: (context, ref, _) {
                      return ref.watch(withdrawServiceProvider)
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : CustomButton(
                              buttonName: 'Send Request',
                              onTap: () async {
                                if (formKey.currentState!.validate()) {
                                  ref
                                      .read(withdrawServiceProvider.notifier)
                                      .withdrawWallet(
                                          amount: amountController.text.trim())
                                      .then(
                                        (value) => [
                                          context.nav.pop(),
                                          ref.watch(walletDetailsServiceProvider(
                                              ref.read(selectedFilterOption)![
                                                  'key'])),
                                        ],
                                      );
                                }
                              },
                            );
                    }),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            right: 5.w,
            top: 5.h,
            child: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => context.nav.pop(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomColumn({required String lebel, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          lebel,
          style: AppTextStyle.text14B400.copyWith(color: AppStaticColor.gray),
        ),
        Gap(4.h),
        Text(
          value,
          style: AppTextStyle.text14B400.copyWith(fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Widget _buildAmuntField() {
    return FormBuilderTextField(
      autofocus: false,
      name: 'withdrawal',
      controller: amountController,
      showCursor: false,
      textAlign: TextAlign.center,
      style: AppTextStyle.text24B700,
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(errorText: 'Amount is required'),
        FormBuilderValidators.numeric(errorText: 'Invalid amount'),
        FormBuilderValidators.min(
          walletDetails.minWithdrawableAmount,
          errorText:
              'Minimum withdrawal amount is \$${walletDetails.minWithdrawableAmount}',
        ),
      ]),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 12.h),
        fillColor: AppStaticColor.white,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.dm),
          borderSide: BorderSide(color: AppStaticColor.gray.withOpacity(0.2)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.dm),
          borderSide: BorderSide(
            color: AppStaticColor.gray.withOpacity(0.2),
            width: 2,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.dm),
          borderSide: BorderSide(
            color: AppStaticColor.gray.withOpacity(0.2),
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.dm),
          borderSide:
              BorderSide(color: AppStaticColor.red.withOpacity(0.3), width: 2),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.dm),
          borderSide: const BorderSide(color: AppStaticColor.gray),
        ),
      ),
    );
  }
}
