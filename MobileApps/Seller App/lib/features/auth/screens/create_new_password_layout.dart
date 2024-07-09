import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:razin_commerce_seller_flutter/config/app_constants.dart';
import 'package:razin_commerce_seller_flutter/config/routes.dart';
import 'package:razin_commerce_seller_flutter/config/theme.dart';
import 'package:razin_commerce_seller_flutter/features/auth/models/sign_up_model.dart';
import 'package:razin_commerce_seller_flutter/features/auth/providers/auth_provider.dart';
import 'package:razin_commerce_seller_flutter/features/auth/screens/shop_details_widget.dart';
import 'package:razin_commerce_seller_flutter/features/auth/screens/shop_owner_widget.dart';
import 'package:razin_commerce_seller_flutter/features/common/widgets/custom_button.dart';
import 'package:razin_commerce_seller_flutter/features/common/widgets/custom_text_field.dart';
import 'package:razin_commerce_seller_flutter/utils/global_function.dart';

class CreatePassword extends StatefulWidget {
  final String? token;
  const CreatePassword({
    super.key,
    required this.token,
  });

  @override
  State<CreatePassword> createState() => _CreatePasswordState();
}

class _CreatePasswordState extends State<CreatePassword> {
  final List<FocusNode> fNodes = [FocusNode(), FocusNode()];

  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Create a Password'),
        ),
        body: FormBuilder(
          key: formKey,
          child: Consumer(builder: (context, ref, _) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              margin: EdgeInsets.only(top: 8.h),
              color: colors(context).light,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Consumer(builder: (context, ref, _) {
                    return CustomTextFormField(
                      name: 'Create Password',
                      hintText: 'Create password',
                      focusNode: fNodes[0],
                      textInputType: TextInputType.text,
                      controller: ref.read(passwordController),
                      textInputAction: TextInputAction.next,
                      obscureText: ref.watch(isObsecureNewPass),
                      widget: IconButton(
                        splashColor: Colors.transparent,
                        onPressed: () {
                          ref.read(isObsecureNewPass.notifier).state =
                              !ref.watch(isObsecureNewPass);
                        },
                        icon: Icon(
                          ref.watch(isObsecureNewPass)
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                      ),
                      validator: FormBuilderValidators.compose(
                        [
                          FormBuilderValidators.required(
                              errorText: 'Please enter password!'),
                          FormBuilderValidators.minLength(6,
                              errorText:
                                  'Password must be at least 6 characters'),
                        ],
                      ),
                    );
                  }),
                  Gap(20.h),
                  Consumer(
                    builder: (context, ref, _) {
                      return CustomTextFormField(
                        name: 'Confirm Password',
                        hintText: 'Confirm Password',
                        focusNode: fNodes[1],
                        textInputType: TextInputType.text,
                        controller: ref.watch(conPasswordController),
                        textInputAction: TextInputAction.done,
                        validator: FormBuilderValidators.compose(
                          [
                            FormBuilderValidators.required(
                                errorText: 'Please enter confirm password!'),
                            FormBuilderValidators.minLength(6,
                                errorText:
                                    'Password must be at least 6 characters'),
                            FormBuilderValidators.equal(
                              ref.watch(passwordController).text,
                              errorText: 'Password does not match',
                            )
                          ],
                        ),
                        obscureText: ref.watch(isObsecureConfirmPass),
                        widget: IconButton(
                          splashColor: Colors.transparent,
                          onPressed: () {
                            ref.read(isObsecureConfirmPass.notifier).state =
                                !ref.read(isObsecureConfirmPass);
                          },
                          icon: Icon(
                            ref.watch(isObsecureConfirmPass)
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                        ),
                      );
                    },
                  ),
                  Gap(30.h),
                  Consumer(builder: (context, ref, _) {
                    return ref.watch(authServiceProvider)
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : CustomButton(
                            buttonName: 'Set Password',
                            onTap: () {
                              if (formKey.currentState!.validate()) {
                                widget.token == null
                                    ? performSignUp(ref, context)
                                    : performForgotPassword(ref, context);
                              }
                            },
                          );
                  }),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  void performSignUp(WidgetRef ref, BuildContext context) {
    final SignUpModel signUpModel = SignUpModel(
      firstName: ref.read(firstNameController).text,
      lastName: ref.read(lastNameController).text,
      phone: ref.read(phoneController).text,
      email: ref.read(emailController).text,
      gender: ref.read(selectedGender)!,
      dateOfBirth: ref.read(dateOfBirthController).text,
      shopName: ref.read(shopNameController).text,
      password: ref.read(passwordController).text,
      confirmPassword: ref.read(conPasswordController).text,
    );
    ref
        .read(authServiceProvider.notifier)
        .signUp(
          signUpModel: signUpModel,
          profile: ref.read(selectedProfileImage)!,
          shopLogo: ref.read(selectedShopLogo)!,
          shopBanner: ref.read(selectedShopBanner)!,
        )
        .then(
      (response) {
        response.status
            ? accountCreateSuccess(
                context: context, phone: ref.read(phoneController).text)
            : GlobalFunction.showCustomSnackbar(
                message: response.message,
                isSuccess: response.status,
              );
      },
    );
  }

  void performForgotPassword(WidgetRef ref, BuildContext context) {
    ref
        .read(authServiceProvider.notifier)
        .forgotPassowrd(
            password: ref.read(passwordController).text,
            confirmPassword: ref.read(conPasswordController).text,
            token: widget.token!)
        .then((response) {
      if (response.status) {
        GlobalFunction.showCustomSnackbar(
            message: response.message, isSuccess: response.status);
        context.go(Routes.login);
      } else {
        GlobalFunction.showCustomSnackbar(
            message: response.message, isSuccess: response.status);
      }
    });
  }
}

void accountCreateSuccess({
  required BuildContext context,
  required String phone,
}) {
  Hive.openBox(AppConstants.appSettingsBox).then(
    (box) => [box.put(AppConstants.phone, phone), box.close()],
  );
  context.go(Routes.underReview);
}

final isObsecureNewPass = StateProvider<bool>((ref) => true);
final isObsecureConfirmPass = StateProvider<bool>((ref) => true);
final passwordController = Provider<TextEditingController>((ref) {
  final controller = TextEditingController();

  ref.onDispose(() {
    controller.dispose();
  });
  return controller;
});
final conPasswordController = Provider<TextEditingController>((ref) {
  final controller = TextEditingController();

  ref.onDispose(() {
    controller.dispose();
  });
  return controller;
});
