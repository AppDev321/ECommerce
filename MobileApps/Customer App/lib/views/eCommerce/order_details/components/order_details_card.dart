import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:razin_shop/config/app_color.dart';
import 'package:razin_shop/config/app_text_style.dart';
import 'package:razin_shop/config/theme.dart';
import 'package:razin_shop/controllers/common/master_controller.dart';
import 'package:razin_shop/generated/l10n.dart';
import 'package:razin_shop/models/eCommerce/order/order_details_model.dart';
import 'package:razin_shop/utils/context_less_navigation.dart';
import 'package:razin_shop/utils/global_function.dart';

class OrderDetailsCard extends ConsumerWidget {
  final OrderDetails orderDetails;
  const OrderDetailsCard({
    Key? key,
    required this.orderDetails,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: EcommerceAppColor.white,
      padding: EdgeInsets.symmetric(
        horizontal: 20.w,
        vertical: 20.h,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _buildRowWidget(
            context: context,
            key: S.of(context).orderStatus,
            value: orderDetails.data.order.orderStatus,
            isOrderStatus: true,
          ),
          Gap(14.h),
          _buildRowWidget(
            context: context,
            key: S.of(context).orderId,
            value: orderDetails.data.order.orderCode,
          ),
          Gap(14.h),
          _buildRowWidget(
            context: context,
            key: S.of(context).orderDate,
            value: DateFormat('d MMMM y', 'en_US')
                .format(DateTime.parse(orderDetails.data.order.createdAt)),
          ),
          Gap(14.h),
          _buildPaymentMethodRow(),
          Gap(14.h),
          _buildRowWidget(
            context: context,
            key: S.of(context).totalAmount,
            value: GlobalFunction.price(
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
              price: orderDetails.data.order.payableAmount.toString(),
            ),
            isAmount: false,
          ),
          Gap(14.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(''),
              GestureDetector(
                onTap: () => _downloadFile(),
                child: Row(
                  children: [
                    Icon(
                      Icons.cloud_download,
                      color: EcommerceAppColor.gray,
                      size: 18.sp,
                    ),
                    Gap(5.w),
                    Text(
                      S.of(context).downloadInvoice,
                      style: AppTextStyle(context).bodyTextSmall.copyWith(
                          fontSize: 12.sp, color: colors(context).primaryColor),
                    )
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildRowWidget({
    required BuildContext context,
    required String key,
    required dynamic value,
    bool isAmount = false,
    bool isOrderStatus = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          key,
          style: AppTextStyle(context).bodyTextSmall,
        ),
        if (isOrderStatus) ...[
          GlobalFunction.getStatusWidget(context: context, status: value)
        ] else ...[
          Consumer(builder: (context, ref, _) {
            return Text(
              isAmount
                  ? '${ref.read(masterControllerProvider.notifier).materModel.data.currency.symbol}$value'
                  : value.toString(),
              style: AppTextStyle(context).bodyText,
            );
          }),
        ]
      ],
    );
  }

  Widget _buildPaymentMethodRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          S.of(ContextLess.context).paymentMethod,
          style: AppTextStyle(ContextLess.context).bodyTextSmall,
        ),
        if (orderDetails.data.order.paymentMethod == 'Cash Payment') ...[
          Text(
            orderDetails.data.order.paymentMethod,
            style: AppTextStyle(ContextLess.context).bodyText,
          ),
        ] else
          Row(
            children: [
              Text(
                orderDetails.data.order.paymentMethod,
                style: AppTextStyle(ContextLess.context).bodyText,
              ),
              Gap(4.w),
              _buildPaymentStatusWidget(),
            ],
          ),
      ],
    );
  }

  Widget _buildPaymentStatusWidget() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: orderDetails.data.order.paymentStatus == 'Pending'
            ? EcommerceAppColor.carrotOrange
            : EcommerceAppColor.green,
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: Center(
        child: Text(
          orderDetails.data.order.paymentStatus.toUpperCase()[0] +
              orderDetails.data.order.paymentStatus.substring(1),
          style: AppTextStyle(ContextLess.context)
              .bodyText
              .copyWith(fontSize: 12.sp, color: EcommerceAppColor.white),
        ),
      ),
    );
  }

  Future<String> _getDownloadDirectory() async {
    Directory? appDocDir;

    if (Platform.isAndroid) {
      appDocDir = await getExternalStorageDirectory();
    } else if (Platform.isIOS) {
      appDocDir = await getApplicationDocumentsDirectory();
    } else {
      throw UnsupportedError('Unsupported platform');
    }

    if (Platform.isAndroid) {
      return '/storage/emulated/0/download';
    } else {
      return appDocDir!.path;
    }
  }

  void _downloadFile() async {
    String saveDir = await _getDownloadDirectory();
    String fileName = 'invoice-${orderDetails.data.order.orderCode}.pdf';
    String? filePath = await _checkFileExists(saveDir, fileName);
    if (filePath != null) {
      debugPrint('File already exists at download folder!');
      GlobalFunction.showCustomSnackbar(
        message: 'File already exists at download folder!',
        isSuccess: false,
      );
    } else {
      FlutterDownloader.enqueue(
        url: orderDetails.data.order.invoiceUrl!,
        savedDir: saveDir,
        fileName: fileName,
        showNotification: true,
        openFileFromNotification: true,
      );
    }
  }

  Future<String?> _checkFileExists(String saveDir, String fileName) async {
    String filePath = '$saveDir/$fileName';
    File file = File(filePath);
    if (await file.exists()) {
      return filePath;
    } else {
      return null;
    }
  }
}
