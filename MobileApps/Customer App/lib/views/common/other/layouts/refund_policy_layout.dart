import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:razin_shop/controllers/common/other_controller.dart';
import 'package:razin_shop/generated/l10n.dart';

class RefundPolicyLayout extends ConsumerWidget {
  const RefundPolicyLayout({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).refundPolicy),
      ),
      body: ref.watch(refundPolicyControllerProvider).when(
            data: (data) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Html(data: data.data.content.description),
                    ],
                  ),
                ),
              );
            },
            error: (error, s) => Center(
              child: Text(error.toString()),
            ),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
          ),
    );
  }
}
