import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:razin_commerce_seller_flutter/config/app_color.dart';
import 'package:razin_commerce_seller_flutter/config/app_text_style.dart';
import 'package:razin_commerce_seller_flutter/config/theme.dart';
import 'package:razin_commerce_seller_flutter/features/common/widgets/custom_button.dart';
import 'package:razin_commerce_seller_flutter/features/order/models/order_filter_model.dart';
import 'package:razin_commerce_seller_flutter/features/order/providers/order_provider.dart';
import 'package:razin_commerce_seller_flutter/features/order/screens/orders.dart';

class CustomDatePicker extends ConsumerWidget {
  const CustomDatePicker({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dialog(
      backgroundColor: AppStaticColor.white,
      surfaceTintColor: AppStaticColor.white,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildHeaderWidget(context: context, ref: ref),
            const Divider(
              height: 0,
              color: AppStaticColor.secondary,
              thickness: 2,
            ),
            _buildBodyWidget(context: context, ref: ref),
            Gap(20.h)
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderWidget(
      {required BuildContext context, required WidgetRef ref}) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20.w,
      ).copyWith(bottom: 20.h, top: 12.h),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                padding: EdgeInsets.zero,
                visualDensity: VisualDensity.compact,
                onPressed: () {
                  ref.refresh(selectedDateFilter.notifier).state;
                  ref.refresh(startDate.notifier).state;
                  ref.refresh(endDate.notifier).state;
                  GoRouter.of(context).pop(context);
                },
                icon: Icon(
                  Icons.close,
                  size: 28.sp,
                ),
              ),
              GestureDetector(
                onTap: () {
                  ref.refresh(selectedDateFilter.notifier).state;
                  ref.refresh(startDate.notifier).state;
                  ref.refresh(endDate.notifier).state;
                },
                child: Text(
                  'Reset',
                  style: AppTextStyle.text14B400.copyWith(
                    fontWeight: FontWeight.w500,
                    color: AppStaticColor.red,
                  ),
                ),
              )
            ],
          ),
          Gap(20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Mon, Aug 17',
                style: AppTextStyle.text24B700.copyWith(fontSize: 28.sp),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBodyWidget(
      {required BuildContext context, required WidgetRef ref}) {
    return Column(
      children: [
        SizedBox(
          child: CalendarDatePicker2(
            config: CalendarDatePicker2Config(
              calendarType: CalendarDatePicker2Type.range,
              firstDate: DateTime(2020),
              lastDate: DateTime.now(),
              calendarViewMode: CalendarDatePicker2Mode.day,
              lastMonthIcon: const Icon(
                Icons.chevron_left,
                color: AppStaticColor.black,
              ),
              nextMonthIcon: const Icon(
                Icons.chevron_right,
                color: AppStaticColor.black,
              ),
              yearTextStyle: AppTextStyle.text14B700,
              selectedYearTextStyle:
                  AppTextStyle.text14B700.copyWith(color: AppStaticColor.white),
              controlsTextStyle: AppTextStyle.text16B700,
              weekdayLabelTextStyle: AppTextStyle.text12B700,
              dayTextStyle: AppTextStyle.text14B400,
              selectedDayTextStyle: AppTextStyle.text12B700.copyWith(
                  fontWeight: FontWeight.w500, color: AppStaticColor.white),
            ),
            value: const [],
            onDisplayedMonthChanged: (v) {},
            onValueChanged: (date) {
              if (date.first != null) {
                ref.read(startDate.notifier).state =
                    DateFormat('yyyy-MM-dd').format(date.first!);
              }
              if (date.last != null) {
                ref.read(endDate.notifier).state =
                    DateFormat('yyyy-MM-dd').format(date.last!);
              }
              ref.refresh(selectedDateFilter.notifier).state;
            },
          ),
        ),
        SizedBox(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: const Column(
              children: [
                Divider(
                  height: 0,
                  color: AppStaticColor.secondary,
                  thickness: 2,
                ),
              ],
            ),
          ),
        ),
        Gap(10.h),
        GridView.count(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          crossAxisCount: 2,
          childAspectRatio: 6.sp,
          crossAxisSpacing: 20.sp,
          mainAxisSpacing: 12.sp,
          children: List.generate(
            filterOption(context: context).length,
            (index) => Row(
              children: [
                Theme(
                  data: Theme.of(context).copyWith(
                      unselectedWidgetColor: AppStaticColor.lightGray,
                      disabledColor: AppStaticColor.lightGray),
                  child: Radio(
                    value: filterOption(context: context)[index]['key'],
                    groupValue: ref.watch(selectedDateFilter),
                    onChanged: (v) {
                      if (ref.read(startDate) != null) {
                        ref.refresh(startDate.notifier).state;
                        ref.refresh(endDate.notifier).state;
                      }
                      ref.read(selectedDateFilter.notifier).state = v!;
                    },
                    activeColor: colors(context).primaryColor,
                  ),
                ),
                Text(
                  filterOption(context: context)[index]['name'] ?? '',
                  style: AppTextStyle.text14B400
                      .copyWith(fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ),
        Gap(30.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Row(
            children: [
              Flexible(
                flex: 1,
                child: SizedBox(
                  height: 54.h,
                  child: CustomButton(
                    textColor: AppStaticColor.black,
                    color: AppStaticColor.secondary,
                    buttonName: 'Cancel',
                    onTap: () {
                      ref.refresh(selectedDateFilter.notifier).state;
                      ref.refresh(startDate.notifier).state;
                      ref.refresh(endDate.notifier).state;
                      GoRouter.of(context).pop(context);
                    },
                  ),
                ),
              ),
              Gap(20.w),
              Flexible(
                flex: 1,
                child: SizedBox(
                  height: 54.h,
                  child: CustomButton(
                    buttonName: 'Apply',
                    onTap: () {
                      ref.read(orderServiceProvider.notifier).getOrders(
                            filter: OrderFilterModel(
                              page: 1,
                              perPage: 1,
                              status: ref.read(selectedOrderStatusProvider),
                              startDate: ref.read(startDate),
                              endDate: ref.read(endDate) ?? ref.read(startDate),
                              filterType: ref.read(selectedDateFilter),
                            ),
                          );
                      ref.refresh(selectedDateFilter.notifier).state;
                      ref.refresh(startDate.notifier).state;
                      ref.refresh(endDate.notifier).state;
                      GoRouter.of(context).pop(context);
                    },
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  // String formattedDate({required DateTime date}) {
  //   return DateFormat('E, MMM d').format(date.toLocal());
  // }

  List<Map<String, String>> filterOption({required BuildContext context}) {
    return [
      {"key": "today", "name": 'Today'},
      {"key": "this_week", "name": 'This week'},
      {"key": "last_week", "name": 'Last week'},
      {"key": "this_month", "name": 'This month'},
      {"key": "last_month", "name": 'Last month'},
      {"key": "this_year", "name": 'This year'},
      {"key": "last_year", "name": 'Last year'},
    ];
  }
}

final startDate = StateProvider<String?>((ref) => null);
final endDate = StateProvider<String?>((ref) => null);
final selectedDateFilter = StateProvider<String?>((ref) => null);
