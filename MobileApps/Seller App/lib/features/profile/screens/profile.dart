import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:razin_commerce_seller_flutter/config/app_color.dart';
import 'package:razin_commerce_seller_flutter/config/app_text_style.dart';
import 'package:razin_commerce_seller_flutter/config/routes.dart';
import 'package:razin_commerce_seller_flutter/config/theme.dart';
import 'package:razin_commerce_seller_flutter/features/profile/models/profile_details.dart';
import 'package:razin_commerce_seller_flutter/features/profile/providers/profile_provider.dart';
import 'package:razin_commerce_seller_flutter/features/profile/widgets/online_switch_widget.dart';
import 'package:razin_commerce_seller_flutter/gen/assets.gen.dart';
import 'package:razin_commerce_seller_flutter/utils/global_function.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      backgroundColor: AppStaticColor.white,
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Consumer(
      builder: (context, ref, _) {
        return ref.watch(profileDetailsServiceProvider).when(
              data: (profileDetails) => SingleChildScrollView(
                child: Column(
                  children: [
                    _buildUserInfoCard(profileDetails: profileDetails),
                    _buildShopInfoCard(profileDetails: profileDetails),
                    _buildShopSettingsCard(profileDetails: profileDetails),
                    _shopBannersCardWidget(profileDetails: profileDetails),
                  ],
                ),
              ),
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              error: (error, stackTrace) => Text(error.toString()),
            );
      },
    );
  }

  _buildAppBar() {
    return PreferredSize(
      preferredSize: Size(double.infinity, 190.h),
      child: Consumer(
        builder: (context, ref, _) {
          return ref.watch(profileDetailsServiceProvider).maybeWhen(
                orElse: () => const SizedBox(),
                data: (profileDetails) => Container(
                  width: double.infinity,
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: const Alignment(-0.99, -0.12),
                      end: const Alignment(0.99, 0.12),
                      colors: [
                        const Color(0xFFB822FF),
                        colors(context).primaryColor!
                      ],
                    ),
                  ),
                  child: Stack(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 12.h),
                        decoration: BoxDecoration(
                          color: colors(GlobalFunction.context).light,
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Container(
                                  height: 64.h,
                                  width: 64.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16.dm),
                                    color: colors(GlobalFunction.context).dark,
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(16.dm),
                                    child: CachedNetworkImage(
                                      imageUrl: profileDetails.shop.logo,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: -5,
                                  right: -5,
                                  child: CircleAvatar(
                                    radius: 18.r,
                                    backgroundColor:
                                        colors(GlobalFunction.context).light,
                                    child: CircleAvatar(
                                      backgroundColor:
                                          colors(GlobalFunction.context)
                                              .primaryColor,
                                      backgroundImage:
                                          CachedNetworkImageProvider(
                                        profileDetails.profilePhoto,
                                      ),
                                      radius: 16.sp,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Gap(8.h),
                            Text(profileDetails.shop.name,
                                style: AppTextStyle.text16B700),
                            Row(
                              children: [
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.star_rounded,
                                      color: AppStaticColor.orange,
                                    ),
                                    Gap(5.w),
                                    Text(
                                      profileDetails.shop.rating.toString(),
                                      style: AppTextStyle.text12B700,
                                    ),
                                    Gap(5.w),
                                    Text(
                                      '(${profileDetails.shop.totalReviews})',
                                      style: AppTextStyle.text12B700.copyWith(
                                        fontWeight: FontWeight.w400,
                                        color: AppStaticColor.gray,
                                      ),
                                    ),
                                  ],
                                ),
                                Gap(16.w),
                                Container(
                                  height: 12.h,
                                  width: 1.w,
                                  color: AppStaticColor.gray,
                                ),
                                Gap(16.w),
                                Text(
                                  '${profileDetails.shop.totalProducts}+ Products',
                                  style: AppTextStyle.text12B700.copyWith(
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 16.h,
                        right: 16.w,
                        child: OnlineSwitch(
                          isOnline: profileDetails.shop.shopStatus != 'Offline',
                        ),
                      )
                    ],
                  ),
                ),
              );
        },
      ),
    );
  }

  Widget _buildUserInfoCard({required UserAccountDetails profileDetails}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            decoration: BoxDecoration(
              border: Border.all(color: AppStaticColor.secondary, width: 2),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          Assets.svg.activeProfile,
                          colorFilter: ColorFilter.mode(
                            AppStaticColor.primary,
                            BlendMode.srcIn,
                          ),
                        ),
                        Gap(4.w),
                        Text(
                          'USER INFO',
                          style: AppTextStyle.text14B700,
                        )
                      ],
                    ),
                    _buildEditButton(),
                  ],
                ),
                Gap(12.h),
                Row(
                  children: [
                    Flexible(
                      fit: FlexFit.tight,
                      flex: 1,
                      child: _buildInfoColumn(
                          key: 'Full Name',
                          value:
                              '${profileDetails.firstName} ${profileDetails.lastName}'),
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      flex: 1,
                      child: _buildInfoColumn(
                          key: 'Phone Number', value: profileDetails.phone),
                    ),
                  ],
                ),
                Gap(16.h),
                Row(
                  children: [
                    Flexible(
                      fit: FlexFit.tight,
                      flex: 1,
                      child: _buildInfoColumn(
                          key: 'Gender', value: profileDetails.gender),
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      flex: 1,
                      child: _buildInfoColumn(
                          key: 'Email', value: profileDetails.email),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            right: -45,
            top: -55,
            child: GestureDetector(
              onTap: () {
                GoRouter.of(GlobalFunction.context)
                    .push(Routes.userInfo, extra: profileDetails);
              },
              child: _buildCorner(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShopInfoCard({required UserAccountDetails profileDetails}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            decoration: BoxDecoration(
              border: Border.all(color: AppStaticColor.secondary, width: 2),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          width: 24.w,
                          Assets.svg.shop,
                          colorFilter: ColorFilter.mode(
                            AppStaticColor.primary,
                            BlendMode.srcIn,
                          ),
                        ),
                        Gap(4.w),
                        Text(
                          'SHOP INFO',
                          style: AppTextStyle.text14B700,
                        )
                      ],
                    ),
                    _buildEditButton(),
                  ],
                ),
                Gap(12.h),
                Row(
                  children: [
                    Flexible(
                      fit: FlexFit.tight,
                      flex: 1,
                      child: _buildInfoColumn(
                          key: 'Shop Name', value: profileDetails.shop.name),
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      flex: 1,
                      child: _buildInfoColumn(
                          key: 'Shop Phone Number',
                          value: profileDetails.phone),
                    ),
                  ],
                ),
                Gap(16.h),
                _buildInfoColumn(
                    key: 'Address', value: profileDetails.shop.address),
                Gap(16.h),
                _buildDescriptionWidget(
                    description: profileDetails.shop.description)
              ],
            ),
          ),
          Positioned(
            right: -45,
            top: -55,
            child: GestureDetector(
              onTap: () {
                GoRouter.of(GlobalFunction.context)
                    .push(Routes.shopInfo, extra: profileDetails);
              },
              child: _buildCorner(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShopSettingsCard({required UserAccountDetails profileDetails}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            decoration: BoxDecoration(
              border: Border.all(color: AppStaticColor.secondary, width: 2),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          width: 24.w,
                          Assets.svg.shopSettings,
                          colorFilter: ColorFilter.mode(
                            AppStaticColor.primary,
                            BlendMode.srcIn,
                          ),
                        ),
                        Gap(4.w),
                        Text(
                          'SHOP SETTINGS',
                          style: AppTextStyle.text14B700,
                        )
                      ],
                    ),
                    _buildEditButton(),
                  ],
                ),
                Gap(12.h),
                Row(
                  children: [
                    Flexible(
                      fit: FlexFit.tight,
                      flex: 1,
                      child: _buildInfoColumn(
                          key: 'Delivery Charge', value: '\$30'),
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      flex: 1,
                      child: _buildInfoColumn(
                          key: 'Estimated Delivery Time',
                          value:
                              '${profileDetails.shop.estimatedDeliveryTime} Days'),
                    ),
                  ],
                ),
                Gap(16.h),
                Row(
                  children: [
                    Flexible(
                      fit: FlexFit.tight,
                      flex: 1,
                      child: _buildInfoColumn(
                          key: 'Opening Time',
                          value: '${profileDetails.shop.openTime} AM'),
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      flex: 1,
                      child: _buildInfoColumn(
                          key: 'Closing Time',
                          value: '${profileDetails.shop.closeTime} PM'),
                    ),
                  ],
                ),
                Gap(16.h),
                Row(
                  children: [
                    Flexible(
                      fit: FlexFit.tight,
                      flex: 1,
                      child: _buildInfoColumn(
                          key: 'Off Day',
                          value: profileDetails.shop.offDay.join(', ')),
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      flex: 1,
                      child: _buildInfoColumn(
                          key: 'Order ID Prefix',
                          value: profileDetails.shop.prefix),
                    ),
                  ],
                ),
                Gap(16.h),
                _buildInfoColumn(
                    key: 'Min. Order Amount',
                    value: '\$${profileDetails.shop.minOrderAmount}'),
              ],
            ),
          ),
          Positioned(
            right: -45,
            top: -55,
            child: GestureDetector(
              onTap: () {
                GoRouter.of(GlobalFunction.context)
                    .push(Routes.shopSettings, extra: profileDetails);
              },
              child: _buildCorner(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _shopBannersCardWidget({required UserAccountDetails profileDetails}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            decoration: BoxDecoration(
              border: Border.all(color: AppStaticColor.secondary, width: 2),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          width: 24.w,
                          Assets.svg.shopGallery,
                          colorFilter: ColorFilter.mode(
                            AppStaticColor.primary,
                            BlendMode.srcIn,
                          ),
                        ),
                        Gap(4.w),
                        Text(
                          'SHOP BANNERS',
                          style: AppTextStyle.text14B700,
                        )
                      ],
                    ),
                    _buildEditButton(),
                  ],
                ),
                Gap(12.h),
                _buildBannerListWidget(profileDetails: profileDetails),
              ],
            ),
          ),
          Positioned(
            right: -45,
            top: -55,
            child: GestureDetector(
              onTap: () {
                GoRouter.of(GlobalFunction.context)
                    .push(Routes.shopBanners, extra: profileDetails);
              },
              child: _buildCorner(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCorner() {
    return Container(
      width: 100.w,
      height: 100.h,
      decoration: BoxDecoration(
        border: Border.all(color: AppStaticColor.secondary, width: 2),
        borderRadius: BorderRadius.circular(100),
      ),
    );
  }

  Widget _buildEditButton() {
    return SvgPicture.asset(
      Assets.svg.infoEdit,
      colorFilter: ColorFilter.mode(
        AppStaticColor.primary,
        BlendMode.srcIn,
      ),
    );
  }

  Widget _buildInfoColumn({required String key, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          key,
          style: AppTextStyle.text14B400.copyWith(color: AppStaticColor.gray),
        ),
        Gap(8.h),
        Text(
          value,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyle.text14B400,
        )
      ],
    );
  }

  Widget _buildDescriptionWidget({required String description}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(8.sp),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.dm),
          color: colors(GlobalFunction.context).secondaryColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Description',
            style:
                AppTextStyle.text14B400.copyWith(color: AppStaticColor.black),
          ),
          Gap(8.h),
          Html(
            data: description,
          ),
        ],
      ),
    );
  }

  Widget _buildBannerListWidget({required UserAccountDetails profileDetails}) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.only(top: 12.h),
      shrinkWrap: true,
      itemCount: profileDetails.banners.length,
      itemBuilder: (context, index) => Padding(
        padding: EdgeInsets.only(bottom: 12.h),
        child: ClipRRect(
          clipBehavior: Clip.hardEdge,
          borderRadius: BorderRadius.circular(8.dm),
          child: CachedNetworkImage(
            height: 100.h,
            fit: BoxFit.cover,
            imageUrl: profileDetails.banners[index].thumbnail,
          ),
        ),
      ),
    );
  }

  static final List<String> banners = [
    'https://img.freepik.com/free-vector/modern-violet-color-elegant-wave-style-banner-design_1055-13649.jpg?w=360',
    'https://img.freepik.com/free-vector/modern-abstract-purple-background-with-elegant-elements-vector-illustration_361591-3692.jpg'
  ];
}
