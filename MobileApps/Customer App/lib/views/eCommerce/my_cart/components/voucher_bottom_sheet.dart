// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:razin_shop/config/app_text_style.dart';
import 'package:razin_shop/config/theme.dart';
import 'package:razin_shop/controllers/eCommerce/voucher/voucher_controller.dart';
import 'package:razin_shop/generated/l10n.dart';
import 'package:razin_shop/utils/context_less_navigation.dart';
import 'package:razin_shop/views/eCommerce/my_cart/components/voucher_card.dart';

class VoucherBottomSheet extends ConsumerStatefulWidget {
  final int shopId;
  final String shopName;
  const VoucherBottomSheet({
    Key? key,
    required this.shopId,
    required this.shopName,
  }) : super(key: key);

  @override
  ConsumerState<VoucherBottomSheet> createState() => _VoucherBottomSheetState();
}

class _VoucherBottomSheetState extends ConsumerState<VoucherBottomSheet> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref
          .read(voucherControllerProvider.notifier)
          .getVoucher(shopId: widget.shopId);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                S.of(context).voucherFrom,
                style: AppTextStyle(context).bodyTextSmall.copyWith(
                      fontWeight: FontWeight.w500,
                      color: colors(context).dark,
                    ),
              ),
              IconButton(
                onPressed: () {
                  context.nav.pop();
                },
                icon: const Icon(Icons.close),
              )
            ],
          ),
          Text(
            widget.shopName,
            style: AppTextStyle(context).subTitle.copyWith(fontSize: 20.sp),
          ),
          Gap(16.h),
          Expanded(
            child: ref.watch(voucherControllerProvider)
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ref
                        .watch(voucherControllerProvider.notifier)
                        .voucherList
                        .isEmpty
                    ? Center(
                        child: Text(
                          S.of(context).voucherNotAvailable,
                          style: AppTextStyle(context).bodyText,
                        ),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: ref
                            .watch(voucherControllerProvider.notifier)
                            .voucherList
                            .length,
                        itemBuilder: ((context, index) {
                          final voucher = ref
                              .watch(voucherControllerProvider.notifier)
                              .voucherList[index];
                          return Padding(
                            padding: EdgeInsets.only(bottom: 20.h),
                            child: VoucherCard(
                              voucher: voucher,
                            ),
                          );
                        }),
                      ),
          )
        ],
      ),
    );
  }

  final List<Map<String, dynamic>> voucherList = [
    {
      "amount": 10,
      "minimumSpend": 200,
      "validityDate": "23 February 2024",
      "isCollected": false,
    },
    {
      "amount": 20,
      "minimumSpend": 400,
      "validityDate": "25 February 2024",
      "isCollected": true,
    },
    {
      "amount": 20,
      "minimumSpend": 400,
      "validityDate": "25 February 2024",
      "isCollected": true,
    },
    {
      "amount": 20,
      "minimumSpend": 400,
      "validityDate": "25 February 2024",
      "isCollected": true,
    },
    {
      "amount": 20,
      "minimumSpend": 400,
      "validityDate": "25 February 2024",
      "isCollected": true,
    },
    {
      "amount": 20,
      "minimumSpend": 400,
      "validityDate": "25 February 2024",
      "isCollected": true,
    }
  ];
}
