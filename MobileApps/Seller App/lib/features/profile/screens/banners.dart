import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:razin_commerce_seller_flutter/config/app_text_style.dart';
import 'package:razin_commerce_seller_flutter/config/theme.dart';
import 'package:razin_commerce_seller_flutter/features/common/widgets/app_logo.dart';
import 'package:razin_commerce_seller_flutter/features/common/widgets/custom_button.dart';
import 'package:razin_commerce_seller_flutter/features/profile/models/profile_details.dart'
    as pd;
import 'package:razin_commerce_seller_flutter/features/profile/providers/profile_provider.dart';
import 'package:razin_commerce_seller_flutter/gen/assets.gen.dart';
import 'package:razin_commerce_seller_flutter/utils/global_function.dart';

class BannersScreen extends ConsumerStatefulWidget {
  final pd.UserAccountDetails profileDetails;
  const BannersScreen({super.key, required this.profileDetails});

  @override
  ConsumerState<BannersScreen> createState() => _BannersScreenState();
}

class _BannersScreenState extends ConsumerState<BannersScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(shopBannerServiceProvider.notifier).getShopBanners();
    });
  }

  @override
  void deactivate() {
    if (mounted) {
      [
        ref.invalidate(pickedBannerImageProvider),
        ref.invalidate(showAddBanner),
        ref.refresh(profileDetailsServiceProvider)
      ];
    }
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: const Text('Shop Banners'),
          ),
          bottomNavigationBar: _buildBottomNavigationBar(),
          body: _buildBody(),
        ),
        Visibility(
          visible: ref.watch(shopBannerServiceProvider),
          child: const Opacity(
            opacity: 0.6,
            child: ModalBarrier(
              dismissible: false,
              color: Colors.black,
            ),
          ),
        ),
        Visibility(
          visible: ref.watch(shopBannerServiceProvider),
          child: Center(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 16.w),
              decoration: BoxDecoration(
                color: colors(context).light,
                borderRadius: BorderRadius.circular(16.r),
              ),
              height: 140.h,
              width: double.infinity,
              child: const Center(
                child: AppLogo(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBody() {
    return Container(
      color: colors(GlobalFunction.context).light,
      margin: EdgeInsets.only(top: 16.h),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 20.h),
              itemCount:
                  ref.watch(shopBannerServiceProvider.notifier).banners.length,
              itemBuilder: (context, index) {
                final banner = ref
                    .watch(shopBannerServiceProvider.notifier)
                    .banners[index];
                return Padding(
                  padding: EdgeInsets.only(bottom: 16.h),
                  child: _buildBannerCardWidget(index: index, banner: banner),
                );
              },
            ),
            Visibility(
              visible: ref.watch(showAddBanner),
              child: Column(
                children: [
                  Gap(20.h),
                  _buildUploadBannerCardWidget(),
                ],
              ),
            ),
            Gap(10.h),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: EdgeInsets.only(right: 16.w),
                child: _buildNewBannerButton(),
              ),
            ),
            Gap(16.h),
          ],
        ),
      ),
    );
  }

  Widget _buildBannerCardWidget(
      {required int index, required pd.Banner banner}) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Banner ${index + 1}',
                style: AppTextStyle.text16B400,
              ),
              GestureDetector(
                  onTap: () {
                    ref
                        .read(shopBannerServiceProvider.notifier)
                        .deleteBanner(id: banner.id);
                  },
                  child: SvgPicture.asset(Assets.svg.trash))
            ],
          ),
          Gap(10.h),
          Container(
            padding: EdgeInsets.all(15.dm),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.dm),
              border: Border.all(
                  color: colors(GlobalFunction.context).secondaryColor!),
            ),
            child: DottedBorder(
              borderType: BorderType.RRect,
              radius: Radius.circular(8.dm),
              padding: EdgeInsets.zero,
              color: colors(GlobalFunction.context).primaryColor!,
              strokeWidth: 2,
              dashPattern: const [5, 4],
              child: Container(
                height: 100.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.dm),
                  border: Border.all(
                      color: colors(GlobalFunction.context).secondaryColor!),
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(banner.thumbnail),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          color: colors(GlobalFunction.context)
                              .primaryColor!
                              .withOpacity(0.5),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(8.dm),
                            bottomRight: Radius.circular(8.dm),
                          ),
                        ),
                        height: 36.h,
                        child: GestureDetector(
                          onTap: () =>
                              GlobalFunction.pickImageFromGallery().then(
                            (file) => file != null
                                ? ref
                                    .read(shopBannerServiceProvider.notifier)
                                    .updateBanner(
                                      image: file,
                                      id: banner.id,
                                    )
                                : debugPrint('File is null'),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.file_upload_outlined,
                                color: colors(GlobalFunction.context).light,
                              ),
                              Gap(5.w),
                              Text(
                                'Tap to change banner image',
                                style: AppTextStyle.text12B700.copyWith(
                                    fontWeight: FontWeight.w400,
                                    color:
                                        colors(GlobalFunction.context).light),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildUploadBannerCardWidget() {
    return Consumer(builder: (context, ref, _) {
      return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Banner ${ref.watch(shopBannerServiceProvider.notifier).banners.length + 1}',
                  style: AppTextStyle.text16B400,
                ),
                SvgPicture.asset(Assets.svg.trash)
              ],
            ),
            Gap(10.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(15.dm),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.dm),
                border: Border.all(
                    color: colors(GlobalFunction.context).secondaryColor!),
              ),
              child: DottedBorder(
                borderType: BorderType.RRect,
                radius: Radius.circular(8.dm),
                padding: EdgeInsets.zero,
                color: colors(GlobalFunction.context).primaryColor!,
                strokeWidth: 2,
                dashPattern: const [5, 4],
                child: Container(
                  height: 100.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.dm),
                    border: Border.all(
                        color: colors(GlobalFunction.context).secondaryColor!),
                    image: ref.watch(pickedBannerImageProvider) != null
                        ? DecorationImage(
                            image: FileImage(
                              File(ref.watch(pickedBannerImageProvider)!.path),
                            ),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                          top: 10.h,
                          left: 0,
                          right: 0,
                          child: SvgPicture.asset(Assets.svg.galleryBanner)),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: colors(GlobalFunction.context)
                                .primaryColor!
                                .withOpacity(0.2),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(8.dm),
                              bottomRight: Radius.circular(8.dm),
                            ),
                          ),
                          height: 36.h,
                          child: GestureDetector(
                            onTap: () => GlobalFunction.pickImageFromGallery()
                                .then((file) => ref
                                    .read(pickedBannerImageProvider.notifier)
                                    .state = file),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.file_upload_outlined,
                                  color: colors(GlobalFunction.context)
                                      .primaryColor,
                                ),
                                Gap(5.w),
                                Text(
                                  'Tap to change banner image',
                                  style: AppTextStyle.text12B700.copyWith(
                                      fontWeight: FontWeight.w400,
                                      color: colors(GlobalFunction.context)
                                          .primaryColor),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      );
    });
  }

  Widget _buildNewBannerButton() {
    return Material(
      color: colors(GlobalFunction.context).light,
      child: InkWell(
        borderRadius: BorderRadius.circular(8.sp),
        onTap: () {
          ref.read(showAddBanner.notifier).state = true;
        },
        child: Container(
          width: 120.w,
          padding: EdgeInsets.all(4.dm),
          decoration: BoxDecoration(
            border:
                Border.all(color: colors(GlobalFunction.context).primaryColor!),
            borderRadius: BorderRadius.circular(8.sp),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.add,
                color: colors(GlobalFunction.context).primaryColor,
              ),
              Gap(5.w),
              Text(
                'New Banner',
                style: AppTextStyle.text12B700
                    .copyWith(fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      color: colors(GlobalFunction.context).light,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: CustomButton(
        buttonName: 'Update',
        onTap: () {
          if (ref.read(pickedBannerImageProvider) != null) {
            ref
                .read(shopBannerServiceProvider.notifier)
                .addNewBanner(image: ref.read(pickedBannerImageProvider))
                .then((response) => [
                      if (response.status)
                        {
                          ref.read(showAddBanner.notifier).state = false,
                          ref.refresh(pickedBannerImageProvider)
                        }
                    ]);
          }
        },
      ),
    );
  }
}

final pickedBannerImageProvider = StateProvider<XFile?>((ref) => null);
final showAddBanner = StateProvider<bool>((ref) => false);
