import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:razin_shop/config/app_color.dart';
import 'package:razin_shop/config/app_text_style.dart';
import 'package:razin_shop/config/theme.dart';
import 'package:razin_shop/controllers/common/master_controller.dart';
import 'package:razin_shop/generated/l10n.dart';
import 'package:razin_shop/models/eCommerce/order/order_details_model.dart';
import 'package:razin_shop/utils/global_function.dart';
import 'package:razin_shop/views/eCommerce/order_details/components/product_review_dialog.dart';
import 'package:tuple/tuple.dart';

class OrderProductCard extends StatefulWidget {
  final Products product;
  final String orderStatus;
  final int orderId;
  final int index;

  const OrderProductCard({
    Key? key,
    required this.orderId,
    required this.product,
    required this.index,
    required this.orderStatus,
  }) : super(key: key);

  @override
  State<OrderProductCard> createState() => _OrderProductCardState();
}

class _OrderProductCardState extends State<OrderProductCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 5.h, left: 20.w, right: 20.w),
      child: Material(
        color: colors(context).light,
        child: Container(
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(
                color: EcommerceAppColor.offWhite,
                width: 2.0,
              ),
            ),
          ),
          padding: EdgeInsets.symmetric(vertical: 12.h).copyWith(bottom: 0.h),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildProductImage(
                    productImage: widget.product.thumbnail,
                  ),
                  Gap(16.w),
                  _buildProductInfo(
                    context: context,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductImage({required String productImage}) {
    return Flexible(
      flex: 1,
      child: Container(
        width: 70.w,
        height: 60.h,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: CachedNetworkImageProvider(
              productImage,
              errorListener: (error) => debugPrint(error.toString()),
            ),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildProductInfo({
    required BuildContext context,
  }) {
    return Flexible(
      flex: 5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  widget.product.name,
                  style: AppTextStyle(context)
                      .bodyText
                      .copyWith(fontWeight: FontWeight.w500),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          Gap(10.h),
          _buildProductBottomRow(
            context: context,
          ),
          Gap(10.h),
          _buildProductBottomRow1()
        ],
      ),
    );
  }

  Widget _buildProductBottomRow({
    required BuildContext context,
  }) {
    return Consumer(builder: (context, ref, _) {
      return Row(
        children: [
          Text(
            "${widget.product.orderQty} x  ${GlobalFunction.price(
              currency: ref
                  .read(masterControllerProvider.notifier)
                  .materModel
                  .data
                  .currency
                  .symbol,
              position: ref
                  .read(masterControllerProvider.notifier)
                  .materModel
                  .data
                  .currency
                  .position,
              price: widget.product.discountPrice != 0
                  ? widget.product.discountPrice.toString()
                  : widget.product.price.toString(),
            )} ",
            style: AppTextStyle(context).subTitle.copyWith(
                color: colors(context).primaryColor,
                fontSize: widget.product.discountPrice != 0 &&
                        widget.orderStatus.toLowerCase() == 'delivered'
                    ? 14.sp
                    : 18.sp),
          ),
          if (widget.product.discountPrice != 0) ...[
            Gap(2.w),
            Text(
              GlobalFunction.price(
                  currency: ref
                      .read(masterControllerProvider.notifier)
                      .materModel
                      .data
                      .currency
                      .symbol,
                  position: ref
                      .read(masterControllerProvider.notifier)
                      .materModel
                      .data
                      .currency
                      .position,
                  price: widget.product.price.toString()),
              style: AppTextStyle(context).bodyText.copyWith(
                    color: EcommerceAppColor.lightGray,
                    decoration: TextDecoration.lineThrough,
                    decorationColor: EcommerceAppColor.lightGray,
                  ),
            ),
          ],
        ],
      );
    });
  }

  Widget _buildProductBottomRow1() {
    return Row(
      children: [
        Row(
          children: [
            Visibility(
              visible: widget.product.color != null,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 5.w,
                  vertical: 3.h,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  color: EcommerceAppColor.offWhite,
                ),
                child: Center(
                  child: Text(
                    widget.product.color != null
                        ? capitalize(widget.product.color!)
                        : '',
                    style: AppTextStyle(context).bodyTextSmall.copyWith(
                          color: EcommerceAppColor.black,
                        ),
                  ),
                ),
              ),
            ),
            Visibility(
              visible:
                  widget.product.color != null && widget.product.size != null,
              child: Gap(8.w),
            ),
            Visibility(
              visible: widget.product.size != null,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 5.w,
                  vertical: 3.h,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  color: EcommerceAppColor.offWhite,
                ),
                child: Center(
                  child: Text(
                    widget.product.size != null
                        ? capitalize(widget.product.size!)
                        : '',
                    style: AppTextStyle(context).bodyTextSmall.copyWith(
                          color: EcommerceAppColor.black,
                        ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const Spacer(),
        if (widget.orderStatus.toLowerCase() == 'delivered') ...[
          if (widget.product.rating != null) ...[
            _buildRatingBar(),
          ] else ...[
            _buildReviewButton(context: context),
          ]
        ]
      ],
    );
  }

  Widget _buildReviewButton({
    required BuildContext context,
  }) {
    return Material(
      color: EcommerceAppColor.carrotOrange,
      borderRadius: BorderRadius.circular(3.r),
      child: InkWell(
        borderRadius: BorderRadius.circular(3.r),
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => ProductReviewDialog(
              arugument: Tuple2(widget.orderId, widget.product.id),
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3.r),
          ),
          child: Text(
            S.of(context).review,
            style: AppTextStyle(context)
                .bodyTextSmall
                .copyWith(color: EcommerceAppColor.white),
          ),
        ),
      ),
    );
  }

  Widget _buildRatingBar() {
    return RatingBar.builder(
      ignoreGestures: true,
      tapOnlyMode: false,
      itemSize: 18.sp,
      initialRating: widget.product.rating ?? 0,
      minRating: 1,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      unratedColor: EcommerceAppColor.offWhite,
      itemBuilder: (context, _) => Icon(
        Icons.star_rounded,
        size: 16.sp,
        color: EcommerceAppColor.carrotOrange,
      ),
      onRatingUpdate: (rating) => debugPrint(rating.toString()),
    );
  }

  String capitalize(String s) =>
      s[0].toUpperCase() + s.substring(1).toLowerCase();
}
