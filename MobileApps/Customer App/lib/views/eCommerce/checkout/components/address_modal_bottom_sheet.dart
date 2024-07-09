import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:razin_shop/components/ecommerce/custom_transparent_button.dart';
import 'package:razin_shop/config/app_color.dart';
import 'package:razin_shop/config/app_constants.dart';
import 'package:razin_shop/config/app_text_style.dart';
import 'package:razin_shop/controllers/eCommerce/address/address_controller.dart';
import 'package:razin_shop/controllers/misc/misc_controller.dart';
import 'package:razin_shop/generated/l10n.dart';
import 'package:razin_shop/models/eCommerce/address/add_address.dart';
import 'package:razin_shop/routes.dart';
import 'package:razin_shop/utils/context_less_navigation.dart';
import 'package:razin_shop/views/eCommerce/checkout/components/address_card.dart';

class AddressModalBottomSheet extends ConsumerStatefulWidget {
  const AddressModalBottomSheet({super.key});

  @override
  ConsumerState<AddressModalBottomSheet> createState() =>
      _AddressModalBottomSheetState();
}

class _AddressModalBottomSheetState
    extends ConsumerState<AddressModalBottomSheet> {
  final EdgeInsets _edgeInsets =
      EdgeInsets.symmetric(horizontal: 20.w).copyWith(bottom: 20.h, top: 60.h);
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(addressControllerProvider.notifier).getAddress();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height / 1.8,
          child: ref.watch(addressControllerProvider)
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Padding(
                  padding: _edgeInsets,
                  child: Scrollbar(
                    child: ListView.builder(
                      padding: EdgeInsets.only(bottom: 60.h),
                      scrollDirection: Axis.vertical,
                      itemCount: ref
                          .watch(addressControllerProvider.notifier)
                          .addressList
                          .length,
                      shrinkWrap: true,
                      itemBuilder: ((context, index) {
                        final AddAddress address = ref
                            .watch(addressControllerProvider.notifier)
                            .addressList[index];
                        return Padding(
                          padding: EdgeInsets.only(bottom: 8.h),
                          child: AddressCard(
                            editTap: () {
                              context.nav.popAndPushNamed(
                                  Routes.getAddUpdateAddressViewRouteName(
                                      AppConstants.appServiceName),
                                  arguments: address);
                            },
                            onTap: () {
                              ref.read(selectedDeliveryAddress.notifier).state =
                                  address;
                              context.nav.pop();
                            },
                            address: address,
                            showEditButton: true,
                          ),
                        );
                      }),
                    ),
                  ),
                ),
        ),
        Positioned(
          left: 20.w,
          right: 12.w,
          top: 5.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                S.of(context).savedAddress,
                style: AppTextStyle(context).subTitle,
              ),
              IconButton(
                onPressed: () {
                  context.nav.pop();
                },
                icon: const Icon(Icons.close),
              )
            ],
          ),
        ),
        Positioned(
          left: 20.w,
          right: 20.w,
          bottom: 20.h,
          child: CustomTransparentButton(
            buttonText: S.of(context).addNew,
            onTap: () {
              context.nav.popAndPushNamed(
                  Routes.getAddUpdateAddressViewRouteName(
                      AppConstants.appServiceName));
            },
            borderColor: EcommerceAppColor.primary,
            buttonTextColor: EcommerceAppColor.primary,
          ),
        )
      ],
    );
  }

  final List<Map<String, dynamic>> addressList = [
    {
      "addressTag": "Home",
      "name": "Jahidul Islam",
      "phone": "+014725836990",
      "address": "Shekhertek,52/A,Adabor,Mohammadpur-1207",
      "isDefault": false,
    },
    {
      "addressTag": "Office",
      "name": "Tarek Islam",
      "phone": "+014725836990",
      "address": "Shekhertek,52/A,Adabor,Mohammadpur-1207",
      "isDefault": true,
    },
    {
      "addressTag": "Other",
      "name": "Mehedi Hassan",
      "phone": "+014725836990",
      "address": "Shekhertek,52/A,Adabor,Mohammadpur-1207",
      "isDefault": false,
    },
  ];
}
