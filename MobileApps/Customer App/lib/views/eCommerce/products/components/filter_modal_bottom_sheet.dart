// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:razin_shop/components/ecommerce/custom_button.dart';
import 'package:razin_shop/config/app_color.dart';
import 'package:razin_shop/config/app_text_style.dart';
import 'package:razin_shop/config/theme.dart';
import 'package:razin_shop/controllers/common/master_controller.dart';
import 'package:razin_shop/controllers/eCommerce/product/product_controller.dart';
import 'package:razin_shop/controllers/misc/misc_controller.dart';
import 'package:razin_shop/generated/l10n.dart';
import 'package:razin_shop/models/eCommerce/common/product_filter_model.dart';
import 'package:razin_shop/utils/context_less_navigation.dart';

// ignore: must_be_immutable
class FilterModalBottomSheet extends ConsumerStatefulWidget {
  ProductFilterModel productFilterModel;
  FilterModalBottomSheet({
    Key? key,
    required this.productFilterModel,
  }) : super(key: key);

  @override
  ConsumerState<FilterModalBottomSheet> createState() =>
      _FilterModalBottomSheetState();
}

class _FilterModalBottomSheetState
    extends ConsumerState<FilterModalBottomSheet> {
  final EdgeInsets _edgeInsets =
      EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h)
          .copyWith(bottom: 20.h);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: _edgeInsets,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHeader(),
          Gap(10.h),
          _buildCustomerReviewSection(),
          Gap(20.h),
          _buildSortSection(),
          Gap(20.h),
          _buildProductPriceSection(),
          Gap(30.h),
          _buildActionButtons(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          S.of(context).filter,
          style: AppTextStyle(context).subTitle,
        ),
        IconButton(
          onPressed: () {
            _onPressClear();
            context.nav.pop();
          },
          icon: const Icon(Icons.close),
        )
      ],
    );
  }

  Widget _buildCustomerReviewSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).customerReview,
          style: AppTextStyle(context)
              .bodyText
              .copyWith(fontWeight: FontWeight.w600),
        ),
        Gap(8.h),
        _buildReviewChips(),
      ],
    );
  }

  Widget _buildReviewChips() {
    return Wrap(
      direction: Axis.horizontal,
      spacing: 8.0,
      runSpacing: 8.0,
      children: List.generate(
        reviewList.length,
        (index) => Material(
          surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
          color: ref.watch(selectedReviewIndex) == index
              ? colors(context).primaryColor
              : Theme.of(context).scaffoldBackgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(8.r),
            onTap: () {
              ref.read(selectedReviewIndex.notifier).state = index;
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
              width: 80.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: EcommerceAppColor.offWhite),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.star_rounded,
                    size: 16.sp,
                    color: EcommerceAppColor.carrotOrange,
                  ),
                  Gap(10.w),
                  Text(
                    reviewList[index].toString(),
                    style: AppTextStyle(context).bodyText.copyWith(
                          fontWeight: FontWeight.w600,
                          color: ref.watch(selectedReviewIndex) == index
                              ? colors(context).light
                              : colors(context).dark,
                        ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSortSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).sortBy,
          style: AppTextStyle(context)
              .bodyText
              .copyWith(fontWeight: FontWeight.w600),
        ),
        Gap(10.h),
        _buildSortChips(),
      ],
    );
  }

  Widget _buildSortChips() {
    return Wrap(
      children: List.generate(
        getSortList(context).length,
        (index) => Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: ChoiceChip(
            backgroundColor: colors(context).light,
            disabledColor: colors(context).light,
            labelStyle: TextStyle(
              color: ref.watch(selectedSortByIndex) == index
                  ? colors(context).light
                  : colors(context).dark,
            ),
            label: Text(
              getSortList(context)[index]['title'],
            ),
            selectedColor: colors(context).primaryColor,
            surfaceTintColor: colors(context).light,
            checkmarkColor: colors(context).light,
            selected: ref.watch(selectedSortByIndex) == index,
            onSelected: (bool selected) {
              ref.watch(selectedSortByIndex.notifier).state = index;

              widget.productFilterModel = widget.productFilterModel
                  .copyWith(sortType: getSortList(context)[index]['key']);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildProductPriceSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              S.of(context).productPrice,
              style: AppTextStyle(context)
                  .bodyText
                  .copyWith(fontWeight: FontWeight.w600),
            ),
            Text(
              "${ref.read(masterControllerProvider.notifier).materModel.data.currency.symbol}${ref.watch(selectedMinPrice).toInt()} - ${ref.read(masterControllerProvider.notifier).materModel.data.currency.symbol}${ref.watch(selectedMaxPrice).toInt()}",
              style: AppTextStyle(context).bodyText.copyWith(
                    fontWeight: FontWeight.w500,
                    color: colors(context).primaryColor,
                  ),
            )
          ],
        ),
        Gap(20.h),
        _buildPriceSlider(),
        Gap(10.h),
        _buildPriceRangeLabels(),
      ],
    );
  }

  Widget _buildPriceSlider() {
    return SliderTheme(
      data: SliderThemeData(
        trackHeight: 8.h,
        overlayShape: SliderComponentShape.noThumb,
      ),
      child: RangeSlider(
        inactiveColor: colors(context).accentColor,
        activeColor: colors(context).primaryColor,
        min: 0.0,
        max: 5000.0,
        values: RangeValues(
            ref.watch(selectedMinPrice), ref.watch(selectedMaxPrice)),
        onChanged: (values) {
          ref.read(selectedMinPrice.notifier).state = values.start;
          ref.read(selectedMaxPrice.notifier).state = values.end;
        },
      ),
    );
  }

  Widget _buildPriceRangeLabels() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          ref
                  .read(masterControllerProvider.notifier)
                  .materModel
                  .data
                  .currency
                  .symbol +
              0.toString(),
          style: AppTextStyle(context).bodyTextSmall,
        ),
        Text(
          ref
                  .read(masterControllerProvider.notifier)
                  .materModel
                  .data
                  .currency
                  .symbol +
              5000.toString(),
          style: AppTextStyle(context).bodyTextSmall,
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Flexible(
          flex: 1,
          child: InkWell(
            borderRadius: BorderRadius.circular(50.r),
            onTap: () => _onPressClear(),
            child: Container(
              height: 50.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50.r),
                  border: Border.all(color: EcommerceAppColor.black)),
              child: Center(
                child: Text(
                  S.of(context).clear,
                  style: AppTextStyle(context).bodyText.copyWith(
                        color: EcommerceAppColor.black,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ),
            ),
          ),
        ),
        Gap(20.w),
        Flexible(
          flex: 1,
          child: Consumer(builder: (context, ref, _) {
            return CustomButton(
              buttonText: S.of(context).apply,
              onPressed: _onPressFilter,
            );
          }),
        ),
      ],
    );
  }

  void _onPressFilter() {
    ref.read(productControllerProvider.notifier).getCategoryWiseProducts(
          productFilterModel: widget.productFilterModel.copyWith(
            rating: ref.read(selectedReviewIndex) != null
                ? reviewList[ref.read(selectedReviewIndex)!]
                : null,
            sortType: ref.read(selectedSortByIndex) != null
                ? getSortList(context)[ref.read(selectedSortByIndex)!]['key']
                : null,
            minPrice: ref.read(selectedMinPrice).toInt(),
            maxPrice: ref.read(selectedMaxPrice).toInt(),
          ),
          isPagination: false,
        );
    context.nav.pop();
  }

  void _onPressClear() {
    ref.refresh(selectedReviewIndex.notifier).state;
    ref.refresh(selectedSortByIndex.notifier).state;
    ref.refresh(selectedMaxPrice.notifier).state;
    ref.refresh(selectedMinPrice.notifier).state;
  }

  final List<double> reviewList = [5.0, 4.0, 3.0, 2.0, 1.0];
  List<Map<String, dynamic>> getSortList(BuildContext context) {
    final List<Map<String, dynamic>> sortList = [
      {
        "title": S.of(context).priceHighToLow,
        "key": "heigh_to_low",
      },
      {
        "title": S.of(context).priceLowToHigh,
        "key": "low_to_high",
      },
      {
        "title": S.of(context).productPrice,
        "key": "newest",
      },
      {
        "title": S.of(context).mostSelling,
        "key": "most_selling",
      },
      {
        "title": S.of(context).topSeller,
        "key": "top_seller",
      }
    ];

    return sortList;
  }
}
