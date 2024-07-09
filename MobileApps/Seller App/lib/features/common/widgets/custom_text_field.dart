import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:razin_commerce_seller_flutter/config/app_text_style.dart';
import 'package:razin_commerce_seller_flutter/config/theme.dart';
import 'package:razin_commerce_seller_flutter/utils/global_function.dart';

class CustomTextFormField extends StatelessWidget {
  final String name;
  final FocusNode? focusNode;
  final TextInputType textInputType;
  final TextEditingController controller;
  final TextInputAction textInputAction;
  final String? Function(String?)? validator;
  final bool? readOnly;
  final Widget? widget;
  final bool? obscureText;
  final int? minLines;
  final int? maxLines;
  final bool showName;
  final String hintText;
  final Color? fillColor;
  const CustomTextFormField({
    super.key,
    required this.name,
    this.focusNode,
    required this.textInputType,
    required this.controller,
    required this.textInputAction,
    required this.validator,
    this.readOnly,
    this.widget,
    this.obscureText,
    this.minLines,
    this.maxLines,
    this.fillColor,
    this.showName = true,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showName)
          Text(
            name,
            style: AppTextStyle.text16B400,
          ),
        Gap(12.h),
        AbsorbPointer(
          absorbing: readOnly ?? false,
          child: FormBuilderTextField(
            readOnly: readOnly ?? false,
            textAlign: TextAlign.start,
            minLines: minLines ?? 1,
            maxLines: maxLines ?? 1,
            name: name,
            focusNode: focusNode,
            controller: controller,
            obscureText: obscureText ?? false,
            style: AppTextStyle.text16B400,
            cursorColor: colors(context).primaryColor,
            decoration: GlobalFunction.inputDecoration(
              hintText: hintText,
              widget: widget,
              context: context,
              fillColor: fillColor,
            ),
            keyboardType: textInputType,
            textInputAction: textInputAction,
            validator: validator,
          ),
        ),
      ],
    );
  }
}
