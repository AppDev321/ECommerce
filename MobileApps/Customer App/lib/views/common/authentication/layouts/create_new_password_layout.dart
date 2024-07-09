import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:razin_shop/components/ecommerce/custom_button.dart';
import 'package:razin_shop/components/ecommerce/custom_text_field.dart';
import 'package:razin_shop/config/app_text_style.dart';
import 'package:razin_shop/config/theme.dart';
import 'package:razin_shop/controllers/eCommerce/authentication/authentication_controller.dart';
import 'package:razin_shop/controllers/misc/misc_controller.dart';
import 'package:razin_shop/generated/l10n.dart';
import 'package:razin_shop/routes.dart';
import 'package:razin_shop/utils/context_less_navigation.dart';
import 'package:razin_shop/utils/global_function.dart';

class CreateNewPasswordLayout extends StatefulWidget {
  final String forgotPasswordToken;
  const CreateNewPasswordLayout({
    Key? key,
    required this.forgotPasswordToken,
  }) : super(key: key);

  @override
  State<CreateNewPasswordLayout> createState() =>
      _CreateNewPasswordLayoutState();
}

class _CreateNewPasswordLayoutState extends State<CreateNewPasswordLayout> {
  final TextEditingController newPasswordController = TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();

  final List<FocusNode> fNodes = [FocusNode(), FocusNode()];

  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();

  @override
  void dispose() {
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: FormBuilder(
          key: formKey,
          child: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: 20.w).copyWith(top: 110.h),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    S.of(context).createNewPass,
                    style: AppTextStyle(context)
                        .title
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  Gap(20.h),
                  Text(
                    S.of(context).typeConfirmSecretPassword,
                    textAlign: TextAlign.center,
                    style: AppTextStyle(context).bodyText.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  Gap(40.h),
                  Consumer(builder: (context, ref, _) {
                    return CustomTextFormField(
                      name: S.of(context).newPassword,
                      hintText: S.of(context).createNewPass,
                      focusNode: fNodes[0],
                      textInputType: TextInputType.text,
                      controller: newPasswordController,
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
                      validator: (value) => GlobalFunction.passwordValidator(
                        value: value!,
                        hintText: S.of(context).newPassword,
                        context: context,
                      ),
                    );
                  }),
                  Gap(20.h),
                  Consumer(
                    builder: (context, ref, _) {
                      return CustomTextFormField(
                        name: S.of(context).confirmPassword,
                        hintText: S.of(context).confirmNewPass,
                        focusNode: fNodes[1],
                        textInputType: TextInputType.text,
                        controller: confirmPasswordController,
                        textInputAction: TextInputAction.done,
                        validator: (value) => GlobalFunction.passwordValidator(
                          value: value!,
                          hintText: S.of(context).confirmPassword,
                          context: context,
                        ),
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
                      );
                    },
                  ),
                  Gap(30.h),
                  Consumer(builder: (context, ref, _) {
                    return ref.watch(authControllerProvider)
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : CustomButton(
                            buttonText: S.of(context).setPassword,
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                if (confirmPasswordController.text ==
                                    newPasswordController.text) {
                                  ref
                                      .read(authControllerProvider.notifier)
                                      .resetPassword(
                                        password: newPasswordController.text,
                                        confrimPassword:
                                            confirmPasswordController.text,
                                        forgotPasswordToken:
                                            widget.forgotPasswordToken,
                                      )
                                      .then((response) {
                                    if (response.isSuccess) {
                                      GlobalFunction.showCustomSnackbar(
                                        message: response.message,
                                        isSuccess: response.isSuccess,
                                      );
                                      context.nav
                                          .pushReplacementNamed(Routes.login);
                                    }
                                  });
                                } else {
                                  GlobalFunction.showCustomSnackbar(
                                    message: 'Passwords do not match',
                                    isSuccess: false,
                                  );
                                }
                              }
                            },
                          );
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
