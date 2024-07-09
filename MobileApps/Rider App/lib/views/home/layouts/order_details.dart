// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:razinshop_rider/config/app_constants.dart';
import 'package:razinshop_rider/controllers/auth_controller/auth_controller.dart';
import 'package:razinshop_rider/controllers/misc/providers.dart';
import 'package:razinshop_rider/generated/l10n.dart';
import 'package:razinshop_rider/utils/global_function.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;
import 'package:razinshop_rider/config/app_color.dart';
import 'package:razinshop_rider/config/app_text.dart';
import 'package:razinshop_rider/controllers/order_controller/order_controller.dart';
import 'package:razinshop_rider/gen/assets.gen.dart';
import 'package:razinshop_rider/models/order_details_model/order_details_model.dart';
import 'package:razinshop_rider/views/home/components/cash_collect_dialog.dart';
import 'package:razinshop_rider/views/home/components/google_map.dart';

class OrderDetailsView extends ConsumerWidget {
  const OrderDetailsView({
    super.key,
    required this.orderID,
  });
  final int orderID;
  final double customerLatitude = 23.7686089;
  final double customerLongitude = 90.3547867;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(orderDetailsProvider(orderID)).when(
          data: (data) {
            return Scaffold(
              appBar: AppBar(
                surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
                title: Text(
                  S.of(context).orderDetails,
                  style: AppTextStyle.largeBody,
                ),
                toolbarHeight: 70.h,
                actions: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 22.h)
                        .copyWith(right: 20.w),
                    child: PaymentStatusCard(
                      orderStatus: data.data?.order?.orderStatus ?? '',
                    ),
                  )
                ],
              ),
              body: ListView(
                children: [
                  Gap(8.h),
                  _OrderInfor(orderDetailsModel: data),
                  Gap(10.h),
                  _ShippingInfo(orderDetailsModel: data),
                ],
              ),
              bottomNavigationBar: BottomSection(orderDetailsModel: data),
            );
          },
          loading: () => Center(
            child: CircularProgressIndicator(),
          ),
          error: (error, stackTrace) => Center(
            child: Text('Error: $error'),
          ),
        );
  }
}

class BottomSection extends ConsumerStatefulWidget {
  final OrderDetailsModel orderDetailsModel;
  BottomSection({
    required this.orderDetailsModel,
  });
  @override
  ConsumerState<BottomSection> createState() => _BottomSectionState();
}

