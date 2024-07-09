import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:razin_shop/components/ecommerce/custom_button.dart';
import 'package:razin_shop/components/ecommerce/custom_text_field.dart';
import 'package:razin_shop/config/app_color.dart';
import 'package:razin_shop/config/app_constants.dart';
import 'package:razin_shop/config/theme.dart';
import 'package:razin_shop/controllers/eCommerce/authentication/authentication_controller.dart';
import 'package:razin_shop/controllers/misc/misc_controller.dart';
import 'package:razin_shop/generated/l10n.dart';
import 'package:razin_shop/models/eCommerce/authentication/user.dart';
import 'package:razin_shop/services/common/hive_service_provider.dart';
import 'package:razin_shop/utils/global_function.dart';

class ProfileLayout extends ConsumerStatefulWidget {
  const ProfileLayout({super.key});

  @override
  ConsumerState<ProfileLayout> createState() => _ProfileLayoutState();
}

class _ProfileLayoutState extends ConsumerState<ProfileLayout> {
  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController emailController;
  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();
  @override
  void initState() {
    initializeControllers();
    if (ref.read(selectedUserProfileImage) != null) {
      ref.refresh(selectedUserProfileImage.notifier).state;
    }
    ref.read(hiveServiceProvider).getUserInfo().then((userInfo) {
      if (userInfo != null) {
        nameController.text = userInfo.name!;
        phoneController.text = userInfo.phone!;
        emailController.text = userInfo.email ?? '';
      }
    });
    super.initState();
  }

  void initializeControllers() {
    nameController = TextEditingController();
    phoneController = TextEditingController();
    emailController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalFunction.getBackgroundColor(context: context),
      appBar: AppBar(
        title: Text(S.of(context).myProfile),
        surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          border: const Border(
            top: BorderSide(color: EcommerceAppColor.offWhite),
          ),
        ),
        height: 90.h,
        child: ref.watch(authControllerProvider)
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : CustomButton(
                buttonText: S.of(context).updateProfile,
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    final User userInfo = User.fromMap({}).copyWith(
                      name: nameController.text,
                      phone: phoneController.text,
                      email: emailController.text,
                    );
                    ref
                        .read(authControllerProvider.notifier)
                        .updateProfile(
                          userInfo: userInfo,
                          file: ref.read(selectedUserProfileImage) != null
                              ? File(ref.read(selectedUserProfileImage)!.path)
                              : null,
                        )
                        .then((response) {
                      if (response.isSuccess) {
                        GlobalFunction.showCustomSnackbar(
                          message: response.message,
                          isSuccess: response.isSuccess,
                        );
                      }
                    });
                  }
                },
              ),
      ),
      body: FormBuilder(
        key: formKey,
        child: Column(
          children: [
            Flexible(
              flex: 1,
              child: ClipPath(
                clipper: CustomShape(),
                child: Container(
                  color: Colors.white,
                  child: Center(
                    child: Stack(
                      children: [
                        ValueListenableBuilder(
                          valueListenable:
                              Hive.box(AppConstants.userBox).listenable(),
                          builder: (context, box, _) {
                            Map<dynamic, dynamic>? userInfo =
                                box.get(AppConstants.userData);
                            Map<String, dynamic> userInfoStringKeys =
                                userInfo!.cast<String, dynamic>();
                            User user = User.fromMap(userInfoStringKeys);
                            return Container(
                              height: 100.h,
                              width: 100.w,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: ref.watch(selectedUserProfileImage) !=
                                          null
                                      ? FileImage(
                                          File(ref
                                              .watch(selectedUserProfileImage
                                                  .notifier)
                                              .state!
                                              .path),
                                        ) as ImageProvider
                                      : CachedNetworkImageProvider(
                                          user.profilePhoto!),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                        ),
                        Positioned(
                          bottom: 5,
                          right: 0,
                          child: GestureDetector(
                            onTap: () {
                              GlobalFunction.pickImageFromGallery(ref: ref);
                            },
                            child: CircleAvatar(
                              radius: 16.r,
                              backgroundColor: colors(context).primaryColor,
                              child: const Center(
                                child: Icon(
                                  Icons.photo_camera,
                                  color: EcommerceAppColor.white,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Gap(2.h),
            Flexible(
              flex: 3,
              fit: FlexFit.tight,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                color: Colors.white,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      CustomTextFormField(
                        name: S.of(context).name,
                        hintText: 'Name',
                        textInputType: TextInputType.text,
                        controller: nameController,
                        textInputAction: TextInputAction.next,
                        validator: (value) => GlobalFunction.commonValidator(
                            value: value!, hintText: 'Name', context: context),
                      ),
                      Gap(20.h),
                      CustomTextFormField(
                        name: S.of(context).phone,
                        hintText: 'Phone',
                        textInputType: TextInputType.text,
                        controller: phoneController,
                        textInputAction: TextInputAction.next,
                        validator: (value) => GlobalFunction.commonValidator(
                            value: value!, hintText: 'Phone', context: context),
                      ),
                      Gap(20.h),
                      CustomTextFormField(
                          name: S.of(context).email,
                          hintText: 'Email',
                          textInputType: TextInputType.text,
                          controller: emailController,
                          textInputAction: TextInputAction.next,
                          validator: (value) => null),
                      Gap(20.h),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  final String profieImge =
      'https://media.istockphoto.com/id/1336647287/photo/portrait-of-handsome-indian-businessman-with-mustache-wearing-hat-against-plain-wall.jpg?s=612x612&w=0&k=20&c=XOuLIyFb2DBO8voUXecWkYNxwRrIMYcTRU4QlK9ILks=';
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
