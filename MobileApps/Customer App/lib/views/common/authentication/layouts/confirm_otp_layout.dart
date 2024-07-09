// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:razin_shop/components/ecommerce/animate_image.dart';
import 'package:razin_shop/components/ecommerce/custom_button.dart';
import 'package:razin_shop/config/app_constants.dart';
import 'package:razin_shop/config/app_text_style.dart';
import 'package:razin_shop/config/theme.dart';
import 'package:razin_shop/controllers/eCommerce/authentication/authentication_controller.dart';
import 'package:razin_shop/gen/assets.gen.dart';
import 'package:razin_shop/generated/l10n.dart';
import 'package:razin_shop/routes.dart';
import 'package:razin_shop/utils/context_less_navigation.dart';
import 'package:razin_shop/utils/global_function.dart';
import 'package:razin_shop/views/common/authentication/components/pin_put.dart';

class ConfirmOTPLayout extends ConsumerStatefulWidget {
  final ConfirmOTPScreenArguments arguments;
  const ConfirmOTPLayout({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  @override
  ConsumerState<ConfirmOTPLayout> createState() => _ConfirmOTPLayoutState();
}

class _ConfirmOTPLayoutState extends ConsumerState<ConfirmOTPLayout> {
  final TextEditingController pinCodeController = TextEditingController();

  Timer? timer;
  int start = 60;
  bool isComplete = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      initOTP();
    });
    startTimer();

    pinCodeController.addListener(pinCodeListener);
    super.initState();
  }

  Future initOTP() async {
    ref
        .read(authControllerProvider.notifier)
        .sendOTP(phone: widget.arguments.phoneNumber)
        .then((response) {
      if (response.isSuccess) pinCodeController.text = response.data.toString();
      GlobalFunction.showCustomSnackbar(
          message: response.message, isSuccess: response.isSuccess);
    });
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
        body: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedImage(
                      imageSize: 100.w,
                      imageWidget: Assets.png.confirmOtp.image()),
                  Gap(20.h),
                  Text(
                    S.of(context).enterotp,
                    style: AppTextStyle(context)
                        .title
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  Gap(20.h),
                  Column(
                    children: [
                      Text(
                        S.of(context).weSentOtp,
                        style: AppTextStyle(context).bodyText.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            widget.arguments.phoneNumber,
                            style: AppTextStyle(context).bodyText.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: colors(context).primaryColor,
                                ),
                          ),
                          Gap(5.w),
                          GestureDetector(
                              onTap: () {
                                context.nav.pop();
                              },
                              child: SvgPicture.asset(Assets.svg.edit))
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
                  ),
                  Gap(30.h),
                  AbsorbPointer(
                    absorbing: !isComplete,
                    child: ref.watch(authControllerProvider)
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : CustomButton(
                            buttonText: S.of(context).confirmOtp,
                            buttonColor: isComplete
                                ? colors(context).primaryColor
                                : ColorTween(
                                    begin: colors(context).primaryColor,
                                    end: colors(context).light,
                                  ).lerp(0.5),
                            onPressed: () {
                              ref
                                  .read(authControllerProvider.notifier)
                                  .verifyOTP(
                                    phone: widget.arguments.phoneNumber,
                                    otp: pinCodeController.text,
                                  )
                                  .then((response) {
                                if (response.isSuccess) {
                                  if (widget.arguments.isPasswordRecover) {
                                    context.nav.pushNamed(
                                      Routes.createPassword,
                                      arguments: response.data.toString(),
                                    );
                                  } else {
                                    context.nav.pushNamed(
                                      Routes.getCoreRouteName(
                                          AppConstants.appServiceName),
                                    );
                                  }

                                  GlobalFunction.showCustomSnackbar(
                                    message: response.message,
                                    isSuccess: response.isSuccess,
                                  );
                                }
                              });

                              debugPrint('Done');
                            },
                          ),
                  ),
                  Gap(30.h),
                  Text(
                    "${S.of(context).resendCode} 00:$start sec",
                    style: AppTextStyle(context).bodyText.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  if (start == 0)
                    GestureDetector(
                      onTap: () {
                        start = 60;
                        startTimer();
                        initOTP();
                      },
                      child: Text(
                        S.of(context).resend,
                        style: AppTextStyle(context)
                            .bodyTextSmall
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

class ConfirmOTPScreenArguments {
  final String phoneNumber;
  final bool isPasswordRecover;
  ConfirmOTPScreenArguments({
    required this.phoneNumber,
    required this.isPasswordRecover,
  });
}
