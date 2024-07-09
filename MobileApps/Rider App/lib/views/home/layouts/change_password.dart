import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:razinshop_rider/components/my_custom_button.dart';
import 'package:razinshop_rider/config/app_color.dart';
import 'package:razinshop_rider/config/app_text.dart';
import 'package:razinshop_rider/config/theme.dart';
import 'package:razinshop_rider/controllers/auth_controller/auth_controller.dart';
import 'package:razinshop_rider/generated/l10n.dart';
import 'package:razinshop_rider/utils/context_less_navigate.dart';

class ChangePasswordScreen extends ConsumerStatefulWidget {
  ChangePasswordScreen({
    super.key,
  });

  @override
  ConsumerState<ChangePasswordScreen> createState() =>
      _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends ConsumerState<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool _currentPasswordVisible = false;
  bool _newPasswordVisible = false;
  bool _confirmPasswordVisible = false;
  @override
  Widget build(BuildContext context) {
    final loading = ref.watch(changePasswordProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).changePassword,
          style: AppTextStyle.largeBody,
        ),
      ),
      body: Container(
        child: FormBuilder(
          key: _formKey,
          child: Column(
            children: [
              Gap(12.h),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(color: AppColor.whiteColor),
                child: Column(
                  children: [
                    FormBuilderTextField(
                      name: 'current_password',
                      obscureText: !_currentPasswordVisible,
                      decoration: AppTheme.inputDecoration.copyWith(
                        labelText: S.of(context).currentPassword,
                        labelStyle: TextStyle(
                          color: Colors.grey.withOpacity(0.8),
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _currentPasswordVisible =
                                  !_currentPasswordVisible;
                            });
                          },
                          icon: Icon(
                            _currentPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter current password";
                        }
                        return null;
                      },
                    ),
                    const Gap(20),
                    // new password with end eye icon
                    FormBuilderTextField(
                      name: 'password',
                      obscureText: !_newPasswordVisible,
                      decoration: AppTheme.inputDecoration.copyWith(
                        labelText: S.of(context).newPassword,
                        labelStyle: TextStyle(
                          color: Colors.grey.withOpacity(0.8),
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _newPasswordVisible = !_newPasswordVisible;
                            });
                          },
                          icon: Icon(
                            _newPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter new password";
                        }
                        return null;
                      },
                    ),
                    const Gap(20),
                    // confirm password with end eye icon
                    FormBuilderTextField(
                      name: 'password_confirmation',
                      obscureText: !_confirmPasswordVisible,
                      decoration: AppTheme.inputDecoration.copyWith(
                        labelText: S.of(context).confirmNewPassword,
                        labelStyle: TextStyle(
                          color: Colors.grey.withOpacity(0.8),
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _confirmPasswordVisible =
                                  !_confirmPasswordVisible;
                            });
                          },
                          icon: Icon(
                            _confirmPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ),
                      ),
                      // matching the password
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter confirm password";
                        }
                        if (value !=
                            _formKey.currentState!.fields['password']!.value) {
                          return "Password does not match";
                        }
                        return null;
                      },
                    ),
                    Gap(25.h),
                    loading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : MyCustomButton(
                            onTap: () {
                              if (_formKey.currentState!.saveAndValidate()) {
                                ref
                                    .read(changePasswordProvider.notifier)
                                    .changePassword(
                                      data: _formKey.currentState!.value,
                                    )
                                    .then((value) {
                                  if (value == true) {
                                    context.nav.pop();
                                  }
                                });
                              }
                            },
                            btnText: S.of(context).updatePassword,
                          )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
