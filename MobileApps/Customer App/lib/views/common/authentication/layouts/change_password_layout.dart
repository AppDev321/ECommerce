import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:razin_shop/components/ecommerce/custom_button.dart';
import 'package:razin_shop/components/ecommerce/custom_text_field.dart';
import 'package:razin_shop/config/theme.dart';
import 'package:razin_shop/controllers/eCommerce/authentication/authentication_controller.dart';
import 'package:razin_shop/controllers/misc/misc_controller.dart';
import 'package:razin_shop/generated/l10n.dart';
import 'package:razin_shop/utils/context_less_navigation.dart';
import 'package:razin_shop/utils/global_function.dart';

class ChangePasswordLayout extends StatefulWidget {
  const ChangePasswordLayout({super.key});
  static late TextEditingController oldPasswordController;
  static late TextEditingController newPasswordController;
  static late TextEditingController confirmNewPasswordController;

  static GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();
  @override
  State<ChangePasswordLayout> createState() => _ChangePasswordLayoutState();
}

class _ChangePasswordLayoutState extends State<ChangePasswordLayout> {
  @override
  void dispose() {
    ChangePasswordLayout.oldPasswordController.dispose();
    ChangePasswordLayout.newPasswordController.dispose();
    ChangePasswordLayout.confirmNewPasswordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    initController();
    super.initState();
  }

  initController() {
    ChangePasswordLayout.oldPasswordController = TextEditingController();
    ChangePasswordLayout.newPasswordController = TextEditingController();
    ChangePasswordLayout.confirmNewPasswordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: GlobalFunction.getBackgroundColor(context: context),
        appBar: AppBar(
            title: const Text('Change Password'),
            surfaceTintColor: Theme.of(context).scaffoldBackgroundColor),
        body: SingleChildScrollView(
          child: FormBuilder(
            key: ChangePasswordLayout.formKey,
            child: Column(
              children: [
                Gap(10.h),
                Consumer(builder: (context, ref, _) {
                  return Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                    width: double.infinity,
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextFormField(
                          name: S.of(context).currentPassword,
                          hintText: S.of(context).enterCurrentPass,
                          textInputType: TextInputType.text,
                          controller:
                              ChangePasswordLayout.oldPasswordController,
                          textInputAction: TextInputAction.next,
                          obscureText: ref.watch(obscureText1),
                          widget: IconButton(
                            splashColor: Colors.transparent,
                            onPressed: () {
                              ref.read(obscureText1.notifier).state =
                                  !ref.read(obscureText1);
                            },
                            icon: Icon(
                              !ref.watch(obscureText1)
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: colors(context).hintTextColor,
                            ),
                          ),
                          validator: (value) => GlobalFunction.commonValidator(
                            value: value!,
                            hintText: S.of(context).enterCurrentPass,
                            context: context,
                          ),
                        ),
                        Gap(24.h),
                        CustomTextFormField(
                          name: S.of(context).newPassword,
                          hintText: S.of(context).createNewPass,
                          textInputType: TextInputType.text,
                          controller:
                              ChangePasswordLayout.newPasswordController,
                          textInputAction: TextInputAction.next,
                          obscureText: ref.watch(obscureText2),
                          widget: IconButton(
                            splashColor: Colors.transparent,
                            onPressed: () {
                              ref.read(obscureText2.notifier).state =
                                  !ref.read(obscureText2);
                            },
                            icon: Icon(
                              !ref.watch(obscureText2)
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: colors(context).hintTextColor,
                            ),
                          ),
                          validator: (value) => GlobalFunction.commonValidator(
                            value: value!,
                            hintText: S.of(context).createNewPassword,
                            context: context,
                          ),
                        ),
                        Gap(24.h),
                        CustomTextFormField(
                          name: S.of(context).confirmPassword,
                          hintText: S.of(context).confirmNewPass,
                          textInputType: TextInputType.text,
                          controller:
                              ChangePasswordLayout.confirmNewPasswordController,
                          textInputAction: TextInputAction.next,
                          obscureText: ref.watch(obscureText3),
                          widget: IconButton(
                            splashColor: Colors.transparent,
                            onPressed: () {
                              ref.read(obscureText3.notifier).state =
                                  !ref.read(obscureText3);
                            },
                            icon: Icon(
                              !ref.watch(obscureText3)
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: colors(context).hintTextColor,
                            ),
                          ),
                          validator: (value) => GlobalFunction.commonValidator(
                            value: value!,
                            hintText: S.of(context).confirmNewPass,
                            context: context,
                          ),
                        ),
                        Gap(24.h),
                        ref.watch(authControllerProvider)
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : CustomButton(
                                buttonText: S.of(context).updatePassword,
                                onPressed: () {
                                  if (ChangePasswordLayout.formKey.currentState!
                                      .validate()) {
                                    ref
                                        .read(authControllerProvider.notifier)
                                        .changePassword(
                                          oldPassword: ChangePasswordLayout
                                              .oldPasswordController.text,
                                          newPassword: ChangePasswordLayout
                                              .newPasswordController.text,
                                          confirmNewPassword:
                                              ChangePasswordLayout
                                                  .confirmNewPasswordController
                                                  .text,
                                        )
                                        .then((response) {
                                      if (response.isSuccess) {
                                        ChangePasswordLayout
                                            .oldPasswordController
                                            .clear();
                                        ChangePasswordLayout
                                            .newPasswordController
                                            .clear();
                                        ChangePasswordLayout
                                            .confirmNewPasswordController
                                            .clear();
                                        context.nav.pop(context);
                                        GlobalFunction.showCustomSnackbar(
                                          message: response.message,
                                          isSuccess: response.isSuccess,
                                        );
                                      }
                                    });
                                  }
                                },
                              )
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
