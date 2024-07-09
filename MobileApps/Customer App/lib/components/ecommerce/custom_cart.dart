import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:razin_shop/config/app_constants.dart';
import 'package:razin_shop/config/app_text_style.dart';
import 'package:razin_shop/config/theme.dart';
import 'package:razin_shop/controllers/eCommerce/cart/cart_controller.dart';
import 'package:razin_shop/gen/assets.gen.dart';
import 'package:razin_shop/routes.dart';
import 'package:razin_shop/utils/context_less_navigation.dart';

class CustomCartWidget extends StatelessWidget {
  const CustomCartWidget({
    super.key,
    required this.context,
  });

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            context.nav.pushNamed(
              Routes.getMyCartViewRouteName(AppConstants.appServiceName),
              arguments: false,
            );
          },
          child: CircleAvatar(
            radius: 24.r,
            backgroundColor: colors(context).accentColor?.withOpacity(0.2),
            child: SvgPicture.asset(
              Assets.svg.cart,
              width: 24.sp,
              colorFilter: ColorFilter.mode(
                  colors(context).primaryColor!, BlendMode.srcIn),
            ),
          ),
        ),
        Positioned(
          right: 5.w,
          top: 5.h,
          child: Consumer(builder: (context, ref, _) {
            return ref.watch(cartController).cartItems.isNotEmpty
                ? CircleAvatar(
                    radius: 8.r,
                    backgroundColor: colors(context).errorColor,
                    child: Center(
                      child: Text(
                        ref.watch(cartController).cartItems.length.toString(),
                        style: AppTextStyle(context).bodyTextSmall.copyWith(
                            color: colors(context).light, fontSize: 10.sp),
                      ),
                    ),
                  )
                : const SizedBox();
          }),
        )
      ],
    );
  }
}
