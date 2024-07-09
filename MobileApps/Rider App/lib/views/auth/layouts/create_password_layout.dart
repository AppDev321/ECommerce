import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';
import 'package:razinshop_rider/components/custom_appBar.dart';
import 'package:razinshop_rider/components/my_custom_button.dart';
import 'package:razinshop_rider/config/app_color.dart';
import 'package:razinshop_rider/config/app_text.dart';
import 'package:razinshop_rider/config/theme.dart';
import 'package:razinshop_rider/controllers/auth_controller/auth_controller.dart';
import 'package:razinshop_rider/generated/l10n.dart';
import 'package:razinshop_rider/routers.dart';
import 'package:razinshop_rider/utils/context_less_navigate.dart';
import 'package:razinshop_rider/views/auth/layouts/confirm_otp_layout.dart';

class CreatePasswordLayout extends ConsumerStatefulWidget {
  CreatePasswordLayout({super.key, required this.userData});
  final ConfirmOTPScreenArguments userData;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CreatePasswordLayoutState();
}

class _CreatePasswordLayoutState extends ConsumerState<CreatePasswordLayout> {
  bool isCreatePassVisible = false;
  bool isConfirmPassVisible = false;
  final _formkey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(title: S.of(context).createAPassword),
          Gap(15.h),
          FormBuilder(
            key: _formkey,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.r, vertical: 8.r),
              color: AppColor.whiteColor,
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  headerText(title: S.of(context).createAPassword),
                  Gap(10.h),
                  FormBuilderTextField(
                    name: "password",
                    obscureText: !isCreatePassVisible,
                    decoration: AppTheme.inputDecoration.copyWith(
                      hintText: S.of(context).createAPassword,
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              isCreatePassVisible = !isCreatePassVisible;
                            });
                          },
                          icon: Icon(
                            isCreatePassVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: AppColor.greyColor,
                          ),
                        ),
                      ),
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.minLength(6),
                    ]),
                  ),
                  Gap(30.h),
                  headerText(title: S.of(context).confirmPassword),
                  Gap(10.h),
                  FormBuilderTextField(
                    name: "password_confirmation",
                    obscureText: !isConfirmPassVisible,
                    decoration: AppTheme.inputDecoration.copyWith(
                      hintText: S.of(context).confirmPassword,
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              isConfirmPassVisible = !isConfirmPassVisible;
                            });
                          },
                          icon: Icon(
                            isConfirmPassVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: AppColor.greyColor,
                          ),
                        ),
                      ),
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      (val) {
                        if (val !=
                            _formkey.currentState!.fields['password']!.value) {
                          return "Password must be same as above";
                        }
                        return null;
                      }
                    ]),
                  ),
                  Gap(30.h),
                  widget.userData.isPasswordRecover
                      ? Consumer(
                          builder: (context, ref, child) {
                            final loading = ref.watch(createPasswordProvider);
                            return loading
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : MyCustomButton(
                                    onTap: () {
                                      // context.nav.pushNamed(Routes.review);
                                      if (_formkey.currentState!
                                          .saveAndValidate()) {
                                        final formData = {
                                          ..._formkey.currentState!.value,
                                          'token': widget.userData.token,
                                        };
                                        ref
                                            .read(
                                                createPasswordProvider.notifier)
                                            .createPassword(data: formData)
                                            .then((value) {
                                          if (value == true) {
                                            context.nav.pushNamed(Routes.login);
                                          }
                                        });
                                      }
                                    },
                                    btnText: S.of(context).setPassword,
                                  );
                          },
                        )
                      : Consumer(
                          builder: (context, ref, child) {
                            final loading = ref.watch(registrationProvider);
                            return loading
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : MyCustomButton(
                                    onTap: () {
                                      // context.nav.pushNamed(Routes.review);
                                      if (_formkey.currentState!
                                          .saveAndValidate()) {
                                        final formData = {
                                          ...widget.userData.userData,
                                          ..._formkey.currentState!.value
                                        };
                                        ref
                                            .read(registrationProvider.notifier)
                                            .registration(data: formData)
                                            .then((value) {
                                          if (value == true) {
                                            context.nav.pushNamed(
                                              Routes.review,
                                              arguments: widget
                                                  .userData.userData['phone'],
                                            );
                                          }
                                        });
                                      }
                                    },
                                    btnText: S.of(context).setPassword,
                                  );
                          },
                        ),
                  Gap(10.h),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Text headerText({required String title}) {
    return Text(
      title,
      style: AppTextStyle.normalBody,
    );
  }
}
