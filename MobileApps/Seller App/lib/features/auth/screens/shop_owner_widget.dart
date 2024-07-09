import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:razin_commerce_seller_flutter/config/app_text_style.dart';
import 'package:razin_commerce_seller_flutter/config/theme.dart';
import 'package:razin_commerce_seller_flutter/features/auth/widgets/image_picker_button.dart';
import 'package:razin_commerce_seller_flutter/features/common/widgets/custom_text_field.dart';
import 'package:razin_commerce_seller_flutter/gen/assets.gen.dart';
import 'package:razin_commerce_seller_flutter/utils/global_function.dart';

class ShopOwnerWidget extends StatelessWidget {
  const ShopOwnerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: FormBuilder(
        key: key,
        child: Column(
          children: [
            Gap(8.h),
            _buildInfoFormWidget(),
            Gap(8.h),
            _buildProfilePickerWidget(),
            Gap(8.h),
            _buildTermsAndConditionsWidget(),
            Gap(8.h),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoFormWidget() {
    return Consumer(builder: (context, ref, _) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        color: colors(GlobalFunction.navigatorKey.currentContext).light,
        child: FormBuilder(
          key: ref.read(shopOwnerFormKey),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    flex: 1,
                    child: CustomTextFormField(
                      name: 'First Name',
                      textInputType: TextInputType.text,
                      controller: ref.watch(firstNameController),
                      textInputAction: TextInputAction.next,
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                          errorText: 'Name is required',
                        )
                      ]),
                      hintText: 'Enter first name',
                    ),
                  ),
                  Gap(16.w),
                  Flexible(
                    flex: 1,
                    child: CustomTextFormField(
                      name: 'Last Name',
                      textInputType: TextInputType.text,
                      controller: ref.watch(lastNameController),
                      textInputAction: TextInputAction.next,
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                          errorText: 'Last name is required',
                        )
                      ]),
                      hintText: 'Enter last name',
                    ),
                  ),
                ],
              ),
              Gap(14.h),
              CustomTextFormField(
                name: 'Phone Number',
                textInputType: TextInputType.text,
                controller: ref.watch(phoneController),
                textInputAction: TextInputAction.next,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                    errorText: 'Phone is required',
                  ),
                  FormBuilderValidators.minLength(2,
                      errorText: 'Invalid phone'),
                  FormBuilderValidators.maxLength(20,
                      errorText: 'Invalid phone'),
                ]),
                hintText: 'Enter phone number',
              ),
              Gap(20.h),
              CustomTextFormField(
                name: 'Email  Address',
                textInputType: TextInputType.text,
                controller: ref.watch(emailController),
                textInputAction: TextInputAction.next,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                    errorText: 'Email is required',
                  ),
                  FormBuilderValidators.email(errorText: 'Invalid email'),
                ]),
                hintText: 'Enter email address ',
              ),
              Gap(20.h),
              Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: _buildCustomDropDown(
                      context: GlobalFunction.navigatorKey.currentContext!,
                      name: 'Gender',
                      hintText: 'Select',
                      widget: null,
                      initialValue: ref.watch(selectedGender),
                      onChanged: (v) =>
                          ref.read(selectedGender.notifier).state = v,
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                          errorText: 'Gender is required',
                        )
                      ]),
                      items: ["Male", "Female", "Others"]
                          .map((e) => DropdownMenuItem(
                                value: e,
                                child: Text(e),
                              ))
                          .toList(),
                    ),
                  ),
                  Gap(16.w),
                  Flexible(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () => GlobalFunction.pickDate(context: context)
                          .then((dateOfBirth) => ref
                              .read(dateOfBirthController)
                              .text = dateOfBirth.toString()),
                      child: CustomTextFormField(
                        readOnly: true,
                        name: 'Date of Birth',
                        textInputType: TextInputType.text,
                        controller: ref.watch(dateOfBirthController),
                        textInputAction: TextInputAction.next,
                        widget: const Icon(Icons.calendar_month),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                            errorText: 'Date is required',
                          )
                        ]),
                        hintText: 'yyyy/mm/dd',
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      );
    });
  }

  Widget _buildProfilePickerWidget() {
    return Consumer(builder: (context, ref, _) {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        color: colors(GlobalFunction.navigatorKey.currentContext).light,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Add a Profile Photo',
                style: AppTextStyle.text16B400,
              ),
            ),
            Gap(16.h),
            ref.watch(selectedProfileImage) != null
                ? CircleAvatar(
                    radius: 46.r,
                    backgroundImage: FileImage(
                      File(
                          ref.watch(selectedProfileImage.notifier).state!.path),
                    ),
                  )
                : SvgPicture.asset(Assets.svg.avatar),
            Gap(20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  flex: 1,
                  child: ImagePickerButton(
                    isActive: ref.watch(isGalleryChosen) ?? false,
                    title: 'Take Photo',
                    icon: Assets.svg.camera,
                    callback: () => GlobalFunction.pickImageFromCamera().then(
                      (xFile) => [
                        ref.read(selectedProfileImage.notifier).state = xFile,
                        ref.read(isGalleryChosen.notifier).state = true,
                      ],
                    ),
                  ),
                ),
                Gap(16.w),
                Flexible(
                  flex: 1,
                  child: ImagePickerButton(
                    isActive: (ref.watch(isGalleryChosen) != null &&
                        ref.watch(isGalleryChosen.notifier).state == false),
                    title: 'Upload Photo',
                    icon: Assets.svg.gallery,
                    callback: () => GlobalFunction.pickImageFromGallery().then(
                      (xFile) => [
                        ref.read(selectedProfileImage.notifier).state = xFile,
                        ref.read(isGalleryChosen.notifier).state = false,
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      );
    });
  }

  Widget _buildTermsAndConditionsWidget() {
    return Consumer(builder: (context, ref, _) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        color: colors(GlobalFunction.navigatorKey.currentContext).light,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Checkbox(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.r)),
              visualDensity: VisualDensity.compact,
              value: ref.watch(isAcceptTermsAndConditions),
              onChanged: (value) {
                ref.read(isAcceptTermsAndConditions.notifier).state = value!;
              },
            ),
            Gap(5.w),
            Expanded(
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "I accept and agree to the ",
                      style: AppTextStyle.text14B400,
                    ),
                    TextSpan(
                      text: 'Terms & Condition',
                      style: AppTextStyle.text14B400.copyWith(
                        color:
                            colors(GlobalFunction.navigatorKey.currentContext)
                                .primaryColor,
                      ),
                      recognizer: TapGestureRecognizer()..onTap = () {},
                    ),
                    TextSpan(
                      text: ' and ',
                      style: AppTextStyle.text14B400,
                    ),
                    TextSpan(
                      text: 'Privacy Policy ',
                      style: AppTextStyle.text14B400.copyWith(
                        color:
                            colors(GlobalFunction.navigatorKey.currentContext)
                                .primaryColor,
                      ),
                      recognizer: TapGestureRecognizer()..onTap = () {},
                    ),
                    TextSpan(
                      text: ' RazinShop ',
                      style: AppTextStyle.text14B400,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      );
    });
  }

  Widget _buildCustomDropDown(
      {required String name,
      required List<DropdownMenuItem<dynamic>> items,
      required String hintText,
      required Widget? widget,
      required dynamic initialValue,
      required BuildContext context,
      required void Function(dynamic)? onChanged,
      required String? Function(dynamic)? validator}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: AppTextStyle.text16B400,
        ),
        Gap(12.h),
        FormBuilderDropdown(
          name: name,
          items: items,
          initialValue: initialValue,
          dropdownColor: colors(context).light,
          onChanged: onChanged,
          icon: const Icon(Icons.keyboard_arrow_down),
          decoration: GlobalFunction.inputDecoration(
            hintText: hintText,
            widget: widget,
            context: context,
          ),
          validator: validator,
        ),
      ],
    );
  }
}

