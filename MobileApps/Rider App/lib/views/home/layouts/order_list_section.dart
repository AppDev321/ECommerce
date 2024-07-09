import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:razinshop_rider/config/app_color.dart';
import 'package:razinshop_rider/config/app_text.dart';
import 'package:razinshop_rider/controllers/order_controller/order_controller.dart';
import 'package:razinshop_rider/views/home/components/order_card.dart';

class OrderListSection extends ConsumerStatefulWidget {
  const OrderListSection({super.key});

  @override
  ConsumerState<OrderListSection> createState() => _OrderListSectionState();
}

class _OrderListSectionState extends ConsumerState<OrderListSection> {
  late ScrollController _scrollController;
  int pageNo = 1;
  int perPage = 10;
  int total = 0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (total > pageNo * perPage) {
          pageNo++;
          ref
              .read(orderListProvider.notifier)
              .getOrders(page: pageNo, perPage: perPage)
              .then((value) {
            setState(() {});
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(orderListProvider).when(
        skipLoadingOnRefresh: false,
        data: (orderData) {
          total = orderData.total;

          return orderData.orders.isEmpty
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        "No Order Found",
                        style: TextStyle(fontSize: 16.sp),
                      ),
                    ),
                    const Gap(20),
                    TextButton(
                      onPressed: () {
                        ref.refresh(orderListProvider.notifier).build();
                      },
                      // refresh icon with refresh text
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.refresh),
                          Gap(5),
                          Text("Refresh"),
                        ],
                      ),
                    ),
                  ],
                )
              : Expanded(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.r, vertical: 15.r),
                    child: RefreshIndicator(
                      onRefresh: () {
                        // ref.read(orderListProvider.notifier).orderList.clear();
                        // pageNo = 1;
                        // perPage = 10;
                        // return ref
                        //     .refresh(orderListProvider.notifier)
                        //     .getOrders(page: pageNo, perPage: perPage);
                        return Future<void>.value(true);
                      },
                      child: ListView.builder(
                        controller: _scrollController,
                        padding: EdgeInsets.zero,
                        itemCount: orderData.orders.length,
                        itemBuilder: (context, index) {
                          return OrderCard(
                            index: index,
                            orderData: orderData.orders[index],
                          );
                        },
                      ),
                    ),
                  ),
                );
        },
        error: (error, stack) {
          return Center(
            child: Column(
              children: [
                Text(
                  error.toString(),
                  style: AppTextStyle.smallBody,
                ),
                TextButton(
                  onPressed: () {
                    ref.refresh(orderListProvider.notifier).getOrders();
                  },
                  // refresh icon with refresh text
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.refresh),
                      Gap(5),
                      Text("Refresh"),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
        loading: () {
          return Expanded(
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}

class DotAnimation extends StatefulWidget {
  @override
  _DOTAnimationState createState() => _DOTAnimationState();
}

class _DOTAnimationState extends State<DotAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> size;
  late Animation<double> opacity;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 1), vsync: this)
          ..repeat();
    size = Tween(begin: 10.0, end: 25.0).animate(controller);
    opacity = Tween(begin: 1.0, end: 0.01).animate(controller);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          height: 26.r,
          width: 26.r,
        ),
        AnimatedBuilder(
            animation: controller,
            builder: (context, _) {
              return Container(
                height: size.value,
                width: size.value,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Color(0xFF1EDD31).withOpacity(opacity.value),
                  shape: BoxShape.circle,
                ),
              );
            }),
        Container(
          height: 11.r,
          width: 11.r,
          decoration: BoxDecoration(
            color: Color(0xFF1EDD31),
            shape: BoxShape.circle,
          ),
        ),
      ],
    );
  }
}

class DottedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColor.greyColor
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    var path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);

    var dashArray = [5.0, 5.0];
    for (int i = 0; i < path.computeMetrics().length; i++) {
      var metric = path.computeMetrics().elementAt(i);
      var start = 0.0;
      while (start < metric.length) {
        final end = start + dashArray[0];
        var linePath = metric.extractPath(start, end);
        canvas.drawPath(linePath, paint);
        start += dashArray[0] + dashArray[1];
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
