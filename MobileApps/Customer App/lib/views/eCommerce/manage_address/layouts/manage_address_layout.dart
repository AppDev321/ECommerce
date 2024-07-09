import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:razin_shop/components/ecommerce/custom_transparent_button.dart';
import 'package:razin_shop/config/app_color.dart';
import 'package:razin_shop/config/app_constants.dart';
import 'package:razin_shop/config/theme.dart';
import 'package:razin_shop/controllers/eCommerce/address/address_controller.dart';
import 'package:razin_shop/generated/l10n.dart';
import 'package:razin_shop/models/eCommerce/address/add_address.dart';
import 'package:razin_shop/routes.dart';
import 'package:razin_shop/utils/context_less_navigation.dart';
import 'package:razin_shop/views/eCommerce/checkout/components/address_card.dart';

class ManageAddressLayout extends ConsumerStatefulWidget {
  const ManageAddressLayout({super.key});

  @override
  ConsumerState<ManageAddressLayout> createState() =>
      _ManageAddressLayoutState();
}

class _ManageAddressLayoutState extends ConsumerState<ManageAddressLayout> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(addressControllerProvider.notifier).getAddress();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).manageAddress),
          surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
        ),
        bottomNavigationBar: _buildBottomNavigationWidget(context: context),
        body: Column(
          children: [
            const Divider(
              thickness: 10,
              color: EcommerceAppColor.offWhite,
            ),
            Expanded(
              child: ref.watch(addressControllerProvider)
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.builder(
                      itemCount: ref
                          .watch(addressControllerProvider.notifier)
                          .addressList
                          .length,
                      itemBuilder: ((context, index) {
                        final AddAddress address = ref
                            .watch(addressControllerProvider.notifier)
                            .addressList[index];
                        return Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.w, vertical: 5.h),
                          child: AddressCard(
                            cardColor: EcommerceAppColor.white,
                            showEditButton: true,
                            onTap: () {
                              // context.nav.pushNamed(
                              //     Routes.getAddUpdateAddressViewRouteName(
                              //         AppConstants.appServiceName),
                              //     arguments: address);
                            },
                            editTap: () {
                              context.nav.pushNamed(
                                  Routes.getAddUpdateAddressViewRouteName(
                                      AppConstants.appServiceName),
                                  arguments: address);
                            },
                            address: address,
                          ),
                        );
                      }),
                    ),
            ),
          ],
        ));
  }

  Widget _buildBottomNavigationWidget({required BuildContext context}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14),
      height: 86.h,
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            color: EcommerceAppColor.offWhite,
            width: 2.0,
          ),
        ),
      ),
      child: CustomTransparentButton(
        buttonText: S.of(context).addNew,
        onTap: () {
          context.nav.pushNamed(Routes.getAddUpdateAddressViewRouteName(
              AppConstants.appServiceName));
        },
        borderColor: colors(context).primaryColor,
        buttonTextColor: colors(context).primaryColor,
      ),
    );
  }
}