class _BottomSectionState extends ConsumerState<BottomSection> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (widget.orderDetailsModel.data!.order!.orderStatus == 'Delivered' &&
          widget.orderDetailsModel.data!.order!.paymentStatus == 'Pending') {
        ref.read(slideButtonLeftPosition.notifier).state = 328.w - 48.r;
        ref.read(slideButtonComplete.notifier).state = true;
        showModalBottomSheet(
          context: context,
          isDismissible: false,
          enableDrag: false,
          builder: (context) {
            return CashCollectDialog(
              amount: widget.orderDetailsModel.data!.order!.amount.toString(),
              orderId: widget.orderDetailsModel.data!.order!.id!,
            );
          },
        );
      }
    });
  }

  Future<void> successStatus(String status) async {
    await Future.delayed(const Duration(milliseconds: 500));
    ref.read(buttonText.notifier).state = "responseSuccess";
    await Future.delayed(const Duration(milliseconds: 1000));
    ref.read(buttonText.notifier).state = status;
    ref.read(slideButtonLeftPosition.notifier).state = 0.0;
    ref.read(slideButtonComplete.notifier).state = false;
  }

  Future<void> slideStatusUpdate(
      {required String status, required String paymentStatus}) async {
    if (status == 'Delivered' && paymentStatus == 'Pending') {
      ref.read(slideButtonLeftPosition.notifier).state = 328.w - 48.r;
      ref.read(slideButtonComplete.notifier).state = true;
      showModalBottomSheet(
        context: context,
        isDismissible: false,
        enableDrag: false,
        builder: (context) {
          return CashCollectDialog(
            amount: widget.orderDetailsModel.data!.order!.amount.toString(),
            orderId: widget.orderDetailsModel.data!.order!.id!,
          );
        },
      );
    } else if (status == 'Delivered') {
      await successStatus(status);
      ref.read(userDetilsProvider.notifier).build();
      ref.read(slideButtonLeftPosition.notifier).state = 328.w - 48.r;
      ref.read(slideButtonComplete.notifier).state = true;
    } else {
      await successStatus(status);
    }
    ref.invalidate(
        orderDetailsProvider(widget.orderDetailsModel.data!.order!.id!));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85.h,
      padding: const EdgeInsets.all(16).r,
      decoration: BoxDecoration(color: Colors.white),
      child: Container(
        width: 328.w,
        height: 54.h,
        padding: EdgeInsets.symmetric(horizontal: 4.r, vertical: 3.r),
        decoration: ShapeDecoration(
          color:
              GlobalFunction.sliderButtonStatus(ref.watch(buttonText), context)
                  .buttonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(54),
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
              opacity: 1,
              child: Text(
                GlobalFunction.sliderButtonStatus(
                        ref.watch(buttonText), context)
                    .buttonText,
                textAlign: TextAlign.center,
                style: AppTextStyle.normalBody.copyWith(
                  color: GlobalFunction.sliderButtonStatus(
                          ref.watch(buttonText), context)
                      .textColor,
                  fontWeight: FontWeight.w700,
                ),
              )
                  .animate(
                    delay: 950.ms,
                    onPlay: (controller) => controller.repeat(),
                  )
                  .shimmer(
                    duration: 1.seconds,
                    delay: 1.seconds,
                    color: Colors.white,
                  ),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              left: ref.watch(slideButtonLeftPosition),
              top: 0,
              child: GestureDetector(
                onHorizontalDragUpdate: ref.watch(slideButtonComplete)
                    ? null
                    : (details) {
                        ref.read(slideButtonLeftPosition.notifier).state +=
                            details.delta.dx;
                        ref.read(slideButtonLeftPosition.notifier).state = ref
                            .read(slideButtonLeftPosition.notifier)
                            .state
                            .clamp(0.0, 328.w - 48.r);
                      },
                onHorizontalDragEnd: ref.watch(slideButtonComplete)
                    ? null
                    : (details) async {
                        if (ref.read(slideButtonLeftPosition) > (328.w) / 2) {
                          ref.read(slideButtonLeftPosition.notifier).state =
                              328.w - 40.r;
                          ref.read(slideButtonComplete.notifier).state = true;

                          if (ref.read(slideButtonComplete)) {
                            await ref
                                .read(orderStatusUpdateProvider.notifier)
                                .updateOrderStatus(
                                    widget.orderDetailsModel.data!.order!.id!)
                                .then((value) async {
                              return await slideStatusUpdate(
                                status: value.data?.order?.orderStatus ?? '',
                                paymentStatus:
                                    value.data?.order?.paymentStatus ?? '',
                              );
                            });
                          }
                        }
                      },
                child: Consumer(
                  builder: (context, ref, child) {
                    final statusLoading = ref.watch(orderStatusUpdateProvider);
                    return Container(
                      height: 48.r,
                      width: 48.r,
                      padding: EdgeInsets.all(10.r),
                      decoration: BoxDecoration(
                        color: AppColor.whiteColor,
                        shape: BoxShape.circle,
                      ),
                      child: statusLoading
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : GlobalFunction.slideButtonIcon(
                                  ref.watch(buttonText))
                              .animate(
                                onPlay: (controller) => controller.repeat(),
                              )
                              .shimmer(
                                duration: 1.5.seconds,
                                delay: 1.seconds,
                                color: Colors.white,
                              ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ShippingInfo extends ConsumerWidget {
  const _ShippingInfo({required this.orderDetailsModel});
  final OrderDetailsModel orderDetailsModel;
  final double customerLatitude = 23.7686089;
  final double customerLongitude = 90.3547867;

  void launchDirections() async {
    final String googleMapsUrl =
        'https://www.google.com/maps/dir/?api=1&destination=$customerLatitude,$customerLongitude';
    final String appleMapUrl =
        'https://maps.apple.com/?daddr=$customerLatitude,$customerLongitude';
    if (Platform.isIOS) {
      url_launcher.launchUrl(Uri.parse(appleMapUrl));
    } else if (Platform.isAndroid) {
      url_launcher.launchUrl(Uri.parse(googleMapsUrl));
    } else {
      throw 'Unsupported platform';
    }
  }

  bool shopMapVisibility(status) {
    if (status == 'Confirm' || status == 'Processing') {
      return true;
    } else {
      return false;
    }
  }

  bool userMapVisibility(status) {
    if (status == 'On The Way' || status == 'Delivered') {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final status = orderDetailsModel.data?.order?.orderStatus ?? '';
    return Container(
      padding: const EdgeInsets.all(16).r,
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.of(context).shippingInfo,
            style: AppTextStyle.normalBody.copyWith(
              color: Color(0xFF05161B),
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          Gap(8.h),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IntrinsicHeight(
                child: Row(
                  children: [
                    Column(
                      children: [
                        SvgPicture.asset(
                          Assets.svgs.box,
                          height: 20.r,
                          width: 20.r,
                        ),
                        Expanded(
                          child: DottedVerticalLine(),
                        )
                      ],
                    ),
                    Gap(4.w),
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 10.r),
                            padding: EdgeInsets.all(10.r),
                            decoration: shopMapVisibility(status)
                                ? ShapeDecoration(
                                    color: Color(0xFFF7F7F7),
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        color: AppColor.primaryColor,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(8).r,
                                    ),
                                  )
                                : null,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      height: 36.r,
                                      width: 36.r,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.grey,
                                      ),
                                      child: CachedNetworkImage(
                                        imageUrl: orderDetailsModel
                                                .data?.order?.shop?.logo ??
                                            '',
                                        placeholder: (context, url) =>
                                            CircularProgressIndicator(),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Gap(8.w),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            S.of(context).pickup,
                                            style: TextStyle(
                                              color: Color(0xFF617885),
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                orderDetailsModel.data?.order
                                                        ?.shop?.name ??
                                                    '',
                                                style: TextStyle(
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                              Gap(5.w),
                                              Text(
                                                orderDetailsModel.data?.order
                                                        ?.shop?.phone ??
                                                    '',
                                                style: TextStyle(
                                                  color: Color(0xFF617885),
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        url_launcher.launchUrl(
                                          Uri.parse(
                                            'tel:${orderDetailsModel.data?.order?.shop?.phone}',
                                          ),
                                        );
                                      },
                                      child: shopMapVisibility(status)
                                          ? Container(
                                              height: 40.r,
                                              width: 40.r,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: AppColor.primaryColor,
                                              ),
                                              child: Center(
                                                child: SvgPicture.asset(
                                                    Assets.svgs.phone),
                                              ),
                                            )
                                          : Text(
                                              S.of(context).call,
                                              style: TextStyle(
                                                color: AppColor.primaryColor,
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w400,
                                                decoration:
                                                    TextDecoration.underline,
                                              ),
                                            ),
                                    ),
                                  ],
                                ),
                                Gap(10.h),
                                Text(
                                  orderDetailsModel
                                          .data?.order?.shop?.address ??
                                      '',
                                  style: AppTextStyle.normalBody.copyWith(
                                    color: Color(0xFF05161B),
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Gap(10.h),
                                // first map
                                Visibility(
                                  visible: shopMapVisibility(status),
                                  child: Stack(
                                    children: [
                                      Container(
                                        height: 140.h,
                                        decoration: BoxDecoration(
                                          color: AppColor.whiteColor,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          child: GoogleMapView(
                                            latitude: customerLatitude,
                                            longitude: customerLongitude,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 8.h,
                                        right: 12.w,
                                        child: Material(
                                          color: AppColor.whiteColor,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: InkWell(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            onTap: launchDirections,
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10.w,
                                                  vertical: 8.h),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                color: AppColor.primaryColor,
                                              ),
                                              child: Row(
                                                children: [
                                                  SvgPicture.asset(
                                                      Assets.svgs.direction),
                                                  Gap(5.w),
                                                  Text(
                                                    S.of(context).getDirection,
                                                    style: AppTextStyle
                                                        .smallBody
                                                        .copyWith(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color:
                                                          AppColor.whiteColor,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Gap(20.r),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    Assets.svgs.pin,
                    height: 20.r,
                    width: 20.r,
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 12.r),
                      // margin: EdgeInsets.only(left: 10.r),
                      padding: EdgeInsets.all(10.r),
                      decoration: userMapVisibility(status)
                          ? ShapeDecoration(
                              color: Color(0xFFF7F7F7),
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  color: AppColor.primaryColor,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(8).r,
                              ),
                            )
                          : null,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            S.of(context).dropOff,
                            style: TextStyle(
                              color: Color(0xFF617885),
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Text(
                                      orderDetailsModel
                                              .data?.order?.user?.name ??
                                          '',
                                      style: TextStyle(
                                        color: Color(0xFF05161B),
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Gap(6.w),
                                    Text(
                                      orderDetailsModel
                                              .data?.order?.user?.phone ??
                                          '',
                                      style: TextStyle(
                                        color: Color(0xFF617885),
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  url_launcher.launchUrl(
                                    Uri.parse(
                                      'tel:${orderDetailsModel.data?.order?.user?.phone}',
                                    ),
                                  );
                                },
                                child: userMapVisibility(status)
                                    ? Container(
                                        height: 40.r,
                                        width: 40.r,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppColor.primaryColor,
                                        ),
                                        child: Center(
                                          child: SvgPicture.asset(
                                              Assets.svgs.phone),
                                        ),
                                      )
                                    : Text(
                                        S.of(context).call,
                                        style: TextStyle(
                                          color: AppColor.primaryColor,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w400,
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                              ),
                            ],
                          ),
                          Text(
                            orderDetailsModel
                                    .data?.order?.user?.address?.addressLine ??
                                '',
                            style: TextStyle(
                              color: Color(0xFF617885),
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Gap(10.h),
                          // second map
                          Visibility(
                            visible: userMapVisibility(status),
                            child: Stack(
                              children: [
                                Container(
                                  height: 140.h,
                                  decoration: BoxDecoration(
                                    color: AppColor.whiteColor,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: GoogleMapView(
                                      latitude: customerLatitude,
                                      longitude: customerLongitude,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 8.h,
                                  right: 12.w,
                                  child: Material(
                                    color: AppColor.whiteColor,
                                    borderRadius: BorderRadius.circular(8),
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(8),
                                      onTap: launchDirections,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.w, vertical: 8.h),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: AppColor.primaryColor,
                                        ),
                                        child: Row(
                                          children: [
                                            SvgPicture.asset(
                                                Assets.svgs.direction),
                                            Gap(5.w),
                                            Text(
                                              S.of(context).getDirection,
                                              style: AppTextStyle.smallBody
                                                  .copyWith(
                                                fontWeight: FontWeight.bold,
                                                color: AppColor.whiteColor,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _OrderInfor extends StatelessWidget {
  const _OrderInfor({
    required this.orderDetailsModel,
  });

  final OrderDetailsModel orderDetailsModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16).r,
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                S.of(context).orderID,
                textAlign: TextAlign.center,
                style: AppTextStyle.largeBody.copyWith(
                  color: Color(0xFF969899),
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                orderDetailsModel.data!.order!.orderCode ?? '',
                textAlign: TextAlign.center,
                style: AppTextStyle.largeBody.copyWith(
                  color: Color(0xFF05161B),
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                ),
              )
            ],
          ),
          Gap(16.r),
          Container(
            padding: const EdgeInsets.all(12).r,
            decoration: ShapeDecoration(
              color: Color(0xFFF7F7F7),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6).r,
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        orderDetailsModel.data?.order?.paymentStatus == "Paid"
                            ? S.of(context).paid
                            : S.of(context).cashCollection,
                        style: AppTextStyle.normalBody.copyWith(
                          color: Color(0xFF617885),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Expanded(
                      child: ValueListenableBuilder(
                          valueListenable: Hive.box(AppConstants.appSettingsBox)
                              .listenable(),
                          builder: (context, box, child) {
                            return Text(
                              '${box.get(AppConstants.currency) ?? "\$"}${orderDetailsModel.data!.order!.amount ?? ''}',
                              textAlign: TextAlign.right,
                              style: AppTextStyle.normalBody.copyWith(
                                color: Color(0xFF05161B),
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            );
                          }),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        S.of(context).deliveryBetween,
                        style: AppTextStyle.normalBody.copyWith(
                          color: Color(0xFF617885),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        '${orderDetailsModel.data!.order!.estimatedDeliveryDate ?? ''}',
                        textAlign: TextAlign.right,
                        style: AppTextStyle.normalBody.copyWith(
                          color: Color(0xFF05161B),
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class PaymentStatusCard extends StatelessWidget {
  final String orderStatus;
  const PaymentStatusCard({
    Key? key,
    required this.orderStatus,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2).r,
      decoration: BoxDecoration(
        color: GlobalFunction.orderStatusText(orderStatus, context).bgColor,
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Center(
        child: Text(
          GlobalFunction.orderStatusText(orderStatus, context).text,
          // orderStatus,
          style: AppTextStyle.smallBody.copyWith(
            color: AppColor.whiteColor,
            fontSize: 12.sp,
          ),
        ),
      ),
    );
  }

  // String localize(BuildContext context, String paymentText) {
  //   return switch (paymentText) {
  //     "Pending" => S.of(context).pending,
  //     "Paid" => S.of(context).paid,
  //     _ => S.of(context).unknown,
  //   };
  // }
}

class DottedVerticalLine extends StatelessWidget {
  final Color color;

  DottedVerticalLine({this.color = Colors.grey});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: DottedVerticalLinePainter(color: color),
      child: SizedBox(width: 2),
    );
  }
}

class DottedVerticalLinePainter extends CustomPainter {
  final Paint dottedPaint;

  DottedVerticalLinePainter({Color color = Colors.black})
      : dottedPaint = Paint()
          ..color = color
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.0
          ..strokeCap = StrokeCap.round;

  @override
  void paint(Canvas canvas, Size size) {
    final double dashWidth = 5;
    final double dashSpace = 5;
    double startY = 0;
    while (startY < size.height) {
      canvas.drawLine(
          Offset(size.width / 2, startY),
          Offset(
              size.width / 2,
              startY + dashWidth < size.height
                  ? startY + dashWidth
                  : size.height),
          dottedPaint);
      startY += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
