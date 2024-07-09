// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:razin_shop/config/app_constants.dart';
import 'package:razin_shop/config/app_text_style.dart';
import 'package:razin_shop/generated/l10n.dart';
import 'package:razin_shop/models/eCommerce/product/product_details.dart';
import 'package:razin_shop/routes.dart';
import 'package:razin_shop/utils/context_less_navigation.dart';
import 'package:razin_shop/views/eCommerce/home/components/popular_product_card.dart';

class SimilarProductsWidget extends StatelessWidget {
  final ProductDetails productDetails;
  const SimilarProductsWidget({
    Key? key,
    required this.productDetails,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 20.w),
            child: Text(
              S.of(context).similarProducts,
              style: AppTextStyle(context).subTitle,
            ),
          ),
          Gap(14.h),
          SizedBox(
            height: 300.h,
            child: ListView.builder(
              padding: EdgeInsets.only(left: 20.w),
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: productDetails.relatedProducts.length,
              itemBuilder: ((context, index) {
                final product = productDetails.relatedProducts[index];
                return PopularProductCard(
                  product: product,
                  onTap: () {
                    context.nav.popAndPushNamed(
                      Routes.getProductDetailsRouteName(
                          AppConstants.appServiceName),
                      arguments: product.id,
                    );
                  },
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
