import 'package:flutter/material.dart';
import 'package:razin_shop/views/eCommerce/dashboard/layouts/dashboar_layout.dart';

class EcommerceDashboardView extends StatelessWidget {
  const EcommerceDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return const PopScope(
      canPop: false,
      child: EcommerceDashboardLayout(),
    );
  }
}
