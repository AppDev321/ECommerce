import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';
import 'package:razin_commerce_seller_flutter/config/app_color.dart';
import 'package:razin_commerce_seller_flutter/config/app_text_style.dart';
import 'package:razin_commerce_seller_flutter/config/theme.dart';
import 'package:razin_commerce_seller_flutter/features/common/widgets/custom_button.dart';
import 'package:razin_commerce_seller_flutter/features/common/widgets/custom_text_field.dart';
import 'package:razin_commerce_seller_flutter/features/profile/models/profile_details.dart';
import 'package:razin_commerce_seller_flutter/features/profile/models/shop_settings_update_model.dart';
import 'package:razin_commerce_seller_flutter/features/profile/providers/profile_provider.dart';
import 'package:razin_commerce_seller_flutter/features/profile/widgets/custom_date_picker.dart';
import 'package:razin_commerce_seller_flutter/features/profile/widgets/off_day_picker.dart';
import 'package:razin_commerce_seller_flutter/utils/global_function.dart';

class ShopSettingsScreen extends StatefulWidget {
  final UserAccountDetails userAccountDetails;
  const ShopSettingsScreen({super.key, required this.userAccountDetails});

  @override
  State<ShopSettingsScreen> createState() => _ShopSettingsScreenState();
}

class _ShopSettingsScreenState extends State<ShopSettingsScreen> {
  late final TextEditingController _estimatedDeliveryTimeController;
  late final TextEditingController _openingTimeController;
  late final TextEditingController _closingTimeController;
  late final TextEditingController _offDayController;
  late final TextEditingController _orderPrefixController;
  late final TextEditingController _minimumOrderAmountController;
  late final GlobalKey<FormBuilderState> _formKey;

  TimeOfDay _openTime = const TimeOfDay(hour: 8, minute: 0);
  TimeOfDay _closeTime = const TimeOfDay(hour: 20, minute: 0);

