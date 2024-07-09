// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:razin_commerce_seller_flutter/config/app_text_style.dart';
import 'package:razin_commerce_seller_flutter/config/routes.dart';
import 'package:razin_commerce_seller_flutter/config/theme.dart';
import 'package:razin_commerce_seller_flutter/features/auth/providers/auth_provider.dart';
import 'package:razin_commerce_seller_flutter/features/auth/screens/shop_owner_widget.dart';
import 'package:razin_commerce_seller_flutter/features/auth/widgets/pin_put.dart';
import 'package:razin_commerce_seller_flutter/features/common/widgets/custom_button.dart';
import 'package:razin_commerce_seller_flutter/gen/assets.gen.dart';
import 'package:razin_commerce_seller_flutter/utils/global_function.dart';

class ConfirmOTP extends ConsumerStatefulWidget {
  final String email;
  const ConfirmOTP({
    super.key,
    required this.email,
  });

  @override
  ConsumerState<ConfirmOTP> createState() => _ConfirmOTPState();
}

class _ConfirmOTPState extends ConsumerState<ConfirmOTP> {
  final TextEditingController pinCodeController = TextEditingController();

  Timer? timer;
  int start = 60;
  bool isComplete = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
    startTimer();

    pinCodeController.addListener(pinCodeListener);
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

  void pinCodeListener() {
    if (pinCodeController.text.length == 4) {
      setState(() {
        isComplete = true;
      });
    } else {
      setState(() {
        isComplete = false;
      });
    }
  }

  @override
  void dispose() {
    timer!.cancel();
    pinCodeController.removeListener(pinCodeListener);
    pinCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: colors(context).light,
        body: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Assets.png.sms.image(),
                  Gap(20.h),
                  Text(
                    'Enter OTP',
                    style: AppTextStyle.text24B700.copyWith(fontSize: 28.sp),
                  ),
                  Gap(20.h),
                  Column(
                    children: [
                      Text(
                        'We sent OTP code to your email address',
                        style: AppTextStyle.text16B400,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            ref.watch(emailController).text,
                            style: AppTextStyle.text16B400,
                          ),
                          Gap(5.w),
                          GestureDetector(
                            onTap: () {
                              GoRouter.of(context).pop();
                            },
                            child: SvgPicture.asset(Assets.svg.edit),
                          )
                        ],
                      )
                    ],
                  ),
                  Gap(40.h),
                  PinPutWidget(
                    pinCodeController: pinCodeController,
                    onCompleted: (pin) {},
                    validator: (value) {
                      return null;
                    },
                    onChanged: (v) {},
                  ),
                  Gap(30.h),
                  ref.watch(authServiceProvider)
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : CustomButton(
                          buttonName: 'Confirm OTP',
                          onTap: () {
                            ref
                                .read(authServiceProvider.notifier)
                                .verifyOTP(
                                    email: widget.email,
                                    otp: pinCodeController.text)
                                .then((response) => response.status
                                    ? GoRouter.of(context).push(
                                        Routes.createPassword,
                                        extra: response.data)
                                    : GlobalFunction.showCustomSnackbar(
                                        message: response.message,
                                        isSuccess: response.status));
                          },
                        ),
                  Gap(30.h),
                  Text(
                    "Resend code in 00:$start sec",
                    style: AppTextStyle.text16B400,
                  ),
                  if (start == 0)
                    GestureDetector(
                      onTap: () async {
                        await ref.read(authServiceProvider.notifier).sendOTP(
                              email: widget.email,
                              isForgotPassword: true,
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
