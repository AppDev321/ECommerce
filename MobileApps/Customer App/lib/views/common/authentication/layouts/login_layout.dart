import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:razin_shop/components/ecommerce/app_logo.dart';
import 'package:razin_shop/components/ecommerce/custom_button.dart';
import 'package:razin_shop/components/ecommerce/custom_text_field.dart';
import 'package:razin_shop/config/app_color.dart';
import 'package:razin_shop/config/app_constants.dart';
import 'package:razin_shop/config/app_text_style.dart';
import 'package:razin_shop/config/theme.dart';
import 'package:razin_shop/controllers/eCommerce/address/address_controller.dart';
import 'package:razin_shop/controllers/eCommerce/authentication/authentication_controller.dart';
import 'package:razin_shop/controllers/misc/misc_controller.dart';
import 'package:razin_shop/generated/l10n.dart';
import 'package:razin_shop/routes.dart';
import 'package:razin_shop/services/common/hive_service_provider.dart';
import 'package:razin_shop/utils/context_less_navigation.dart';
import 'package:razin_shop/utils/global_function.dart';

class LoginLayout extends StatefulWidget {
  const LoginLayout({super.key});

  @override
  State<LoginLayout> createState() => _LoginLayoutState();
}

class _LoginLayoutState extends State<LoginLayout> {
  final TextEditingController phoneController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final List<FocusNode> fNodes = [FocusNode(), FocusNode()];

  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    phoneController.text = 'user@readyecommerce.com';
    passwordController.text = 'secret';
    super.initState();
  }

  @override
  void dispose() {
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
                  S.of(context).dontHaveAccount,
                  style: AppTextStyle(context).bodyText.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
                Gap(5.w),
                GestureDetector(
                  onTap: () => context.nav.pushNamed(Routes.singUp),
                  child: Text(
                    S.of(context).signUp,
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
            S.of(context).welcomeBack,
            style: AppTextStyle(context)
                .title
                .copyWith(fontWeight: FontWeight.bold),
          ),
          Gap(20.h),
          CustomTextFormField(
            name: S.of(context).emailOrPhone,
            hintText: S.of(context).emailOrPhone,
            textInputType: TextInputType.text,
            controller: phoneController,
            focusNode: fNodes[0],
            textInputAction: TextInputAction.next,
            validator: (value) => GlobalFunction.commonValidator(
              value: value!,
              hintText: S.of(context).emailOrPhone,
              context: context,
            ),
          ),
          Gap(20.h),
          Consumer(builder: (context, ref, _) {
            return CustomTextFormField(
              name: S.of(context).password,
              hintText: S.of(context).password,
              textInputType: TextInputType.text,
              focusNode: fNodes[1],
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
          Gap(20.h),
          Align(
            alignment: Alignment.bottomRight,
            child: GestureDetector(
              onTap: () => context.nav.pushNamed(
                Routes.recoverPassword,
              ),
              child: Text(
                S.of(context).forgotPassword,
                style: AppTextStyle(context).bodyText,
              ),
            ),
          ),
          Gap(30.h),
          Consumer(builder: (context, ref, _) {
            return ref.watch(authControllerProvider)
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : CustomButton(
                    buttonText: S.of(context).login,
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      if (formKey.currentState!.validate()) {
                        ref
                            .read(authControllerProvider.notifier)
                            .login(
                              phone: phoneController.text,
                              password: passwordController.text,
                            )
                            .then((response) {
                          ref
                              .read(addressControllerProvider.notifier)
                              .getAddress();
                          if (response.isSuccess) {
                            context.nav.pushNamed(Routes.getCoreRouteName(
                                AppConstants.appServiceName));
                          }
                        });
                      }
                    },
                  );
          }),
          Consumer(builder: (context, ref, _) {
            return Align(
              alignment: Alignment.center,
              child: Visibility(
                  visible: !ref.read(hiveServiceProvider).userIsLoggedIn(),
                  child: Padding(
                    padding: EdgeInsets.only(top: 16.h),
                    child: TextButton(
                      onPressed: () {
                        context.nav.pushNamed(Routes.getCoreRouteName(
                            AppConstants.appServiceName));
                      },
                      child: Text(
                        'Skip',
                        style: AppTextStyle(context).buttonText,
                      ),
                    ),
                  )),
            );
          })
        ],
      ),
    );
  }
}