final firstNameController = Provider<TextEditingController>((ref) {
  final controller = TextEditingController();

  ref.onDispose(() {
    controller.dispose();
  });
  return controller;
});
final lastNameController = Provider<TextEditingController>((ref) {
  final controller = TextEditingController();

  ref.onDispose(() {
    controller.dispose();
  });
  return controller;
});
final phoneController = Provider<TextEditingController>((ref) {
  final controller = TextEditingController();

  ref.onDispose(() {
    controller.dispose();
  });
  return controller;
});
final emailController = Provider<TextEditingController>((ref) {
  final controller = TextEditingController();

  ref.onDispose(() {
    controller.dispose();
  });
  return controller;
});
final dateOfBirthController = Provider<TextEditingController>((ref) {
  final controller = TextEditingController();

  ref.onDispose(() {
    controller.dispose();
  });
  return controller;
});

final selectedProfileImage = StateProvider<XFile?>((ref) => null);
final selectedGender = StateProvider<String?>((ref) => null);
final isGalleryChosen = StateProvider<bool?>((ref) => null);
final isAcceptTermsAndConditions = StateProvider<bool>((ref) => false);
final shopOwnerFormKey = Provider<GlobalKey<FormBuilderState>>(
    (ref) => GlobalKey<FormBuilderState>());
