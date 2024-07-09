import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:razin_commerce_seller_flutter/config/app_color.dart';
import 'package:razin_commerce_seller_flutter/config/app_text_style.dart';
import 'package:razin_commerce_seller_flutter/config/theme.dart';
import 'package:razin_commerce_seller_flutter/features/auth/screens/shop_details_widget.dart';
import 'package:razin_commerce_seller_flutter/features/common/widgets/custom_button.dart';
import 'package:razin_commerce_seller_flutter/features/common/widgets/custom_text_field.dart';
import 'package:razin_commerce_seller_flutter/features/profile/models/profile_details.dart';
import 'package:razin_commerce_seller_flutter/features/profile/models/shop_info_update_model.dart';
import 'package:razin_commerce_seller_flutter/features/profile/providers/profile_provider.dart';
import 'package:razin_commerce_seller_flutter/gen/assets.gen.dart';
import 'package:razin_commerce_seller_flutter/utils/global_function.dart';

class ShopInfoScreen extends ConsumerStatefulWidget {
  final UserAccountDetails profileDetails;
  const ShopInfoScreen({super.key, required this.profileDetails});

  @override
  ConsumerState<ShopInfoScreen> createState() => _ShopInfoScreenState();
}

class _ShopInfoScreenState extends ConsumerState<ShopInfoScreen> {
  late final TextEditingController _shopNameController;
  late final TextEditingController _shopAddressController;
  late final TextEditingController _shopDescriptionController;
  HtmlEditorController controller = HtmlEditorController();
  final HtmlEditorController _htmlEditorController = HtmlEditorController();

  late final GlobalKey<FormBuilderState> _formKey;
  @override
  void initState() {
    super.initState();
    print(widget.profileDetails.shop.description);
    _shopNameController =
        TextEditingController(text: widget.profileDetails.shop.name);
    _shopAddressController =
        TextEditingController(text: widget.profileDetails.shop.address);
    _shopDescriptionController =
        TextEditingController(text: widget.profileDetails.shop.description);

    _formKey = GlobalKey<FormBuilderState>();
  }

  @override
  void deactivate() {
    super.deactivate();
    if (mounted) ref.invalidate(selectedShopLogo);
  }

  @override
  void dispose() {
    super.dispose();
    _shopNameController.dispose();
    _shopAddressController.dispose();
    _shopDescriptionController.dispose();
    _formKey.currentState?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('Shop Info'),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Column(
      children: [
        Flexible(
          flex: 3,
          fit: FlexFit.tight,
          child: Container(
            color: colors(context).light,
            child: Center(
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    height: 124.h,
                    width: 124.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.dm),
                      color: colors(context).dark,
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: ref.watch(selectedShopLogo) != null
                              ? FileImage(
                                  File(ref.watch(selectedShopLogo)!.path),
                                )
                              : CachedNetworkImageProvider(
                                      widget.profileDetails.shop.logo)
                                  as ImageProvider),
                    ),
                  ),
                  Positioned(
                    bottom: -12,
                    right: -8,
                    child: GestureDetector(
                      onTap: () => GlobalFunction.pickImageFromGallery().then(
                          (file) =>
                              ref.read(selectedShopLogo.notifier).state = file),
                      child: CircleAvatar(
                        backgroundColor: colors(context).primaryColor,
                        radius: 18,
                        child: Center(
                          child: SvgPicture.asset(
                            Assets.svg.camera,
                            colorFilter: ColorFilter.mode(
                              colors(context).light!,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -30,
                    right: 8,
                    child: Text(
                      'Shop Logo(1:1)',
                      style: AppTextStyle.text14B400
                          .copyWith(color: AppStaticColor.gray),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Gap(12.h),
        Flexible(
          flex: 7,
          fit: FlexFit.tight,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            color: colors(context).light,
            child: FormBuilder(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CustomTextFormField(
                      name: 'Shop Name',
                      textInputType: TextInputType.text,
                      controller: _shopNameController,
                      textInputAction: TextInputAction.next,
                      validator: FormBuilderValidators.required(
                          errorText: 'Shop name is required'),
                      hintText: 'Enter Shop Name',
                    ),
                    Gap(20.h),
                    CustomTextFormField(
                      name: 'Shop Address',
                      textInputType: TextInputType.text,
                      controller: _shopAddressController,
                      textInputAction: TextInputAction.next,
                      validator: FormBuilderValidators.required(
                          errorText: 'Shop address is required'),
                      hintText: 'Enter Shop Address',
                    ),
                    Gap(20.h),
                    // CustomTextFormField(
                    //   name: 'Description',
                    //   textInputType: TextInputType.text,
                    //   maxLines: 7,
                    //   controller: _shopDescriptionController,
                    //   textInputAction: TextInputAction.done,
                    //   validator: FormBuilderValidators.required(
                    //       errorText: 'Shop description is required'),
                    //   hintText: 'Enter Shop Description',
                    // )
                    HtmlEditor(
                      htmlToolbarOptions: const HtmlToolbarOptions(
                        toolbarType: ToolbarType.nativeGrid,
                      ),
                      htmlEditorOptions: HtmlEditorOptions(
                        // shouldEnsureVisible: true,
                        initialText: widget.profileDetails.shop.description,
                        hint: 'Enter Shop Description',
                      ),
                      controller: _htmlEditorController,
                      otherOptions: const OtherOptions(height: 400),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      height: 86.h,
      color: colors(context).light,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: ref.watch(shopInfoUpdateServiceProvider)
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : CustomButton(
              buttonName: 'Update',
              onTap: () async {
                if (_formKey.currentState!.validate()) {
                  String text = await _htmlEditorController.getText();
                  final ShopInfoUpdateModel model = ShopInfoUpdateModel(
                    shopName: _shopNameController.text,
                    shopAddress: _shopAddressController.text,
                    shopDescription: text,
                  );
                  ref
                      .read(shopInfoUpdateServiceProvider.notifier)
                      .updateShopInfo(
                          model: model, image: ref.watch(selectedShopLogo))
                      .then((response) => [
                            if (response.status)
                              ref.refresh(profileDetailsServiceProvider),
                            GlobalFunction.showCustomSnackbar(
                                message: response.message,
                                isSuccess: response.status)
                          ]);
                }
              },
            ),
    );
  }
}
