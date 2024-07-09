import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:razin_shop/components/ecommerce/app_logo.dart';
import 'package:razin_shop/components/ecommerce/custom_button.dart';
import 'package:razin_shop/components/ecommerce/custom_text_field.dart';
import 'package:razin_shop/config/app_color.dart';
import 'package:razin_shop/config/app_text_style.dart';
import 'package:razin_shop/config/theme.dart';
import 'package:razin_shop/controllers/eCommerce/authentication/authentication_controller.dart';
import 'package:razin_shop/controllers/misc/misc_controller.dart';
import 'package:razin_shop/generated/l10n.dart';
import 'package:razin_shop/models/eCommerce/authentication/sign_up.dart';
import 'package:razin_shop/routes.dart';
import 'package:razin_shop/utils/context_less_navigation.dart';
import 'package:razin_shop/utils/global_function.dart';
import 'package:razin_shop/views/common/authentication/layouts/confirm_otp_layout.dart';

class SignUpLayout extends StatefulWidget {
  const SignUpLayout({super.key});

  @override
  State<SignUpLayout> createState() => _SignUpLayoutState();
}

class _SignUpLayoutState extends State<SignUpLayout> {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController phoneController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final List<FocusNode> fNodes = [FocusNode(), FocusNode(), FocusNode()];

  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();

  bool isChecked = false;
  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        bottomNavigationBar: SizedBox(
          height: 60.h,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  S.of(context).alreadyHaveAnAccount,
                  style: AppTextStyle(context).bodyText.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
                Gap(5.w),
                GestureDetector(
                  onTap: () => context.nav.pop(),
                  child: Text(
                    S.of(context).login,
                    style: AppTextStyle(context).bodyText.copyWith(
                          fontWeight: FontWeight.w700,
                          color: colors(context).primaryColor,
                        ),
                  ),
                )
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: FormBuilder(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildHeader(context),
                buildBody(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container buildHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 60.h),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(16.0),
          bottomRight: Radius.circular(16.0),
        ),
        boxShadow: [
          BoxShadow(
            color: colors(context).accentColor ?? EcommerceAppColor.offWhite,
            blurRadius: 10,
            spreadRadius: 2,
            offset: const Offset(
              0,
              2,
            ),
          )
        ],
      ),
      child: const Center(
        child: AppLogo(
          isAnimation: true,
        ),
      ),
    );
  }

  Widget buildBody(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w)
          .copyWith(bottom: 20.h, top: 40.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.of(context).signUp,
            style: AppTextStyle(context)
                .title
                .copyWith(fontWeight: FontWeight.bold),
          ),
          Gap(20.h),
          Text(
            S.of(context).signUpToContinue,
            style: AppTextStyle(context).bodyText.copyWith(
                color: colors(context).bodyTextSmallColor,
                fontWeight: FontWeight.w500),
          ),
          Gap(20.h),
          CustomTextFormField(
            name: S.of(context).fullName,
            hintText: S.of(context).enFullName,
            textInputType: TextInputType.text,
            controller: nameController,
            focusNode: fNodes[0],
            textInputAction: TextInputAction.next,
            validator: (value) => GlobalFunction.commonValidator(
              value: value!,
              hintText: S.of(context).fullName,
              context: context,
            ),
          ),
          Gap(20.h),
          CustomTextFormField(
            name: S.of(context).phoneNumber,
            hintText: S.of(context).enterPhoneNumber,
            textInputType: TextInputType.phone,
            controller: phoneController,
            focusNode: fNodes[1],
            textInputAction: TextInputAction.next,
            validator: (value) => GlobalFunction.phoneValidator(
              value: value!,
              hintText: S.of(context).phoneNumber,
              context: context,
            ),
          ),
          Gap(20.h),
          Consumer(builder: (context, ref, _) {
            return CustomTextFormField(
              name: S.of(context).password,
              hintText: S.of(context).createNewPass,
              textInputType: TextInputType.text,
              focusNode: fNodes[2],
              controller: passwordController,
              textInputAction: TextInputAction.done,
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
                hintText: S.of(context).password,
                context: context,
              ),
            );
          }),
          Gap(24.h),
          Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 28.w),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            "By tapping the ‘Sign up’ button, you agree with our ",
                        style: AppTextStyle(context).bodyText.copyWith(
                              fontWeight: FontWeight.w400,
                              fontSize: 14.sp,
                            ),
                      ),
                      TextSpan(
                        text: 'Terms & Condition',
                        style: AppTextStyle(context).bodyText.copyWith(
                              fontWeight: FontWeight.w400,
                              color: colors(context).primaryColor,
                              fontSize: 14.sp,
                            ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => context.nav
                              .pushNamed(Routes.termsAndConditionsView),
                      ),
                      TextSpan(
                        text: ' and ',
                        style: AppTextStyle(context).bodyText.copyWith(
                              fontWeight: FontWeight.w400,
                              fontSize: 14.sp,
                            ),
                      ),
                      TextSpan(
                        text: 'Privacy Policy ',
                        style: AppTextStyle(context).bodyText.copyWith(
                              fontWeight: FontWeight.w400,
                              color: colors(context).primaryColor,
                              fontSize: 14.sp,
                            ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () =>
                              context.nav.pushNamed(Routes.privacyPolicyView),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: -14,
                top: -5,
                child: Checkbox(
                    value: isChecked,
                    onChanged: (value) {
                      setState(() {
                        isChecked = value!;
                      });
                    }),
              )
            ],
          ),
          Gap(30.h),
          Hero(
            tag: 'otp',
            child: Consumer(builder: (context, ref, _) {
              return ref.watch(authControllerProvider)
                  ? const Center(child: CircularProgressIndicator())
                  : CustomButton(
                      buttonText: S.of(context).signUp,
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        if (formKey.currentState!.validate()) {
                          final SingUp singUpInfo = SingUp(
                            name: nameController.text,
                            phone: phoneController.text,
                            password: passwordController.text,
                          );
                          if (isChecked) {
                            ref
                                .read(authControllerProvider.notifier)
                                .singUp(singUpInfo: singUpInfo)
                                .then((response) {
                              if (response.isSuccess) {
                                context.nav.pushNamed(
                                  Routes.confirmOTP,
                                  arguments: ConfirmOTPScreenArguments(
                                    phoneNumber: phoneController.text,
                                    isPasswordRecover: false,
                                  ),
                                );
                              }
                            });
                          } else {
                            GlobalFunction.showCustomSnackbar(
                              message:
                                  'Please accept the terms and conditions!',
                              isSuccess: false,
                            );
                          }
                        }
                      },
                    );
            }),
          )
        ],
      ),
    );
  }
}
