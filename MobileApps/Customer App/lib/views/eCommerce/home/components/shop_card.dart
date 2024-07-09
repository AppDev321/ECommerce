// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:razin_shop/config/theme.dart';
import 'package:razin_shop/models/eCommerce/shop/shop.dart';

class ShopCardCircle extends StatelessWidget {
  final Shop shop;
  final VoidCallback callback;
  const ShopCardCircle({
    Key? key,
    required this.shop,
    required this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: const CircleBorder(),
      child: InkWell(
        onTap: callback,
        borderRadius: BorderRadius.circular(100.r),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: colors(context).accentColor!, width: 2),
            shape: BoxShape.circle,
            image: DecorationImage(
              image: CachedNetworkImageProvider(shop.logo),
            ),
          ),
          height: 88.h,
          width: 88.w,
        ),
      ),
    );
  }
}
