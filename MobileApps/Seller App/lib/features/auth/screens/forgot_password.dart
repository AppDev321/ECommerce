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

class ForgotPassowrd extends StatelessWidget {
  const ForgotPassowrd({super.key});

  static final GlobalKey<FormBuilderState> _formKey =
      GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors(context).light,
      body: SafeArea(child: _buildBody()),
    );
  }

  Widget _buildBody() {
    return Consumer(builder: (context, ref, _) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: FormBuilder(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(24.h),
              const AppLogo(
                isAnimation: true,
                withAppName: true,
              ),
              Gap(62.h),
              Text(
                'Forgot Password?',
                style: AppTextStyle.text24B700,
              ),
              Gap(12.h),
              Text(
                "Enter your registered email address, we'll send you an OTP code to reset your password.",
                style: AppTextStyle.text14B400.copyWith(
                  fontWeight: FontWeight.w500,
                  color: AppStaticColor.gray,
                ),
              ),
              Gap(24.h),
              CustomTextFormField(
                name: 'Email',
                textInputType: TextInputType.text,
                controller: ref.read(emailController),
                textInputAction: TextInputAction.done,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                      errorText: 'Email is required'),
                  FormBuilderValidators.email(errorText: 'Invalid email'),
                ]),
                hintText: 'Enter email address',
              ),
              Gap(24.h),
              ref.watch(authServiceProvider)
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : CustomButton(
                      buttonName: 'Send OTP',
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          ref
                              .read(authServiceProvider.notifier)
                              .sendOTP(
                                  email: ref.read(emailController).text,
                                  isForgotPassword: true)
                              .then((response) => response.status
                                  ? GoRouter.of(context).push(Routes.confirmOTP,
                                      extra: ref.read(emailController).text)
                                  : null);
                        }
                      },
                    ),
            ],
          ),
        ),
      );
    });
  }
}

final emailController = Provider<TextEditingController>((ref) {
  final controller = TextEditingController();

  ref.onDispose(() {
    controller.dispose();
  });
  return controller;
});
