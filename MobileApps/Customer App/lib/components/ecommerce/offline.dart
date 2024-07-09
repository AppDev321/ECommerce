import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:razin_shop/components/ecommerce/custom_button.dart';
import 'package:razin_shop/config/app_text_style.dart';
import 'package:razin_shop/gen/assets.gen.dart';
import 'package:razin_shop/generated/l10n.dart';

class OfflineScreen extends StatelessWidget {
  const OfflineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Assets.png.noInternetConnection.image(),
              const SizedBox(
                height: 40,
              ),
              Text(
                S.of(context).whoops,
                style: AppTextStyle(context).title,
              ),
              SizedBox(height: 20.h),
              Text(
                S.of(context).noInternetDes,
                style: AppTextStyle(context)
                    .bodyText
                    .copyWith(fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30.h),
              CustomButton(
                buttonText: S.of(context).checkInternetConnection,
                onPressed: () {
                  AppSettings.openAppSettings(type: AppSettingsType.wifi);
                },
              )
              // SizedBox(
              //   height: 50.h,
              //   child: AppButton(

              //     titleColor: colors(context).light,
              //     onTap: () async {

              //     },
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  final String noInternetDes =
      "No Internet connection was found. Check you connection or try again.";
}
