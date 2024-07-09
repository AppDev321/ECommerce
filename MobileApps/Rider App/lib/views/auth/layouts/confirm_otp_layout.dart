// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:razinshop_rider/components/my_custom_button.dart';
import 'package:razinshop_rider/config/app_color.dart';
import 'package:razinshop_rider/config/app_text.dart';
import 'package:razinshop_rider/controllers/auth_controller/auth_controller.dart';
import 'package:razinshop_rider/gen/assets.gen.dart';
import 'package:razinshop_rider/generated/l10n.dart';
import 'package:razinshop_rider/routers.dart';
import 'package:razinshop_rider/utils/context_less_navigate.dart';
import 'package:razinshop_rider/views/auth/layouts/pin_put.dart';

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
      // initOTP();
      pinCodeController.text = widget.arguments.otp ?? "";
    });
    startTimer();

    // pinCodeController.addListener(pinCodeListener);
    super.initState();
  }

  Future initOTP() async {
    String? otp = await ref
        .read(sendOTPProvider.notifier)
        .sendOTP(phone: widget.arguments.phoneNumber, isForgetPass: false);
    if (otp != null) {
      pinCodeController.text = otp;
    }
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
        backgroundColor: AppColor.whiteColor,
        appBar: AppBar(
          backgroundColor: AppColor.whiteColor,
          elevation: 0,
          leading: IconButton(
            icon: SvgPicture.asset(Assets.svgs.backArrow),
            color: AppColor.primaryColor,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Assets.pngs.otpSMS.image(width: 200.w),
                Gap(20.h),
                Text(
                  S.of(context).sendOTP,
                  style: AppTextStyle.title.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 28.sp,
                  ),
                ),
                Gap(20.h),
                Column(
                  children: [
                    Text(
                      S.of(context).weSendOTP,
                      style: AppTextStyle.normalBody.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(widget.arguments.phoneNumber,
                            style: AppTextStyle.normalBody.copyWith(
                              fontWeight: FontWeight.w500,
                            )),
                        Gap(5.w),
                        GestureDetector(
                          onTap: () {
                            context.nav.pop();
                          },
                          child: SvgPicture.asset(
                            Assets.svgs.edit2,
                            colorFilter: ColorFilter.mode(
                                AppColor.primaryColor, BlendMode.srcIn),
                          ),
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
                ),
                Gap(30.h),
                Consumer(
                  builder: (context, ref, child) {
                    final verifyOTP = ref.watch(verifyOTPProvider);
                    return verifyOTP
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : MyCustomButton(
                            onTap: () {
                              ref
                                  .read(verifyOTPProvider.notifier)
                                  .verifyOTP(
                                    phone: widget.arguments.phoneNumber,
                                    otp: pinCodeController.text,
                                  )
                                  .then((value) {
                                if (value != null) {
                                  context.nav.pushNamed(
                                    Routes.createPassword,
                                    arguments: widget.arguments.copyWith(
                                      token: value,
                                    ),
                                  );
                                }
                              });
                            },
                            btnText: S.of(context).confirmOTP,
                          );
                  },
                ),
                Gap(30.h),
                Text(
                  "${S.of(context).resendOTPCode} 00:${start.toString().padLeft(2, "0")} sec",
                  style: AppTextStyle.normalBody.copyWith(
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
                      S.of(context).resendOTP,
                      style: AppTextStyle.normalBody
                          .copyWith(color: AppColor.primaryColor),
                    ),
                  ),
              ],
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
  String? token;
  final Map<String, dynamic> userData;
  String? otp;
  ConfirmOTPScreenArguments({
    required this.phoneNumber,
    required this.isPasswordRecover,
    this.token,
    required this.userData,
    this.otp,
  });

  // make copy with
  ConfirmOTPScreenArguments copyWith({
    String? phoneNumber,
    bool? isPasswordRecover,
    String? token,
    Map<String, dynamic>? userData,
    String? otp,
  }) {
    return ConfirmOTPScreenArguments(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      isPasswordRecover: isPasswordRecover ?? this.isPasswordRecover,
      token: token ?? this.token,
      userData: userData ?? this.userData,
      otp: otp ?? this.otp,
    );
  }
}
