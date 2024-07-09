import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';
import 'package:razin_commerce_seller_flutter/config/app_text_style.dart';
import 'package:razin_commerce_seller_flutter/config/theme.dart';
import 'package:razin_commerce_seller_flutter/features/auth/providers/auth_provider.dart';
import 'package:razin_commerce_seller_flutter/features/auth/screens/registration.dart';
import 'package:razin_commerce_seller_flutter/features/auth/screens/shop_owner_widget.dart';
import 'package:razin_commerce_seller_flutter/features/auth/widgets/pin_put.dart';
import 'package:razin_commerce_seller_flutter/features/common/widgets/custom_button.dart';
import 'package:razin_commerce_seller_flutter/gen/assets.gen.dart';
import 'package:razin_commerce_seller_flutter/utils/context_less_navigation.dart';

class ConfirmOTPBottomSheet extends StatefulWidget {
  final TextEditingController pinCodeController;
  final TabController tabController;
  const ConfirmOTPBottomSheet({
    super.key,
    required this.pinCodeController,
    required this.tabController,
  });

  @override
  State<ConfirmOTPBottomSheet> createState() => _ConfirmOTPBottomSheetState();
}

class _ConfirmOTPBottomSheetState extends State<ConfirmOTPBottomSheet> {
  final TextEditingController pinCodeController = TextEditingController();

  Timer? timer;
  int start = 60;
  bool isComplete = false;

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(oneSec, (timer) {
      if (start == 0) {
        timer.cancel();
      } else {
        setState(() {
          start--;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      return Container(
        decoration: BoxDecoration(
          color: colors(context).light,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.dm),
            topRight: Radius.circular(16.dm),
          ),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 20.w,
          vertical: 30.h,
        ).copyWith(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Enter OTP',
                style: AppTextStyle.text24B700,
              ),
              Gap(16.h),
              Column(
                children: [
                  Text(
                    'We sent OTP code to your email address',
                    textAlign: TextAlign.center,
                    style: AppTextStyle.text16B400,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        ref.read(emailController).text,
                        style: AppTextStyle.text16B400,
                      ),
                      Gap(5.w),
                      GestureDetector(
                        onTap: () => context.nav.pop(),
                        child: SvgPicture.asset(Assets.svg.edit),
                      )
                    ],
                  )
                ],
              ),
              Gap(20.h),
              PinPutWidget(
                onChanged: (v) {},
                onCompleted: (v) {},
                validator: FormBuilderValidators.required(
                  errorText: 'Please enter OTP',
                ),
                pinCodeController: widget.pinCodeController,
              ),
              Gap(24.h),
              ref.watch(authServiceProvider)
                  ? const Center(child: CircularProgressIndicator())
                  : CustomButton(
                      buttonName: 'Confirm OTP',
                      onTap: () {
                        ref
                            .read(authServiceProvider.notifier)
                            .verifyOTP(
                              email: ref.read(emailController).text,
                              otp: widget.pinCodeController.text,
                            )
                            .then((response) {
                          if (response.status) {
                            widget.tabController.animateTo(1);
                            ref.read(isEmailVerified.notifier).state = true;
                            context.nav.pop();
                          }
                        });
                      },
                    ),
              Gap(20.h),
              Text(
                "Resend code in 00:${start.toString().padLeft(2, "0")} sec",
                style: AppTextStyle.text16B400,
              ),
              if (start == 0)
                GestureDetector(
                  onTap: () async {
                    await ref.read(authServiceProvider.notifier).sendOTP(
                          email: ref.read(emailController).text,
                          isForgotPassword: false,
                        );
                    start = 60;
                    startTimer();
                  },
                  child: Text(
                    'Resend',
                    style: AppTextStyle.text14B400
                        .copyWith(color: colors(context).primaryColor),
                  ),
                ),
              Gap(16.h),
            ],
          ),
        ),
      );
    });
  }
}
