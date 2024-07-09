// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:razin_shop/config/app_text_style.dart';
import 'package:razin_shop/config/theme.dart';
import 'package:razin_shop/models/eCommerce/category/category.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
    required this.category,
    this.onTap,
  }) : super(key: key);

  final Category category;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 78.h,
          decoration: BoxDecoration(
              color: colors(context).light,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: colors(context).accentColor!)),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.w),
                height: 70.h,
                width: 70.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(category.thumbnail),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: Text(
                  category.name,
                  overflow: TextOverflow.ellipsis,
                  style:
                      AppTextStyle(context).bodyText.copyWith(fontSize: 14.sp),
                ),
              ),
              Gap(4.w)
            ],
          ),
        ),
      ),
    );
  }
}
