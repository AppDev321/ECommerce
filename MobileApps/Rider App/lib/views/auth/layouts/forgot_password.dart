import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';
import 'package:razinshop_rider/components/my_custom_button.dart';
import 'package:razinshop_rider/config/app_color.dart';
import 'package:razinshop_rider/config/theme.dart';
import 'package:razinshop_rider/controllers/auth_controller/auth_controller.dart';
import 'package:razinshop_rider/gen/assets.gen.dart';
import 'package:razinshop_rider/generated/l10n.dart';
import 'package:razinshop_rider/routers.dart';
import 'package:razinshop_rider/utils/context_less_navigate.dart';
import 'package:razinshop_rider/views/auth/layouts/confirm_otp_layout.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColor.whiteColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: AppColor.primaryColor,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Assets.pngs.riderApp.image(width: 200.w),
          Gap(65.h),
          FormBuilder(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    S.of(context).forgotPassword,
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Gap(12.h),
                  Text(
                    S.of(context).enterRegPhnNumbr,
                    style: TextStyle(
                      color: AppColor.greyColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Gap(24.h),
                  Text(
                    S.of(context).phoneNumber,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Gap(12.h),
                  FormBuilderTextField(
                    name: "phone",
                    keyboardType: TextInputType.phone,
                    decoration: AppTheme.inputDecoration.copyWith(
                      hintText: S.of(context).enterPhoneNumber,
                      hintStyle: TextStyle(
                        color: AppColor.greyColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    validator: FormBuilderValidators.compose(
                      [
                        FormBuilderValidators.required(),
                        FormBuilderValidators.minLength(10),
                        FormBuilderValidators.maxLength(11),
                      ],
                    ),
                  ),
                  Gap(30.h),
                  // mycustombutton
                  Consumer(
                    builder: (context, ref, child) {
                      final loading = ref.watch(sendOTPProvider);
                      return loading
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : MyCustomButton(
                              onTap: () {
                                if (_formKey.currentState!.saveAndValidate()) {
                                  ref
                                      .read(sendOTPProvider.notifier)
                                      .sendOTP(
                                        phone: _formKey.currentState!
                                            .fields['phone']!.value
                                            .toString(),
                                        isForgetPass: true,
                                      )
                                      .then((value) {
                                    if (value != null) {
                                      context.nav.pushNamed(
                                        Routes.confirmOTP,
                                        arguments: ConfirmOTPScreenArguments(
                                          phoneNumber: _formKey.currentState!
                                              .fields['phone']!.value
                                              .toString(),
                                          isPasswordRecover: true,
                                          userData: {},
                                          otp: value,
                                        ),
                                      );
                                    }
                                  });
                                }
                              },
                              btnText: S.of(context).sendOTP,
                            );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