  @override
  void initState() {
    super.initState();
    _estimatedDeliveryTimeController = TextEditingController(
        text: widget.userAccountDetails.shop.estimatedDeliveryTime.toString());
    _openingTimeController = TextEditingController(
        text: formatTimeOfDay(
            stringToTimeOfDay(widget.userAccountDetails.shop.openTime))[0]);
    _closingTimeController = TextEditingController(
        text: formatTimeOfDay(
            stringToTimeOfDay(widget.userAccountDetails.shop.closeTime))[0]);
    _offDayController = TextEditingController(
        text: widget.userAccountDetails.shop.offDay.join(', '));
    _orderPrefixController =
        TextEditingController(text: widget.userAccountDetails.shop.prefix);
    _minimumOrderAmountController = TextEditingController(
        text: widget.userAccountDetails.shop.minOrderAmount.toString());
    _formKey = GlobalKey<FormBuilderState>();
    List<dynamic> value = formatTimeOfDay(
        stringToTimeOfDay(widget.userAccountDetails.shop.openTime));
    debugPrint(value.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _buildBottomNavigationBar(),
      appBar: AppBar(
        title: const Text('Shop Settings'),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Consumer(
      builder: (context, ref, _) {
        return Container(
          margin: EdgeInsets.only(top: 16.h),
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          color: colors(context).light,
          child: FormBuilder(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomTextFormField(
                    name: 'Estimated Delivery Time',
                    textInputType: TextInputType.number,
                    controller: _estimatedDeliveryTimeController,
                    textInputAction: TextInputAction.next,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                          errorText: 'Estimated Delivery Time is required'),
                      // value must be double
                      if (ref.read(selectedDropDownValue) == 'Day')
                        FormBuilderValidators.integer(errorText: 'Must be int'),
                    ]),
                    hintText: 'Estimated Delivery Time',
                    widget: SizedBox(
                      width: 75.w,
                      child: DropdownButton(
                        borderRadius: BorderRadius.circular(8.r),
                        dropdownColor: colors(context).light,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        underline: const SizedBox(),
                        elevation: 0,
                        padding: EdgeInsets.zero,
                        value: ref.watch(selectedDropDownValue),
                        itemHeight: kMinInteractiveDimension,
                        items: ['Day', 'Month']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 0),
                              child: Text(
                                value,
                                style: AppTextStyle.text16B400
                                    .copyWith(color: AppStaticColor.gray),
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          ref.read(selectedDropDownValue.notifier).state =
                              newValue!;
                        },
                      ),
                    ),
                  ),
                  Gap(20.h),
                  Row(
                    children: [
                      Flexible(
                        child: GestureDetector(
                          onTap: () => _selectTime(context, true),
                          child: CustomTextFormField(
                            readOnly: true,
                            name: 'Opening Time',
                            textInputType: TextInputType.text,
                            controller: _openingTimeController,
                            textInputAction: TextInputAction.next,
                            validator: FormBuilderValidators.required(
                                errorText: 'Opening Time is required'),
                            hintText: 'Opening Time',
                          ),
                        ),
                      ),
                      const Gap(20),
                      Flexible(
                        child: GestureDetector(
                          onTap: () => _selectTime(context, false),
                          child: CustomTextFormField(
                            readOnly: true,
                            name: 'Closing Time',
                            textInputType: TextInputType.text,
                            controller: _closingTimeController,
                            textInputAction: TextInputAction.next,
                            validator: FormBuilderValidators.required(
                                errorText: 'Closing Time is required'),
                            hintText: 'Closing Time',
                          ),
                        ),
                      ),
                    ],
                  ),
                  Gap(20.h),
                  GestureDetector(
                    onTap: () => _pickDay(context: context),
                    child: CustomTextFormField(
                      readOnly: true,
                      name: 'Off Day',
                      textInputType: TextInputType.text,
                      controller: _offDayController,
                      textInputAction: TextInputAction.next,
                      validator: FormBuilderValidators.required(
                          errorText: 'Off Day is required'),
                      hintText: 'Off Day',
                    ),
                  ),
                  Gap(20.h),
                  Row(
                    children: [
                      Flexible(
                        flex: 1,
                        child: CustomTextFormField(
                          name: 'Order Prefix',
                          textInputType: TextInputType.text,
                          controller: _orderPrefixController,
                          textInputAction: TextInputAction.next,
                          validator: FormBuilderValidators.required(
                              errorText: 'Order Prefix is required'),
                          hintText: 'Order Prefix',
                        ),
                      ),
                      Gap(20.w),
                      Flexible(
                        child: CustomTextFormField(
                          name: 'Min. ORder Amount',
                          textInputType: TextInputType.number,
                          controller: _minimumOrderAmountController,
                          textInputAction: TextInputAction.done,
                          validator: FormBuilderValidators.required(
                              errorText: 'Minimum Order Amount is required'),
                          hintText: 'Minimum Order Amount',
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _selectTime(BuildContext context, bool isOpeningTime) async {
    await showModalBottomSheet(
        isDismissible: false,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext context) {
          return Padding(
            padding:
                EdgeInsets.symmetric(horizontal: 16.w).copyWith(bottom: 20.h),
            child: CustomTimePicker(
              title: isOpeningTime ? 'Opening Time' : 'Closing Time',
              isAM: isOpeningTime
                  ? formatTimeOfDay(
                          stringToTimeOfDay(_openingTimeController.text))[2] ==
                      'AM'
                  : formatTimeOfDay(
                          stringToTimeOfDay(_closingTimeController.text))[2] ==
                      'PM',
              initialTime: isOpeningTime
                  ? formatTimeOfDay(
                      stringToTimeOfDay(_openingTimeController.text))[1]
                  : formatTimeOfDay(
                      stringToTimeOfDay(_closingTimeController.text))[1],
              onTimeChanged: (time, isAM) {
                if (isOpeningTime) {
                  _openTime = time;
                  _openingTimeController.text = _openTime.format(context);
                } else {
                  _closeTime = time;
                  _closingTimeController.text = _closeTime.format(context);
                }
              },
            ),
          );
        });
  }

  Future<void> _pickDay({required BuildContext context}) async {
    await showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: false,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Padding(
          padding:
              EdgeInsets.symmetric(horizontal: 16.w).copyWith(bottom: 20.h),
          child: OffDayPicker(
            offDays:
                _offDayController.text.split(',').map((e) => e.trim()).toList(),
            onDateChanged: (days) =>
                _offDayController.text = days.join(', ').replaceFirst(',', ''),
          ),
        );
      },
    );
  }

  List<dynamic> formatTimeOfDay(TimeOfDay time) {
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    final minute = time.minute.toString().padLeft(2, '0');
    return [
      '$hour:$minute $period',
      TimeOfDay(
        hour: hour,
        minute: int.parse(minute),
      ),
      period,
    ];
  }

  TimeOfDay stringToTimeOfDay(String time) {
    final parts = time.split(':');
    final hour = int.parse(parts[0]);
    final minute = int.parse(parts[1].split(' ')[0]);
    return TimeOfDay(hour: hour, minute: minute);
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      height: 86.h,
      color: colors(context).light,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Consumer(builder: (context, ref, _) {
        return ref.watch(shopSettingsServiceProvider)
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : CustomButton(
                buttonName: 'Update',
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    final ShopSettingsUpdateModel model =
                        ShopSettingsUpdateModel(
                      openingTime: _openingTimeController.text,
                      closingTime: _closingTimeController.text,
                      offDays: _offDayController.text
                          .split(',')
                          .map((e) => e.trim())
                          .toList(),
                      orderPrefix: _orderPrefixController.text,
                      minimumOrderAmount: _minimumOrderAmountController.text,
                      estimatedDeliveryTime:
                          int.parse(_estimatedDeliveryTimeController.text),
                    );
                    ref
                        .read(shopSettingsServiceProvider.notifier)
                        .updateShopSettings(model: model)
                        .then((response) => [
                              if (response.status)
                                ref.refresh(profileDetailsServiceProvider),
                              GlobalFunction.showCustomSnackbar(
                                  message: response.message,
                                  isSuccess: response.status)
                            ]);
                  }
                },
              );
      }),
    );
  }
}

final selectedDropDownValue = StateProvider<String>((ref) => 'Day');
