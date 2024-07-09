import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:razinshop_rider/controllers/others_controller/others_controller.dart';

class TermsAndConditionsView extends ConsumerWidget {
  const TermsAndConditionsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(termsAndConditionsProvider).when(
          data: (data) {
            return Scaffold(
              appBar: AppBar(
                title: Text(data.data?.content?.title ?? ''),
                surfaceTintColor: Colors.white,
              ),
              body: Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(top: 10),
                color: Colors.white,
                child: SingleChildScrollView(
                  child: Html(
                    data: data.data?.content?.description ??
                        "<html> No Data </html>",
                  ),
                ),
              ),
            );
          },
          error: (error, stackTrace) => Center(
            child: Text('Error: $error'),
          ),
          loading: () => Center(
            child: CircularProgressIndicator(),
          ),
        );
  }
}
