import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import 'package:razinshop_rider/config/app_color.dart';

class PinPutWidget extends StatefulWidget {
  final void Function(String)? onCompleted;
  final String? Function(String?)? validator;
  final TextEditingController pinCodeController;
  const PinPutWidget({
    Key? key,
    required this.onCompleted,
    required this.validator,
    required this.pinCodeController,
  }) : super(key: key);

  @override
  State<PinPutWidget> createState() => _PinputExampleState();
}

class _PinputExampleState extends State<PinPutWidget> {
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();

  void _handleCompleted(String pin) {
    if (widget.onCompleted != null) {
      widget.onCompleted!(pin);
    }
  }

  String? _validatePin(String? value) {
    return widget.validator!(value);
  }

  @override
  void dispose() {
    widget.pinCodeController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
        width: 80.w,
        height: 56.h,
        textStyle: TextStyle(
          fontSize: 22.sp,
          // color: EcommerceAppColor.gray,
        ),
        decoration: BoxDecoration(
          // color: colors(context).light,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            width: 2,
            color: AppColor.borderColor,
          ),
        ));

    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Directionality(
            textDirection: TextDirection.ltr,
            child: Pinput(
              preFilledWidget: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 20.h),
                    width: 10,
                    height: 1,
                    color: Colors.grey,
                  ),
                ],
              ),
              controller: widget.pinCodeController,
              focusNode: focusNode,
              androidSmsAutofillMethod:
                  AndroidSmsAutofillMethod.smsUserConsentApi,
              listenForMultipleSmsOnAndroid: true,
              defaultPinTheme: defaultPinTheme,
              separatorBuilder: (index) => const SizedBox(width: 16),
              validator: _validatePin,
              hapticFeedbackType: HapticFeedbackType.lightImpact,
              onCompleted: _handleCompleted,
              cursor: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 20.h),
                    width: 10,
                    height: 1,
                    color: AppColor.primaryColor,
                  ),
                ],
              ),
              focusedPinTheme: defaultPinTheme.copyWith(
                decoration: defaultPinTheme.decoration!.copyWith(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: AppColor.borderColor),
                ),
              ),
              submittedPinTheme: defaultPinTheme.copyWith(
                decoration: defaultPinTheme.decoration!.copyWith(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    width: 2,
                    color: AppColor.borderColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
