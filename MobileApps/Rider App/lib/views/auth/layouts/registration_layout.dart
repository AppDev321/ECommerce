// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:razinshop_rider/components/custom_appBar.dart';
import 'package:razinshop_rider/components/my_custom_button.dart';
import 'package:razinshop_rider/config/app_color.dart';
import 'package:razinshop_rider/config/app_constants.dart';
import 'package:razinshop_rider/config/app_text.dart';
import 'package:razinshop_rider/config/theme.dart';
import 'package:razinshop_rider/controllers/auth_controller/auth_controller.dart';
import 'package:razinshop_rider/gen/assets.gen.dart';
import 'package:razinshop_rider/generated/l10n.dart';
import 'package:razinshop_rider/routers.dart';
import 'package:razinshop_rider/utils/context_less_navigate.dart';
import 'package:razinshop_rider/utils/global_function.dart';
import 'package:razinshop_rider/views/auth/layouts/confirm_otp_layout.dart';

class RegistrationLayout extends ConsumerStatefulWidget {
  const RegistrationLayout({super.key, this.isProfileUpdate = false});
  final bool isProfileUpdate;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RegistrationLayoutState();
}

class _RegistrationLayoutState extends ConsumerState<RegistrationLayout> {
  final _formKey = GlobalKey<FormBuilderState>();
  File? image;
  void pickImage({required ImageSource source}) async {
    final pickedFile = await ImagePicker().pickImage(
      source: source,
      imageQuality: 50,
    );
    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
      });
    }
  }

  void pickDate() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    ).then((value) {
      if (value != null) {
        final date = "${value.year}-${value.month}-${value.day}";
        _formKey.currentState!.patchValue({"date_of_birth": date});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
          valueListenable: Hive.box(AppConstants.authBox).listenable(),
          builder: (context, Box box, _) {
            return Column(
              children: [
                CustomAppBar(
                  title: widget.isProfileUpdate
                      ? S.of(context).myProfile
                      : S.of(context).registration,
                ),
                Gap(10.r),
                Expanded(
                  child: SingleChildScrollView(
                    child: FormBuilder(
                      key: _formKey,
                      initialValue: widget.isProfileUpdate
                          ? box.get(AppConstants.userData)['user']
                          : {},
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.r, vertical: 8.r),
                            color: AppColor.whiteColor,
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          headerText(
                                              title: S.of(context).firstName),
                                          Gap(10.r),
                                          FormBuilderTextField(
                                            name: 'first_name',
                                            decoration: AppTheme.inputDecoration
                                                .copyWith(
                                              hintText:
                                                  S.of(context).enterFirstName,
                                            ),
                                            validator:
                                                FormBuilderValidators.compose(
                                              [
                                                FormBuilderValidators.required()
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Gap(15.r),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          headerText(
                                              title: S.of(context).lastName),
                                          Gap(10.r),
                                          FormBuilderTextField(
                                            name: 'last_name',
                                            decoration: AppTheme.inputDecoration
                                                .copyWith(
                                              hintText:
                                                  S.of(context).enterLastName,
                                            ),
                                            validator:
                                                FormBuilderValidators.compose(
                                              [
                                                FormBuilderValidators.required()
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Gap(20.r),
                                // phone number
                                headerText(title: S.of(context).phoneNumber),
                                Gap(10.r),
                                FormBuilderTextField(
                                  name: 'phone',
                                  keyboardType: TextInputType.phone,
                                  decoration: AppTheme.inputDecoration.copyWith(
                                    hintText: S.of(context).enterPhoneNumber,
                                  ),
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(),
                                    FormBuilderValidators.minLength(2),
                                    FormBuilderValidators.maxLength(20)
                                  ]),
                                ),
                                Gap(20.r),
                                // email optional
                                headerText(title: S.of(context).emailAddress),
                                Gap(10.r),
                                FormBuilderTextField(
                                  name: 'email',
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: AppTheme.inputDecoration.copyWith(
                                    hintText: S.of(context).enterEmailAddress,
                                  ),
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.email(),
                                    FormBuilderValidators.required(),
                                  ]),
                                ),
                                Gap(20.r),
                                Row(
                                  children: [
                                    Expanded(
                                        child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // gender dropdown
                                        headerText(title: S.of(context).gender),
                                        Gap(10.r),
                                        FormBuilderDropdown(
                                          name: "gender",
                                          decoration:
                                              AppTheme.inputDecoration.copyWith(
                                            hintText: S.of(context).select,
                                          ),
                                          icon: SvgPicture.asset(
                                              Assets.svgs.downArrow),
                                          items: ["Male", "Female", "Others"]
                                              .map((e) => DropdownMenuItem(
                                                    value: e,
                                                    child: Text(e),
                                                  ))
                                              .toList(),
                                          validator:
                                              FormBuilderValidators.compose([
                                            FormBuilderValidators.required(),
                                          ]),
                                        )
                                      ],
                                    )),
                                    Gap(15),
                                    Expanded(
                                        child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // gender dropdown
                                        headerText(title: S.of(context).dob),
                                        Gap(10.r),
                                        FormBuilderTextField(
                                          name: "date_of_birth",
                                          readOnly: true,
                                          decoration:
                                              AppTheme.inputDecoration.copyWith(
                                            hintText: "dd/mm/yyyy",
                                            suffixIcon: Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: SvgPicture.asset(
                                                Assets.svgs.calendar,
                                              ),
                                            ),
                                          ),
                                          validator:
                                              FormBuilderValidators.compose([
                                            FormBuilderValidators.required(),
                                          ]),
                                          onTap: () {
                                            pickDate();
                                          },
                                        )
                                      ],
                                    ))
                                  ],
                                ),
                                Gap(20.r),
                                // driving license
                                headerText(title: S.of(context).drivingLicense),
                                Gap(10.r),
                                FormBuilderTextField(
                                  name: 'driving_lience',
                                  decoration: AppTheme.inputDecoration.copyWith(
                                    hintText: S.of(context).enterDrivingLicense,
                                  ),
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(),
                                  ]),
                                ),
                                Gap(20.r),
                                // vehicle type give in dropdown
                                headerText(title: S.of(context).vehicleType),
                                Gap(10.r),
                                FormBuilderDropdown(
                                  name: "vehicle_type",
                                  decoration: AppTheme.inputDecoration.copyWith(
                                    hintText: S.of(context).selectVehicleType,
                                  ),
                                  icon: SvgPicture.asset(Assets.svgs.downArrow),
                                  items: ["Bike1", "Car", "Truck"]
                                      .map((e) => DropdownMenuItem(
                                            value: e,
                                            child: Text(e),
                                          ))
                                      .toList(),
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(),
                                  ]),
                                ),
                              ],
                            ),
                          ),
                          Gap(10.r),
                          Stack(
                            alignment: Alignment.bottomCenter,
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16.r, vertical: 8.r),
                                decoration:
                                    BoxDecoration(color: AppColor.whiteColor),
                                width: double.infinity,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    headerText(
                                        title: S.of(context).addProfilePicture),
                                    Gap(16.r),
                                    Center(
                                      child: Container(
                                        height: 100.r,
                                        width: 100.r,
                                        clipBehavior: Clip.antiAlias,
                                        decoration: BoxDecoration(
                                          color: AppColor.greyBackgroundColor,
                                          shape: BoxShape.circle,
                                        ),
                                        child: image != null
                                            ? Image.file(image!)
                                            : widget.isProfileUpdate
                                                ? CachedNetworkImage(
                                                    imageUrl: box.get(
                                                                AppConstants
                                                                    .userData)[
                                                            'user']
                                                        ['profile_photo'],
                                                  )
                                                : Center(
                                                    child: Assets.pngs.avatar
                                                        .image(
                                                            height: 50.r,
                                                            width: 50.r),
                                                  ),
                                      ),
                                    ),
                                    Gap(16.r),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: TextButton(
                                            onPressed: () {
                                              pickImage(
                                                  source: ImageSource.camera);
                                            },
                                            style: TextButton.styleFrom(
                                              backgroundColor:
                                                  AppColor.whiteColor,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.r),
                                                side: BorderSide(
                                                  color: AppColor.greyColor,
                                                ),
                                              ),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(Icons.camera_alt),
                                                Gap(10.r),
                                                Text(S.of(context).camera),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Gap(30.r),
                                        Expanded(
                                          child: TextButton(
                                            onPressed: () {
                                              pickImage(
                                                  source: ImageSource.gallery);
                                            },
                                            style: TextButton.styleFrom(
                                              backgroundColor:
                                                  AppColor.whiteColor,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.r),
                                                side: BorderSide(
                                                  color: AppColor.greyColor,
                                                ),
                                              ),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(Icons.photo),
                                                Gap(10.r),
                                                Text(S.of(context).gallery),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Gap(20.r),
                                  ],
                                ),
                              ),
                              Positioned(
                                bottom: -16.r,
                                left: 20.r,
                                child: CustomPaint(
                                  size: Size(360, 17),
                                  painter: RPSCustomPainter(),
                                ),
                              )
                            ],
                          ),
                          Gap(20)
                        ],
                      ),
                    ),
                  ),
                ),
                Gap(10.r),
              ],
            );
          }),
      bottomNavigationBar: Consumer(
        builder: (context, ref, child) {
          final sendOTP = ref.watch(sendOTPProvider);
          return Container(
            height: 85.r,
            color: AppColor.whiteColor,
            padding: EdgeInsets.all(16.r),
            child: sendOTP
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : MyCustomButton(
                    btnText: S.of(context).register,
                    onTap: () async {
                      if (_formKey.currentState!.saveAndValidate() &&
                          image != null) {
                        final data = {
                          ..._formKey.currentState!.value,
                          "profile_photo":
                              await MultipartFile.fromFile(image!.path)
                        };
                        ref
                            .read(sendOTPProvider.notifier)
                            .sendOTP(phone: data["phone"],isForgetPass: false)
                            .then((value) async {
                          if (value != null) {
                            context.nav.pushNamed(
                              Routes.confirmOTP,
                              arguments: ConfirmOTPScreenArguments(
                                phoneNumber: data["phone"],
                                isPasswordRecover: false,
                                userData: data,
                                otp: value,
                              ),
                            );
                          }
                        });
                      } else {
                        if (image == null) {
                          GlobalFunction.showCustomSnackbar(
                              message: "Image is Required", isSuccess: false);
                        } else {
                          GlobalFunction.showCustomSnackbar(
                              message: "Please fill all the fields",
                              isSuccess: false);
                        }
                      }
                    },
                  ),
          );
        },
      ),
    );
  }

  Text headerText({required String title}) {
    return Text(
      title,
      style: AppTextStyle.normalBody,
    );
  }
}

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(0, 0);
    path_0.lineTo(360, 0);
    path_0.lineTo(360, 1);
    path_0.cubicTo(360, 1, 306, 17, 180, 17);
    path_0.cubicTo(54, 17, 0, 1, 0, 1);
    path_0.lineTo(0, 0);
    path_0.close();

    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.color = Colors.white.withOpacity(1.0);
    canvas.drawPath(path_0, paint_0_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
