import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:razinshop_rider/components/my_custom_button.dart';
import 'package:razinshop_rider/config/app_color.dart';
import 'package:razinshop_rider/config/app_constants.dart';
import 'package:razinshop_rider/config/app_text.dart';
import 'package:razinshop_rider/controllers/order_controller/order_controller.dart';
import 'package:razinshop_rider/gen/assets.gen.dart';
import 'package:razinshop_rider/generated/l10n.dart';
import 'package:razinshop_rider/routers.dart';
import 'package:razinshop_rider/utils/context_less_navigate.dart';

class CashCollectDialog extends ConsumerWidget {
  const CashCollectDialog({
    super.key,
    required this.amount,
    required this.orderId,
  });
  final String amount;
  final int orderId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loading = ref.watch(orderStatusUpdateProvider);
    return PopScope(
      canPop: false,
      child: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.all(16.r),
                width: double.infinity,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 75.r,
                      width: 75.r,
                      padding: EdgeInsets.all(10.r),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColor.primaryColor.withOpacity(0.1),
                      ),
                      child: SvgPicture.asset(Assets.svgs.moneys),
                    ),
                    Gap(15.h),
                    SizedBox(
                      width: 250.w,
                      child: Text(
                        S.of(context).makesureCashCollect,
                        textAlign: TextAlign.center,
                        style: AppTextStyle.title,
                      ),
                    ),
                    Gap(15.h),
                    Container(
                      padding: const EdgeInsets.all(12).r,
                      width: double.infinity,
                      decoration: ShapeDecoration(
                        color: Color(0xFFF7F7F7),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(width: 1, color: Color(0xFFF1F1F5)),
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            S.of(context).amountOf,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF617885),
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Gap(3.h),
                          ValueListenableBuilder(
                              valueListenable:
                                  Hive.box(AppConstants.appSettingsBox)
                                      .listenable(),
                              builder: (context, box, child) {
                                return Text(
                                  '${box.get(AppConstants.currency) ?? "\$"}$amount',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0xFF05161B),
                                    fontSize: 24.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                );
                              })
                        ],
                      ),
                    ),
                    Gap(16.h),
                    loading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : MyCustomButton(
                            onTap: () {
                              ref
                                  .read(orderStatusUpdateProvider.notifier)
                                  .updateOrderStatus(
                                    orderId,
                                  )
                                  .then((value) {
                                ref
                                    .read(orderListProvider.notifier)
                                    .orderList
                                    .clear();
                                ref.invalidate(orderListProvider);

                                context.nav.pushNamedAndRemoveUntil(
                                    Routes.home, (route) => false);
                              });
                            },
                            btnColor: Color(0xFF1EDD31),
                            btnText: S.of(context).yesCollect,
                          ),
                  ],
                ),
              ),
            ],
          ),
          // Positioned(
          //   right: 0,
          //   top: 0,
          //   child: IconButton(
          //     icon: Icon(Icons.close),
          //     onPressed: () {
          //       context.nav
          //           .pushNamedAndRemoveUntil(Routes.home, (route) => false);
          //       ref.refresh(orderListProvider.notifier).getOrders();
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}
