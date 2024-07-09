import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:razin_commerce_seller_flutter/config/app_text_style.dart';
import 'package:razin_commerce_seller_flutter/config/theme.dart';
import 'package:razin_commerce_seller_flutter/features/auth/widgets/image_picker_button.dart';
import 'package:razin_commerce_seller_flutter/features/common/widgets/custom_text_field.dart';
import 'package:razin_commerce_seller_flutter/gen/assets.gen.dart';
import 'package:razin_commerce_seller_flutter/utils/global_function.dart';

class ShopDetailsWidget extends ConsumerWidget {
  const ShopDetailsWidget({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(8.h),
            _buildInfoFormWidget(),
            Gap(8.h),
            _buildShopImagesWidget(),
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
          key: ref.read(shopDetailsFormKey),
          child: Column(
            children: [
              CustomTextFormField(
                name: 'Shop Name',
                hintText: 'Enter shop name',
                textInputType: TextInputType.text,
                controller: ref.read(shopNameController),
                textInputAction: TextInputAction.next,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                    errorText: 'Shop is required',
                  ),
                ]),
              ),
              Gap(20.h),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildShopImagesWidget() {
    return Consumer(builder: (context, ref, _) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        color: colors(GlobalFunction.navigatorKey.currentContext).light,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Shop Logo',
              style: AppTextStyle.text16B700,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 20.h),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: 50.r,
                    backgroundImage: ref.watch(selectedShopLogo) != null
                        ? FileImage(
                            File(ref
                                .watch(selectedShopLogo.notifier)
                                .state!
                                .path),
                          )
                        : AssetImage(Assets.png.shopLogoImage.keyName)
                            as ImageProvider,
                  ),
                  Gap(16.w),
                  Flexible(
                    flex: 2,
                    child: SizedBox(
                      child: ImagePickerButton(
                        icon: Assets.svg.gallery,
                        title: 'Upload Logo',
                        isActive: false,
                        callback: () => GlobalFunction.pickImageFromGallery()
                            .then((logo) => ref
                                .read(selectedShopLogo.notifier)
                                .state = logo),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Divider(
              thickness: 2,
              color: colors(GlobalFunction.navigatorKey.currentContext)
                  .secondaryColor!,
            ),
            Gap(16.h),
            Text(
              'Banner Image',
              style: AppTextStyle.text16B700,
            ),
            Gap(16.h),
            Container(
              height: 110.h,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
                image: DecorationImage(
                  image: ref.watch(selectedShopBanner) != null
                      ? FileImage(
                          File(ref
                              .watch(selectedShopBanner.notifier)
                              .state!
                              .path),
                        )
                      : AssetImage(Assets.png.defaultImage.keyName)
                          as ImageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Gap(14.h),
            ImagePickerButton(
              icon: Assets.svg.gallery,
              title: 'Upload Banner',
              isActive: false,
              callback: () => GlobalFunction.pickImageFromGallery().then(
                  (banner) =>
                      ref.read(selectedShopBanner.notifier).state = banner),
            ),
          ],
        ),
      );
    });
  }
}

final shopNameController = Provider<TextEditingController>((ref) {
  final controller = TextEditingController();

  ref.onDispose(() {
    controller.dispose();
  });
  return controller;
});
final agreementCommissionController = Provider<TextEditingController>((ref) {
  final controller = TextEditingController();

  ref.onDispose(() {
    controller.dispose();
  });
  return controller;
});
final selectedShopLogo = StateProvider<XFile?>((ref) => null);
final selectedShopBanner = StateProvider<XFile?>((ref) => null);
final shopDetailsFormKey = Provider<GlobalKey<FormBuilderState>>(
    (ref) => GlobalKey<FormBuilderState>());
