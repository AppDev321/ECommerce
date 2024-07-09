import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:razin_shop/controllers/common/other_controller.dart';
import 'package:razin_shop/generated/l10n.dart';

class TermsAndConditionLayout extends ConsumerWidget {
  const TermsAndConditionLayout({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).termsCondistions),
      ),
      body: ref.watch(termsAndConditionsControllerProvider).when(
            data: (data) => SingleChildScrollView(
              child: Column(
                children: [
                  Html(data: data.data.content.description),
                ],
              ),
            ),
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
