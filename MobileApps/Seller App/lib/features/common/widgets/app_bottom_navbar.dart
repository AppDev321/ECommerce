import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:razin_commerce_seller_flutter/config/app_text_style.dart';
import 'package:razin_commerce_seller_flutter/config/theme.dart';
import 'package:razin_commerce_seller_flutter/features/common/screens/scaffold_with_nav_bar.dart';

class AppBottomNavbar extends ConsumerWidget {
  const AppBottomNavbar({
    super.key,
    required this.bottomItem,
    required this.onSelect,
  });
  final List<BottomItem> bottomItem;
  final Function(int? index) onSelect;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 72.h,
      padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 20.w),
      width: double.infinity,
      decoration: BoxDecoration(
        color: colors(context).light,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
          bottomItem.length,
          (index) {
            return GestureDetector(
              onTap: () {
                onSelect(index);
              },
              child: Container(
                color: Colors.transparent,
                child: _buildBottomItem(
                  bottomItem: bottomItem[index],
                  index: index,
                  context: context,
                  ref: ref,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildBottomItem({
    required BottomItem bottomItem,
    required int index,
    required BuildContext context,
    required WidgetRef ref,
  }) {
    int selectedIndex = ref.watch(selectedTabIndexProvider);

    final isSelected = index == selectedIndex;

    return TweenAnimationBuilder<double>(
      tween: Tween<double>(
          begin: isSelected ? 0.0 : 1.0, end: isSelected ? 1.0 : 0.0),
      duration: const Duration(milliseconds: 300),
      builder: (context, value, child) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
          decoration: isSelected
              ? BoxDecoration(
                  borderRadius: BorderRadius.circular(100.r),
                  color: colors(context).primaryColor!.withOpacity(0.1),
                )
              : null,
          height: 46.h,
          child: child,
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100.r),
                ),
                child: Row(
                  children: [
                    Center(
                      child: SvgPicture.asset(
                        colorFilter: isSelected
                            ? ColorFilter.mode(
                                colors(context).primaryColor!, BlendMode.srcIn)
                            : null,
                        isSelected ? bottomItem.activeIcon : bottomItem.icon,
                        height: isSelected ? 26 : 26.h,
                        width: isSelected ? 26 : 26.w,
                      ),
                    ),
                    if (isSelected)
                      TweenAnimationBuilder<double>(
                        tween: Tween<double>(begin: -5, end: 1),
                        duration: const Duration(milliseconds: 300),
                        builder: (context, value, child) {
                          return Transform.translate(
                            offset: Offset(value, 0),
                            child: Padding(
                              padding: EdgeInsets.only(left: 6.w),
                              child: Text(
                                bottomItem.name,
                                style: AppTextStyle.text14B400.copyWith(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                  color: isSelected
                                      ? colors(context).primaryColor
                                      : colors(context).bodyTextSmallColor,
                                ),
                              ),
                            ),
                          );
                        },
                      )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class BottomItem {
  final String icon;
  final String activeIcon;
  final String name;
  final String location;
  BottomItem({
    required this.icon,
    required this.activeIcon,
    required this.name,
    required this.location,
  });
}
