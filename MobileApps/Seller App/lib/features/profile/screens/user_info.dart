import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';
import 'package:razin_commerce_seller_flutter/config/app_text_style.dart';
import 'package:razin_commerce_seller_flutter/config/theme.dart';
import 'package:razin_commerce_seller_flutter/features/auth/screens/shop_owner_widget.dart';
import 'package:razin_commerce_seller_flutter/features/common/widgets/custom_button.dart';
import 'package:razin_commerce_seller_flutter/features/common/widgets/custom_text_field.dart';
import 'package:razin_commerce_seller_flutter/features/profile/models/profile_details.dart';
import 'package:razin_commerce_seller_flutter/features/profile/models/user_info_update_model.dart';
import 'package:razin_commerce_seller_flutter/features/profile/providers/profile_provider.dart';
import 'package:razin_commerce_seller_flutter/gen/assets.gen.dart';
import 'package:razin_commerce_seller_flutter/utils/global_function.dart';

class UserInfoScreen extends ConsumerStatefulWidget {
  final UserAccountDetails userInfo;
  const UserInfoScreen({super.key, required this.userInfo});

  @override
  ConsumerState<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends ConsumerState<UserInfoScreen> {
  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _phoneController;
  late final TextEditingController _emailController;
  late final GlobalKey<FormBuilderState> _formKey;
  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormBuilderState>();
    _firstNameController =
        TextEditingController(text: widget.userInfo.firstName);
    _lastNameController = TextEditingController(text: widget.userInfo.lastName);
    _phoneController = TextEditingController(text: widget.userInfo.phone);
    _emailController = TextEditingController(text: widget.userInfo.email);
  }

  @override
  void deactivate() {
    if (mounted) ref.invalidate(selectedProfileImage);
    super.deactivate();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _formKey.currentState?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _buildBottomNavigationBar(),
      appBar: AppBar(
        title: const Text('User Info'),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Column(
      children: [
        Consumer(builder: (context, ref, _) {
          return Flexible(
            flex: 3,
            fit: FlexFit.tight,
            child: ClipPath(
              clipper: CustomShape(),
              child: Container(
                color: colors(GlobalFunction.context).light,
                child: Center(
                  child: CircleAvatar(
                    radius: 60.sp,
                    backgroundColor:
                        colors(GlobalFunction.context).secondaryColor,
                    backgroundImage: ref.watch(selectedProfileImage) != null
                        ? FileImage(File(ref.watch(selectedProfileImage)!.path))
                        : CachedNetworkImageProvider(
                            widget.userInfo.profilePhoto) as ImageProvider,
                    child: Stack(
                      children: [
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: () => GlobalFunction.pickImageFromGallery()
                                .then((file) => ref
                                    .read(selectedProfileImage.notifier)
                                    .state = file),
                            child: CircleAvatar(
                              radius: 18.sp,
                              backgroundColor:
                                  colors(GlobalFunction.context).primaryColor,
                              child: Center(
                                child: SvgPicture.asset(
                                  Assets.svg.camera,
                                  colorFilter: ColorFilter.mode(
                                      colors(context).light!, BlendMode.srcIn),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
        Flexible(
          flex: 6,
          fit: FlexFit.tight,
          child: Container(
            color: colors(GlobalFunction.context).light,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: SingleChildScrollView(
                child: FormBuilder(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomTextFormField(
                        name: 'Full Name',
                        textInputType: TextInputType.text,
                        controller: _firstNameController,
                        textInputAction: TextInputAction.next,
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                            errorText: 'Name is required',
                          ),
                        ]),
                        hintText: 'Enter full name',
                      ),
                      Gap(20.h),
                      CustomTextFormField(
                        name: 'Last Name',
                        textInputType: TextInputType.text,
                        controller: _lastNameController,
                        textInputAction: TextInputAction.next,
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                            errorText: 'Last name is required',
                          ),
                        ]),
                        hintText: 'Enter last name',
                      ),
                      Gap(20.h),
                      CustomTextFormField(
                        name: 'Phone',
                        textInputType: TextInputType.phone,
                        controller: _phoneController,
                        textInputAction: TextInputAction.next,
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                            errorText: 'Phone is required',
                          ),
                        ]),
                        hintText: 'Enter phone number',
                      ),
                      Gap(20.h),
                      CustomTextFormField(
                        readOnly: true,
                        name: 'Email',
                        fillColor: colors(context).secondaryColor,
                        textInputType: TextInputType.emailAddress,
                        controller: _emailController,
                        textInputAction: TextInputAction.done,
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                            errorText: 'Email is required',
                          ),
                        ]),
                        hintText: 'Enter email address',
                      ),
                      Gap(20.h),
                      _buildCustomDropDown(
                        name: 'Gender',
                        widget: null,
                        items: const [
                          DropdownMenuItem(
                            value: 'Male',
                            child: Text('Male'),
                          ),
                          DropdownMenuItem(
                            value: 'Female',
                            child: Text('Female'),
                          ),
                        ],
                        hintText: 'Select gender',
                        initialValue: capitalize(widget.userInfo.gender),
                        context: GlobalFunction.context,
                        onChanged: (value) {},
                        validator: FormBuilderValidators.required(
                            errorText: 'Gender is required'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
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

  String capitalize(String text) {
    if (text.isEmpty) {
      return text;
    }
    return '${text[0].toUpperCase()}${text.substring(1)}';
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      height: 86.h,
      color: colors(context).light,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: ref.watch(userInfoUpdateServiceProvider)
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : CustomButton(
              buttonName: 'Update',
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  final UserInfoUpdateMode model = UserInfoUpdateMode(
                      firstName: _firstNameController.text,
                      lastName: _lastNameController.text,
                      phone: _phoneController.text,
                      email: _emailController.text,
                      gender: _formKey.currentState?.fields['Gender']?.value,
                      dateOfBirth: widget.userInfo.dateOfBirth ?? '');
                  ref
                      .read(userInfoUpdateServiceProvider.notifier)
                      .updateUserInfo(
                          model: model, image: ref.read(selectedProfileImage))
                      .then(
                        (response) => [
                          if (response.status)
                            ref.refresh(profileDetailsServiceProvider),
                          GlobalFunction.showCustomSnackbar(
                            message: response.message,
                            isSuccess: response.status,
                          )
                        ],
                      );
                }
              },
            ),
    );
  }
}

class CustomShape extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double height = size.height;
    double width = size.width;
    var path = Path();
    path.lineTo(0, height - 25);
    path.quadraticBezierTo(width / 2, height, width, height - 25);
    path.lineTo(width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
