import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:razinshop_rider/config/app_color.dart';
import 'package:razinshop_rider/config/app_constants.dart';
import 'package:razinshop_rider/config/app_text.dart';
import 'package:razinshop_rider/controllers/auth_controller/auth_controller.dart';
import 'package:razinshop_rider/gen/assets.gen.dart';
import 'package:razinshop_rider/generated/l10n.dart';
import 'package:razinshop_rider/routers.dart';
import 'package:razinshop_rider/utils/context_less_navigate.dart';

class MyDrawer extends StatelessWidget {
  MyDrawer({super.key});

  //make a logout dialog
  showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Consumer(
          builder: (context, ref, child) {
            final loading = ref.watch(logOutProvider);
            return AlertDialog(
              title: Text('Logout'),
              content: Text('Are you sure you want to logout?'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('No'),
                ),
                TextButton(
                  onPressed: () {
                    ref.read(logOutProvider.notifier).logOut().then((value) {
                      if (value == true) {
                        context.nav.pushNamedAndRemoveUntil(
                            Routes.login, (route) => false);
                      }
                    });
                  },
                  child: loading ? CircularProgressIndicator() : Text('Yes'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      surfaceTintColor: Colors.white,
      backgroundColor: Colors.white,
      shape: Border.all(color: Colors.white),
      child: Column(
        children: [
          Gap(48.h),
          // Header section
          _HeaderSection(),
          // Summery section
          _SummerySection(),
          // Others section
          _OthersSection(),
          const Spacer(),
          Align(
            alignment: Alignment.centerLeft,
            child: Consumer(
              builder: (context, ref, child) {
                return InkWell(
                  onTap: () {
                    // close drawer
                    // scaffoldKey.currentState!.closeDrawer();
                    context.nav.pop();
                    showLogoutDialog(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8).r,
                    margin: const EdgeInsets.all(16).r,
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 1, color: Color(0xFFF1F1F5)),
                        borderRadius: BorderRadius.circular(8).r,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          S.of(context).logout,
                          textAlign: TextAlign.right,
                          style: AppTextStyle.normalBody.copyWith(
                            color: Color(0xFF617885),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Gap(8.r),
                        SvgPicture.asset(Assets.svgs.logout,
                            height: 24.r, width: 24.r)
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class _OthersSection extends ConsumerStatefulWidget {
  const _OthersSection();

  @override
  ConsumerState<_OthersSection> createState() => _OthersSectionState();
}

class _OthersSectionState extends ConsumerState<_OthersSection> {
  final GlobalKey<FormBuilderState> dropdownKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Order History
        ListTile(
          leading: SvgPicture.asset(
            Assets.svgs.group,
            colorFilter: ColorFilter.mode(
              AppColor.primaryColor,
              BlendMode.srcIn,
            ),
          ),
          title: Text(S.of(context).orderHistory),
          trailing: SvgPicture.asset(Assets.svgs.arrowRight),
          onTap: () {
            context.nav.pushNamed(Routes.orderHistory);
          },
        ),
        Divider(
          indent: 16.r,
          endIndent: 16.r,
          color: AppColor.borderColor,
        ),
        // Language
        ListTile(
          leading: SvgPicture.asset(
            Assets.svgs.language,
            colorFilter: ColorFilter.mode(
              AppColor.primaryColor,
              BlendMode.srcIn,
            ),
          ),
          title: Text(S.of(context).language),
          trailing: IntrinsicWidth(
            child: Container(
              // height: 30.h,
              padding: EdgeInsets.symmetric(horizontal: 8.r),
              decoration: ShapeDecoration(
                color: Colors.grey.withOpacity(0.1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: LocalizationSelector(
                dropdownKey: dropdownKey,
              ),
            ),
          ),
          // onTap: () {
          //   LocalizationSelector(dropdownKey: dropdownKey);
          // },
        ),
        Divider(
          indent: 16.r,
          endIndent: 16.r,
          color: AppColor.borderColor,
        ),
        // rider support
        ListTile(
          leading: SvgPicture.asset(
            Assets.svgs.support,
            colorFilter: ColorFilter.mode(
              AppColor.primaryColor,
              BlendMode.srcIn,
            ),
          ),
          title: Text(S.of(context).riderSupport),
          trailing: SvgPicture.asset(Assets.svgs.arrowRight),
          onTap: () {},
        ),
        Divider(
          indent: 16.r,
          endIndent: 16.r,
          color: AppColor.borderColor,
        ),
        // Terms and Conditions
        ListTile(
          leading: SvgPicture.asset(
            Assets.svgs.tandC,
            colorFilter: ColorFilter.mode(
              AppColor.primaryColor,
              BlendMode.srcIn,
            ),
          ),
          title: Text(S.of(context).termsAndConditions),
          trailing: SvgPicture.asset(Assets.svgs.arrowRight),
          onTap: () {
            context.nav.pop();
            context.nav.pushNamed(Routes.termsAndCondition);
          },
        ),
        Divider(
          indent: 16.r,
          endIndent: 16.r,
          color: AppColor.borderColor,
        ),
        // Privacy Policy
        ListTile(
          leading: SvgPicture.asset(
            Assets.svgs.privacy,
            colorFilter: ColorFilter.mode(
              AppColor.primaryColor,
              BlendMode.srcIn,
            ),
          ),
          title: Text(S.of(context).privacyPolicy),
          trailing: SvgPicture.asset(Assets.svgs.arrowRight),
          onTap: () {
            context.nav.pushNamed(Routes.privayPolicay);
          },
        ),
        Divider(
          indent: 16.r,
          endIndent: 16.r,
          color: AppColor.borderColor,
        ),
        // Change Password
        ListTile(
          leading: SvgPicture.asset(
            Assets.svgs.key,
            colorFilter: ColorFilter.mode(
              AppColor.primaryColor,
              BlendMode.srcIn,
            ),
          ),
          title: Text(S.of(context).changePassword),
          trailing: SvgPicture.asset(Assets.svgs.arrowRight),
          onTap: () {
            context.nav.pushNamed(Routes.changePassword);
          },
        ),
        Divider(
          indent: 16.r,
          endIndent: 16.r,
          color: AppColor.borderColor,
        ),
      ],
    );
  }
}

class _SummerySection extends StatelessWidget {
  const _SummerySection();

  Expanded _summeryCard({
    required String title,
    required String value,
    bool isAmount = false,
    required String icon,
  }) {
    return Expanded(
        child: Container(
      padding: const EdgeInsets.all(8),
      decoration: ShapeDecoration(
        color: Color(0xFF273238),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: AppTextStyle.normalBody.copyWith(
                    color: Colors.white,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Gap(2.w),
              SvgPicture.asset(
                icon,
                width: 24.r,
                height: 24.r,
              )
            ],
          ),
          ValueListenableBuilder(
              valueListenable:
                  Hive.box(AppConstants.appSettingsBox).listenable(),
              builder: (context, box, child) {
                return Text(
                  isAmount
                      ? "${box.get(AppConstants.currency) ?? "\$"}$value"
                      : value,
                  style: AppTextStyle.normalBody.copyWith(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                  ),
                );
              })
        ],
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: Hive.box(AppConstants.authBox).listenable(),
        builder: (context, Box box, child) {
          return Container(
            padding: const EdgeInsets.all(12).r,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                left: BorderSide(color: Color(0xFFF1F1F5)),
                top: BorderSide(width: 1, color: Color(0xFFF1F1F5)),
                right: BorderSide(color: Color(0xFFF1F1F5)),
                bottom: BorderSide(width: 1, color: Color(0xFFF1F1F5)),
              ),
            ),
            child: Row(
              children: [
                _summeryCard(
                  title:
                      '${S.of(context).completeJonIn} ${DateFormat('MMMM').format(DateTime.now())}',
                  value: box
                          .get(AppConstants.userData)?['curren_month_deliverd']
                          .toString() ??
                      0.toString(),
                  icon: Assets.svgs.tickCircle,
                ),
                Gap(8.w),
                _summeryCard(
                  title:
                      '${S.of(context).completeJonIn} ${DateFormat('MMMM').format(DateTime.now())}',
                  value: box
                      .get(
                          AppConstants.userData)['current_month_cash_collected']
                      .toStringAsFixed(2),
                  isAmount: true,
                  icon: Assets.svgs.dollarCircle,
                ),
              ],
            ),
          );
        });
  }
}

class _HeaderSection extends StatelessWidget {
  const _HeaderSection();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: Hive.box(AppConstants.authBox).listenable(),
        builder: (context, Box box, child) {
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Color(0x0A000000),
                  blurRadius: 20,
                  offset: Offset(0, 4),
                  spreadRadius: 0,
                )
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30.r,
                  backgroundColor: Colors.grey,
                  child: CachedNetworkImage(
                    imageUrl: box.get(AppConstants.userData)?['user']
                            ?['profile_photo'] ??
                        '',
                  ),
                ),
                Gap(10.r),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${box.get(AppConstants.userData)?['user']?['first_name'] ?? ''} ${box.get(AppConstants.userData)?['user']?['last_name'] ?? ''}",
                      style: AppTextStyle.normalBody.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      box.get(AppConstants.userData)?['user']?['phone'] ?? '',
                      style: AppTextStyle.normalBody.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF969899),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        context.nav
                            .pushNamed(Routes.registration, arguments: true);
                      },
                      child: Text(
                        S.of(context).viewProfile,
                        style: AppTextStyle.normalBody.copyWith(
                          color: Color(0xFF2196F3),
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          );
        });
  }
}

class LocalizationSelector extends StatelessWidget {
  final GlobalKey<FormBuilderState> dropdownKey;
  LocalizationSelector({super.key, required this.dropdownKey});

  final List<AppLanguage> languages = [
    AppLanguage(name: '\ud83c\uddfa\ud83c\uddf8 ENG', value: 'en'),
    // AppLanguage(name: '🇪🇬 مصر', value: 'ar'),
    AppLanguage(name: '🇧🇩 বাংলা', value: 'bn'),
    // spanish
    AppLanguage(name: '🇪🇸 Español', value: 'es'),
  ];

  @override
  Widget build(BuildContext context) {
    return FormBuilderDropdown<String>(
      // decoration: AppInputDecor.loginPageInputDecor.copyWith(
      //   fillColor: Colors.transparent,
      // ),
      key: dropdownKey,
      decoration: const InputDecoration(border: InputBorder.none),
      icon: const SizedBox(),
      initialValue:
          Hive.box(AppConstants.appSettingsBox).get(AppConstants.appLocal) ??
              'en',
      name: 'language',
      items: languages
          .map(
            (e) => DropdownMenuItem(
              value: e.value,
              child: Text(
                e.name,
              ),
            ),
          )
          .toList(),
      onChanged: (value) {
        print('tapped');
        if (value != null && value != '') {
          Hive.box(AppConstants.appSettingsBox)
              .put(AppConstants.appLocal, value);
        }
      },
      onTap: () {},
    );
  }
}

class AppLanguage {
  String name;
  String value;
  AppLanguage({
    required this.name,
    required this.value,
  });
}
