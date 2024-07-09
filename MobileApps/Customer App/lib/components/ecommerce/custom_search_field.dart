// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:razin_shop/config/app_color.dart';
import 'package:razin_shop/config/app_text_style.dart';
import 'package:razin_shop/config/theme.dart';

class CustomSearchField extends StatelessWidget {
  final String name;
  final FocusNode? focusNode;
  final String hintText;
  final TextInputType textInputType;
  final TextEditingController controller;
  final Widget? widget;
  final void Function(String?)? onChanged;
  const CustomSearchField({
    Key? key,
    required this.name,
    this.focusNode,
    required this.hintText,
    required this.textInputType,
    required this.controller,
    required this.widget,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      textAlign: TextAlign.start,
      name: name,
      focusNode: focusNode,
      controller: controller,
      style: AppTextStyle(context).bodyText.copyWith(
            fontWeight: FontWeight.w600,
          ),
      cursorColor: colors(context).primaryColor,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: AppTextStyle(context).bodyText.copyWith(
              fontWeight: FontWeight.w500,
              color: colors(context).hintTextColor,
            ),
        contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12),
        alignLabelWithHint: true,
        prefixIcon: widget,
        floatingLabelStyle: AppTextStyle(context).bodyText.copyWith(
              fontWeight: FontWeight.w400,
              color: colors(context).primaryColor,
            ),
        filled: true,
        fillColor: colors(context).accentColor,
        errorStyle: AppTextStyle(context).bodyTextSmall.copyWith(
              fontWeight: FontWeight.w400,
              color: colors(context).errorColor,
            ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50.r),
          borderSide: BorderSide(
            color: colors(context).accentColor ?? EcommerceAppColor.offWhite,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50.r),
          borderSide: BorderSide(
            color: colors(context).accentColor ?? EcommerceAppColor.offWhite,
            width: 2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: BorderSide(
            color: colors(context).accentColor ?? EcommerceAppColor.offWhite,
            width: 1.5,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: const BorderSide(color: Colors.red),
        ),
      ),
      onChanged: onChanged,
      keyboardType: textInputType,
    );
  }
}
