import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:razin_shop/config/app_text_style.dart';
import 'package:razin_shop/config/theme.dart';
import 'package:razin_shop/controllers/eCommerce/cart/cart_controller.dart';
import 'package:razin_shop/controllers/misc/misc_controller.dart';
import 'package:razin_shop/views/eCommerce/dashboard/layouts/dashboar_layout.dart';

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
      height: 80.h,
      padding: EdgeInsets.symmetric(vertical: 5.h),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
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
    final int selectedIndex = ref.watch(selectedTabIndexProvider);

    final isSelected = index == selectedIndex;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: isSelected
          ? BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              color: colors(context).primaryColor?.withOpacity(0.1))
          : null,
      width: isSelected ? 100.w : 80.w,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              Container(
                padding: EdgeInsets.zero,
                height: 42.h,
                width: 42.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    colorFilter: isSelected
                        ? ColorFilter.mode(
                            colors(context).primaryColor!, BlendMode.srcIn)
                        : null,
                    isSelected ? bottomItem.activeIcon : bottomItem.icon,
                    height: 26.h,
                    width: 26.w,
                  ),
                ),
              ),
              if (index == 1 && !isSelected) ...[
                Positioned(
                  top: 0,
                  right: 0,
                  child: Consumer(
                    builder: (context, ref, _) {
                      return ref.watch(cartController).cartItems.isNotEmpty
                          ? CircleAvatar(
                              radius: 7.r,
                              backgroundColor: colors(context).errorColor,
                              child: Center(
                                child: Text(
                                  ref
                                      .watch(cartController.notifier)
                                      .cartItems
                                      .length
                                      .toString(),
                                  style: AppTextStyle(context)
                                      .bodyTextSmall
                                      .copyWith(fontSize: 10)
                                      .copyWith(color: colors(context).light),
                                ),
                              ),
                            )
                          : const SizedBox();
                    },
                  ),
                )
              ]
            ],
          ),
          if (isSelected)
            TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: -5, end: 1),
              duration: const Duration(milliseconds: 300),
              builder: (context, value, child) {
                return Text(
                  bottomItem.name,
                  style: AppTextStyle(context).bodyTextSmall.copyWith(
                        fontWeight: FontWeight.w500,
                        color: isSelected
                            ? colors(context).primaryColor
                            : colors(context).bodyTextSmallColor,
                      ),
                );
              },
            )
        ],
      ),
    );
  }
}
