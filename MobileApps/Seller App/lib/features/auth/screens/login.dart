import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:razin_commerce_seller_flutter/config/app_color.dart';
import 'package:razin_commerce_seller_flutter/config/app_text_style.dart';
import 'package:razin_commerce_seller_flutter/config/routes.dart';
import 'package:razin_commerce_seller_flutter/config/theme.dart';
import 'package:razin_commerce_seller_flutter/features/auth/providers/auth_provider.dart';
import 'package:razin_commerce_seller_flutter/features/common/widgets/app_logo.dart';
import 'package:razin_commerce_seller_flutter/features/common/widgets/custom_button.dart';
import 'package:razin_commerce_seller_flutter/features/common/widgets/custom_text_field.dart';
import 'package:razin_commerce_seller_flutter/utils/global_function.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  static final contactController = TextEditingController();
  static final passController = TextEditingController();
  static final GlobalKey<FormBuilderState> formKey =
      GlobalKey<FormBuilderState>();

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  void initState() {
    init();
    super.initState();
  }

  void init() {
    Login.contactController.text = 'shop@readyecommerce.com';
    Login.passController.text = 'secret';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStaticColor.white,
      bottomNavigationBar: _buildBottomNavigationBar(context: context),
      body: SafeArea(child: _buildBody()),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Consumer(builder: (context, ref, _) {
        return FormBuilder(
          key: Login.formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Gap(24.h),
                const AppLogo(),
                Gap(100.h),
                Text(
                  'WelCome Back!',
                  style: AppTextStyle.text24B700,
                ),
                Gap(24.h),
                CustomTextFormField(
                  name: 'Phone or Email',
                  textInputType: TextInputType.text,
                  controller: Login.contactController,
                  textInputAction: TextInputAction.next,
                  validator: FormBuilderValidators.required(
                      errorText: 'Enter phone or email address!'),
                  hintText: 'Enter Phone or Email',
                ),
                Gap(20.h),
                Consumer(builder: (context, ref, _) {
                  return CustomTextFormField(
                    obscureText: !ref.watch(passwordVisible),
                    name: 'Password',
                    textInputType: TextInputType.phone,
                    controller: Login.passController,
                    textInputAction: TextInputAction.done,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                          errorText: 'Enter your password here!'),
                      FormBuilderValidators.minLength(6,
                          errorText: 'Password must be at least 6 characters'),
                    ]),
                    hintText: 'Enter password',
                    widget: IconButton(
                      onPressed: () {
                        ref.read(passwordVisible.notifier).state =
                            !ref.watch(passwordVisible);
                      },
                      icon: Icon(ref.watch(passwordVisible)
                          ? Icons.visibility
                          : Icons.visibility_off),
                    ),
                  );
                }),
                Gap(16.h),
                Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () {
                      GoRouter.of(GlobalFunction.navigatorKey.currentContext!)
                          .push(Routes.forgotPassword);
                    },
                    child: Text(
                      'Forgot Password?',
                      style: AppTextStyle.text14B400,
                    ),
                  ),
                ),
                Gap(24.h),
                ref.watch(authServiceProvider)
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : CustomButton(
                        buttonName: 'Log in',
                        onTap: () {
                          if (Login.formKey.currentState!.validate()) {
                            ref
                                .read(authServiceProvider.notifier)
                                .login(
                                  contact: Login.contactController.text.trim(),
                                  password: Login.passController.text,
                                )
                                .then(
                                  (response) => response.status
                                      ? GoRouter.of(context)
                                          .push(Routes.dashboard)
                                      : null,
                                );
                          }
                        },
                      )
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildBottomNavigationBar({required BuildContext context}) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: colors(GlobalFunction.navigatorKey.currentContext)
                .secondaryColor!,
          ),
        ),
      ),
      height: 62.h,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Don't have an account? ",
              style: AppTextStyle.text16B400,
            ),
            InkWell(
              onTap: () {
                GoRouter.of(context).push(Routes.registration);
              },
              child: Text(
                'Register now',
                style: AppTextStyle.text16B400.copyWith(
                  color: colors(GlobalFunction.navigatorKey.currentContext)
                      .primaryColor,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

final passwordVisible = StateProvider<bool>((ref) => false);
