import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:razin_shop/components/ecommerce/confirmation_dialog.dart';
import 'package:razin_shop/components/ecommerce/custom_button.dart';
import 'package:razin_shop/config/app_color.dart';
import 'package:razin_shop/config/app_constants.dart';
import 'package:razin_shop/config/app_text_style.dart';
import 'package:razin_shop/config/theme.dart';
import 'package:razin_shop/controllers/eCommerce/authentication/authentication_controller.dart';
import 'package:razin_shop/controllers/misc/misc_controller.dart';
import 'package:razin_shop/gen/assets.gen.dart';
import 'package:razin_shop/generated/l10n.dart';
import 'package:razin_shop/models/eCommerce/authentication/user.dart';
import 'package:razin_shop/routes.dart';
import 'package:razin_shop/services/common/hive_service_provider.dart';
import 'package:razin_shop/utils/context_less_navigation.dart';

class EcommerceMoreLayout extends ConsumerWidget {
  const EcommerceMoreLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isDark =
        Theme.of(context).scaffoldBackgroundColor == EcommerceAppColor.black;

    return SafeArea(
      child: Scaffold(
        backgroundColor:
            isDark ? EcommerceAppColor.black : EcommerceAppColor.offWhite,
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    color: EcommerceAppColor.white,
                    padding: EdgeInsets.symmetric(horizontal: 16.w)
                        .copyWith(top: 31.h),
                    child: ref.read(hiveServiceProvider).userIsLoggedIn()
                        ? _buildProfileContainer(context)
                        : _userInfoWidget(
                            User(
                                id: null,
                                name: 'Guest User',
                                phone: '01472*****',
                                email: '',
                                isActive: true,
                                profilePhoto:
                                    'https://m.media-amazon.com/images/I/31jPSK41kEL._AC_UF1000,1000_QL80_.jpg',
                                gender: 'Male',
                                dateOfBirth: ''),
                            context),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.w).copyWith(
                      top: ref.read(hiveServiceProvider).userIsLoggedIn()
                          ? 20.h
                          : 40.h,
                    ),
                    color: EcommerceAppColor.white,
                    child: AnimationLimiter(
                      child: Column(
                        children: AnimationConfiguration.toStaggeredList(
                          duration: const Duration(milliseconds: 375),
                          childAnimationBuilder: (widget) => SlideAnimation(
                              verticalOffset: 50.h,
                              child: FadeInAnimation(child: widget)),
                          children: [
                            Visibility(
                              visible: ref
                                  .read(hiveServiceProvider)
                                  .userIsLoggedIn(),
                              child: _buildProfileItem(
                                context: context,
                                icon: Assets.svg.profile,
                                text: S.of(context).myProfile,
                                onTap: () {
                                  context.nav.pushNamed(
                                      Routes.getProfileViewRouteName(
                                          AppConstants.appServiceName));
                                },
                              ),
                            ),
                            Visibility(
                              visible: ref
                                  .read(hiveServiceProvider)
                                  .userIsLoggedIn(),
                              child: _buildProfileItem(
                                context: context,
                                icon: Assets.svg.bag,
                                text: S.of(context).orders,
                                onTap: () {
                                  context.nav.pushNamed(
                                      Routes.getMyOrderViewRouteName(
                                          AppConstants.appServiceName));
                                },
                              ),
                            ),
                            Visibility(
                              visible: ref
                                  .read(hiveServiceProvider)
                                  .userIsLoggedIn(),
                              child: _buildProfileItem(
                                context: context,
                                icon: Assets.svg.support,
                                text: S.of(context).support,
                                onTap: () {
                                  context.nav.pushNamed(Routes.supportView);
                                },
                              ),
                            ),
                            Visibility(
                              visible: ref
                                  .read(hiveServiceProvider)
                                  .userIsLoggedIn(),
                              child: _buildProfileItem(
                                context: context,
                                icon: Assets.svg.heart,
                                text: S.of(context).wishlist,
                                onTap: () {
                                  context.nav.pushNamed(
                                      Routes.getFavouritesProductsViewRouteName(
                                          AppConstants.appServiceName));
                                },
                              ),
                            ),
                            Visibility(
                              visible: ref
                                  .read(hiveServiceProvider)
                                  .userIsLoggedIn(),
                              child: _buildProfileItem(
                                context: context,
                                icon: Assets.svg.location,
                                text: S.of(context).manageAddress,
                                onTap: () {
                                  context.nav.pushNamed(
                                      Routes.getManageAddressViewRouteName(
                                          AppConstants.appServiceName));
                                },
                              ),
                            ),
                            _buildProfileItem(
                              context: context,
                              icon: Assets.svg.translate,
                              text: S.of(context).language,
                              onTap: () {
                                context.nav.pushNamed(Routes.languageView);
                              },
                            ),
                            Visibility(
                              visible: ref
                                  .read(hiveServiceProvider)
                                  .userIsLoggedIn(),
                              child: _buildProfileItem(
                                context: context,
                                icon: Assets.svg.key,
                                text: S.of(context).changePassword,
                                onTap: () {
                                  context.nav.pushNamed(Routes.changePassword);
                                },
                              ),
                            ),
                            Gap(8.h),
                            _buildProfileItem(
                              context: context,
                              icon: Assets.svg.refund,
                              text: S.of(context).refundPolicy,
                              onTap: () {
                                context.nav.pushNamed(Routes.refundPolicyView);
                              },
                            ),
                            Gap(8.h),
                            _buildProfileItem(
                              context: context,
                              icon: Assets.svg.terms,
                              text: S.of(context).termsCondistions,
                              onTap: () {
                                context.nav
                                    .pushNamed(Routes.termsAndConditionsView);
                              },
                            ),
                            Gap(8.h),
                            _buildProfileItem(
                              context: context,
                              icon: Assets.svg.privacy,
                              text: S.of(context).privacyPolicy,
                              onTap: () {
                                context.nav.pushNamed(Routes.privacyPolicyView);
                              },
                            ),
                            Gap(20.h),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10.h)
                        .copyWith(bottom: 30.h),
                    color: Theme.of(context).scaffoldBackgroundColor,
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 20.h,
                    ),
                    child: ref.read(hiveServiceProvider).userIsLoggedIn() ==
                            false
                        ? CustomButton(
                            buttonText: 'Login',
                            onPressed: () {
                              ref
                                  .refresh(selectedTabIndexProvider.notifier)
                                  .state;
                              context.nav.pushNamedAndRemoveUntil(
                                  Routes.login, (route) => false);
                            },
                          )
                        : _buildProfileItem(
                            context: context,
                            icon: Assets.svg.logout,
                            text: S.of(context).logout,
                            isRightIcon: false,
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) =>
                                    Consumer(builder: (context, ref, _) {
                                  return ConfirmationDialog(
                                    title: S.of(context).logoutDialogTitle,
                                    des: S.of(context).logoutDialogDes,
                                    confirmButtonText: S.of(context).confirm,
                                    onPressed: () {
                                      ref
                                          .read(authControllerProvider.notifier)
                                          .logout()
                                          .then((response) {
                                        if (response.isSuccess) {
                                          ref
                                              .read(hiveServiceProvider)
                                              .removeAllData()
                                              .then(
                                            (value) async {
                                              ref
                                                  .refresh(
                                                      selectedTabIndexProvider
                                                          .notifier)
                                                  .state;
                                              context.nav.pop();
                                              context.nav.pushReplacementNamed(
                                                  Routes.login);
                                            },
                                          );
                                        }
                                      });
                                    },
                                    isLoading:
                                        ref.watch(authControllerProvider),
                                  );
                                }),
                              );
                            },
                          ),
                  )
                ],
              ),
            ),
            // Positioned(
            //   top: 30.h,
            //   left: 20.w,
            //   right: 20.w,
            //   child: _buildProfileContainer(context),
            // )
          ],
        ),
      ),
    );
  }

  Widget _buildProfileContainer(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: Hive.box(AppConstants.userBox).listenable(),
        builder: (context, box, _) {
          Map<dynamic, dynamic>? userInfo = box.get(AppConstants.userData);
          Map<String, dynamic> userInfoStringKeys =
              userInfo!.cast<String, dynamic>();
          final User user = User.fromMap(userInfoStringKeys);
          return _userInfoWidget(user, context);
        });
  }

  Container _userInfoWidget(User user, BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 16.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          colors: [EcommerceAppColor.primary, const Color(0xFFB822FF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          transform: const GradientRotation(263 * (3.14159265359 / 30)),
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 36.sp,
            backgroundImage: CachedNetworkImageProvider(user.profilePhoto!),
          ),
          Gap(10.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user.name!,
                style: AppTextStyle(context)
                    .subTitle
                    .copyWith(color: EcommerceAppColor.white),
              ),
              Gap(8.h),
              Text(
                user.phone!,
                style: AppTextStyle(context).bodyTextSmall.copyWith(
                      color: EcommerceAppColor.white,
                      fontWeight: FontWeight.w400,
                    ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildProfileItem({
    required BuildContext context,
    required String icon,
    required String text,
    required void Function()? onTap,
    bool isRightIcon = true,
  }) {
    return Material(
      borderRadius: BorderRadius.circular(12.r),
      surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
      color: Theme.of(context).scaffoldBackgroundColor,
      child: InkWell(
        borderRadius: BorderRadius.circular(12.r),
        onTap: onTap,
        child: Container(
          margin: EdgeInsets.only(top: 8.h),
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: EcommerceAppColor.offWhite),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    icon,
                    width: 24.w,
                    colorFilter: ColorFilter.mode(
                        colors(context).primaryColor!, BlendMode.srcIn),
                  ),
                  Gap(10.w),
                  Text(
                    text,
                    style: AppTextStyle(context)
                        .bodyText
                        .copyWith(fontWeight: FontWeight.w500),
                  )
                ],
              ),
              if (isRightIcon)
                Icon(
                  Icons.arrow_forward_ios,
                  size: 16.sp,
                  color: EcommerceAppColor.lightGray,
                ),
            ],
          ),
        ),
      ),
    );
  }

  final String profieImge =
      'https://media.istockphoto.com/id/1336647287/photo/portrait-of-handsome-indian-businessman-with-mustache-wearing-hat-against-plain-wall.jpg?s=612x612&w=0&k=20&c=XOuLIyFb2DBO8voUXecWkYNxwRrIMYcTRU4QlK9ILks=';
}
