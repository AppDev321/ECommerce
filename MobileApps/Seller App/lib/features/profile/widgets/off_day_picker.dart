import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:razin_commerce_seller_flutter/config/app_color.dart';
import 'package:razin_commerce_seller_flutter/config/app_text_style.dart';
import 'package:razin_commerce_seller_flutter/config/theme.dart';
import 'package:razin_commerce_seller_flutter/features/common/widgets/custom_button.dart';
import 'package:razin_commerce_seller_flutter/utils/context_less_navigation.dart';

class OffDayPicker extends StatefulWidget {
  final List<String> offDays;
  final Function(List<String>) onDateChanged;
  const OffDayPicker(
      {super.key, required this.onDateChanged, required this.offDays});

  @override
  State<OffDayPicker> createState() => _OffDayPickerState();
}

class _OffDayPickerState extends State<OffDayPicker> {
  @override
  void initState() {
    for (var day in widget.offDays) {
      String dayName = day[0].toUpperCase() + day.substring(1);
      selectedValues.add(dayName);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 1.65,
      width: double.infinity,
      padding: EdgeInsets.all(16.dm),
      decoration: BoxDecoration(
        color: colors(context).light,
        borderRadius: BorderRadius.circular(16.dm),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Gap(10.h),
          Text(
            'Off Day',
            style: AppTextStyle.text16B700.copyWith(fontSize: 18.sp),
          ),
          Gap(20.h),
          Expanded(
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _days.length,
              itemBuilder: (context, index) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _days[index]['label']!,
                    style: AppTextStyle.text14B400,
                  ),
                  Theme(
                    data: Theme.of(context).copyWith(
                      unselectedWidgetColor: AppStaticColor.lightGray,
                    ),
                    child: Checkbox(
                      side: const BorderSide(
                          color: AppStaticColor.lightGray, width: 2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.dm),
                      ),
                      value: selectedValues.contains(_days[index]['value']),
                      onChanged: (value) {
                        setState(() {
                          if (value!) {
                            selectedValues.add(_days[index]['value']!);
                          } else {
                            selectedValues.remove(_days[index]['value']);
                          }
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Gap(20.h),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: CustomButton(
                  color: colors(context).secondaryColor,
                  textColor: colors(context).dark,
                  buttonName: 'Close',
                  onTap: () => context.nav.pop(),
                ),
              ),
              Gap(20.w),
              Expanded(
                flex: 1,
                child: CustomButton(
                  buttonName: 'OK',
                  onTap: () {
                    widget.onDateChanged(selectedValues.toList());
                    context.nav.pop();
                  },
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Set<String> selectedValues = {};

  final List<Map<String, String>> _days = [
    {'label': 'Sunday', 'value': 'Sun'},
    {'label': 'Monday', 'value': 'Mon'},
    {'label': 'Tuesday', 'value': 'Tue'},
    {'label': 'Wednesday', 'value': 'Wed'},
    {'label': 'Thursday', 'value': 'Thu'},
    {'label': 'Friday', 'value': 'Fri'},
    {'label': 'Saturday', 'value': 'Sat'},
  ];
}
