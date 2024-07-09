import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:razin_commerce_seller_flutter/config/app_text_style.dart';
import 'package:razin_commerce_seller_flutter/config/routes.dart';
import 'package:razin_commerce_seller_flutter/config/theme.dart';
import 'package:razin_commerce_seller_flutter/features/auth/screens/shop_details_widget.dart';
import 'package:razin_commerce_seller_flutter/features/auth/screens/shop_owner_widget.dart';
import 'package:razin_commerce_seller_flutter/features/auth/widgets/otp_bottom_sheet.dart';
import 'package:razin_commerce_seller_flutter/features/common/widgets/custom_button.dart';
import 'package:razin_commerce_seller_flutter/utils/global_function.dart';

import '../providers/auth_provider.dart';

class Registration extends ConsumerStatefulWidget {
  const Registration({super.key});

  static final pinputControllerController = TextEditingController();

  @override
  ConsumerState<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends ConsumerState<Registration>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      _handleTabSelection();
    });
  }

  void _handleTabSelection() {
    ref.read(activeTabIndex.notifier).state = tabController.index + 1;
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: _buildBottomNavigationBar(),
      appBar: AppBar(
        title: const Text('Registration'),
        automaticallyImplyLeading: true,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: Text(
              '${ref.watch(activeTabIndex)}/2',
              style: AppTextStyle.text16B400.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
      body: TabBarView(
        controller: tabController,
        physics: !ref.watch(isEmailVerified)
            ? const NeverScrollableScrollPhysics()
            : null,
        children: const [
          ShopOwnerWidget(),
          ShopDetailsWidget(),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      // width: double.infinity,
      color: colors(GlobalFunction.navigatorKey.currentContext).light,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: AbsorbPointer(
        absorbing: !ref.watch(isAcceptTermsAndConditions),
        child: CustomButton(
          color: !ref.watch(isAcceptTermsAndConditions)
              ? ColorTween(
                  begin: colors(context).primaryColor,
                  end: colors(context).light,
                ).lerp(0.5)!
              : colors(context).primaryColor,
          buttonName:
              ref.watch(activeTabIndex) == 1 ? 'Procced Next' : 'Submit',
          onTap: () => ref.read(activeTabIndex) == 1
              ? executeShopOwnerForm()
              : executeShopDetailsForm(),
        ),
      ),
    );
  }

  void executeShopOwnerForm() {
    if (ref.watch(shopOwnerFormKey).currentState!.validate()) {
      if (ref.read(selectedProfileImage) != null) {
        ref
            .read(authServiceProvider.notifier)
            .sendOTP(
              email: ref.read(emailController).text.trim(),
              isForgotPassword: false,
            )
            .then((response) {
          response.status == true
              ? showModalBottomSheet(
                  isDismissible: false,
                  isScrollControlled: true,
                  enableDrag: false,
                  context: GlobalFunction.navigatorKey.currentContext!,
                  builder: (_) => ConfirmOTPBottomSheet(
                    pinCodeController: Registration.pinputControllerController,
                    tabController: tabController,
                  ),
                )
              : GlobalFunction.showCustomSnackbar(
                  message: response.message,
                  isSuccess: false,
                );
        });
      } else {
        GlobalFunction.showCustomSnackbar(
          message: 'Profile image is required',
          isSuccess: false,
        );
      }
    }
  }

  void executeShopDetailsForm() {
    if (ref.watch(shopDetailsFormKey).currentState!.validate()) {
      if (ref.read(selectedShopLogo) == null) {
        GlobalFunction.showCustomSnackbar(
          message: 'Shop logo is required',
          isSuccess: false,
        );
      } else if (ref.read(selectedShopBanner) == null) {
        GlobalFunction.showCustomSnackbar(
          message: 'Shop banner is required',
          isSuccess: false,
        );
      } else {
        GoRouter.of(context).push(Routes.createPassword, extra: null);
      }
    }
  }
}

final activeTabIndex = StateProvider<int>((ref) => 1);
final isEmailVerified = StateProvider<bool>((ref) => false);
