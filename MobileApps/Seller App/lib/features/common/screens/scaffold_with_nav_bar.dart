import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:razin_commerce_seller_flutter/config/routes.dart';
import 'package:razin_commerce_seller_flutter/features/common/widgets/app_bottom_navbar.dart';
import 'package:razin_commerce_seller_flutter/gen/assets.gen.dart';

class ScaffoldWithNavBar extends ConsumerStatefulWidget {
  final String location;
  final Widget child;
  const ScaffoldWithNavBar({
    super.key,
    required this.location,
    required this.child,
  });

  @override
  ConsumerState<ScaffoldWithNavBar> createState() => _ScaffoldWithNavBarState();
}

class _ScaffoldWithNavBarState extends ConsumerState<ScaffoldWithNavBar> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: widget.child),
      bottomNavigationBar: AppBottomNavbar(
        bottomItem: getBottomItems(context: context),
        onSelect: (index) {
          _goOtherTab(context, index!);
          ref.read(selectedTabIndexProvider.notifier).state = index;
        },
      ),
    );
  }

  void _goOtherTab(BuildContext context, int index) {
    if (index == _currentIndex) return;
    GoRouter router = GoRouter.of(context);
    String location = getBottomItems(context: context)[index].location;

    setState(() {
      _currentIndex = index;
    });
    router.go(location);
  }
}

List<BottomItem> getBottomItems({required BuildContext context}) {
  return [
    BottomItem(
      icon: Assets.svg.home,
      activeIcon: Assets.svg.activeDashboard,
      name: 'Dashboard',
      location: Routes.dashboard,
    ),
    BottomItem(
      icon: Assets.svg.bag,
      activeIcon: Assets.svg.activeBag,
      name: 'Orders',
      location: Routes.orders,
    ),
    BottomItem(
      icon: Assets.svg.wallet,
      activeIcon: Assets.svg.activeWallet,
      name: 'Wallet',
      location: Routes.wallet,
    ),
    BottomItem(
      icon: Assets.svg.profile,
      activeIcon: Assets.svg.activeProfile,
      name: 'Profile',
      location: Routes.profile,
    ),
  ];
}

final selectedTabIndexProvider = StateProvider<int>((ref) => 0);
