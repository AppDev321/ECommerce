import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:razin_commerce_seller_flutter/config/app_color.dart';
import 'package:razin_commerce_seller_flutter/config/app_text_style.dart';
import 'package:razin_commerce_seller_flutter/config/theme.dart';
import 'package:razin_commerce_seller_flutter/features/common/widgets/custom_button.dart';
import 'package:razin_commerce_seller_flutter/utils/context_less_navigation.dart';

class CustomTimePicker extends StatefulWidget {
  final String title;
  final bool isAM;
  final TimeOfDay initialTime;
  final Function(TimeOfDay, bool) onTimeChanged;
  const CustomTimePicker({
    super.key,
    required this.title,
    required this.initialTime,
    required this.onTimeChanged,
    required this.isAM,
  });

  @override
  State<CustomTimePicker> createState() => _CustomTimePickerState();
}

class _CustomTimePickerState extends State<CustomTimePicker> {
  late int _selectedHour;
  late int _selectedMinute;
  late bool _isAM;

  @override
  void initState() {
    super.initState();
    _selectedHour = widget.initialTime.hour;
    _selectedMinute = widget.initialTime.minute;
    _isAM = widget.isAM;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.dm),
      decoration: BoxDecoration(
        color: colors(context).light,
        borderRadius: BorderRadius.circular(16.dm),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            widget.title,
            style: AppTextStyle.text16B700.copyWith(fontSize: 18.sp),
          ),
          Gap(16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: widget.title == 'Opening Time' ? 50.h : 0,
                  bottom: widget.title != 'Opening Time' ? 50.h : 0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _isAM = !_isAM;
                        });
                      },
                      child: Text(
                        'AM',
                        style: AppTextStyle.text16B700.copyWith(
                            color: !_isAM ? AppStaticColor.lightGray : null),
                      ),
                    ),
                    Gap(25.h),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _isAM = !_isAM;
                        });
                      },
                      child: Text(
                        'PM',
                        style: AppTextStyle.text16B700.copyWith(
                            color: _isAM ? AppStaticColor.lightGray : null),
                      ),
                    ),
                  ],
                ),
              ),
              NumberPicker(
                zeroPad: true,
                minValue: 1,
                maxValue: 12,
                value: _selectedHour,
                onChanged: (value) => setState(() {
                  _selectedHour = value;
                }),
                selectedTextStyle: AppTextStyle.text16B700,
                textStyle: AppTextStyle.text14B700
                    .copyWith(color: AppStaticColor.lightGray),
              ),
              NumberPicker(
                zeroPad: true,
                minValue: 0,
                maxValue: 59,
                value: _selectedMinute,
                onChanged: (value) => setState(() {
                  _selectedMinute = value;
                }),
                selectedTextStyle: AppTextStyle.text16B700,
                textStyle: AppTextStyle.text14B700
                    .copyWith(color: AppStaticColor.lightGray),
              ),
            ],
          ),
          Gap(20.h),
          Row(
            children: [
              Flexible(
                flex: 1,
                child: CustomButton(
                  color: colors(context).secondaryColor,
                  textColor: colors(context).dark,
                  buttonName: 'Close',
                  onTap: () => context.nav.pop(),
                ),
              ),
              Gap(20.w),
              Flexible(
                flex: 1,
                child: CustomButton(
                  buttonName: 'Ok',
                  onTap: () {
                    final selectedTime = TimeOfDay(
                      hour: _isAM ? _selectedHour : _selectedHour + 12,
                      minute: _selectedMinute,
                    );
                    widget.onTimeChanged(selectedTime, _isAM);
                    context.nav.pop();
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
