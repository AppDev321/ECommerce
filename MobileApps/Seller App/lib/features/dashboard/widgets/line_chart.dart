import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:razin_commerce_seller_flutter/config/app_color.dart';
import 'package:razin_commerce_seller_flutter/config/app_text_style.dart';
import 'package:razin_commerce_seller_flutter/features/dashboard/models/dashboard_data_model.dart';

class LineChartSample2 extends ConsumerStatefulWidget {
  final DashboardDataModel dashboardDataModel;
  const LineChartSample2(this.dashboardDataModel, {super.key});

  @override
  ConsumerState<LineChartSample2> createState() => _LineChartSample2State();
}

class _LineChartSample2State extends ConsumerState<LineChartSample2> {
  List<Color> gradientColors = [
    AppStaticColor.white,
    AppStaticColor.primary,
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AspectRatio(
          aspectRatio: 1.32,
          child: LineChart(
            mainData(),
          ),
        ),
        Positioned(
          bottom: 9,
          right: 6.w,
          child: GestureDetector(
            onTap: () {
              ref.read(isLastSixMonth.notifier).state =
                  !ref.read(isLastSixMonth);
            },
            child: CircleAvatar(
              backgroundColor: AppStaticColor.secondary,
              radius: 8.r,
              child: const Center(
                child: Icon(
                  Icons.chevron_right,
                  size: 15,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    TextStyle style = AppTextStyle.text12B700
        .copyWith(fontWeight: FontWeight.w400, color: AppStaticColor.gray);

    Widget text;
    switch (value) {
      case 2:
        text = Padding(
          padding: const EdgeInsets.only(top: 14),
          child: Text('Jan', style: style),
        );
        break;
      case 4:
        text = Padding(
          padding: const EdgeInsets.only(right: 22, top: 14),
          child: Text('Feb', style: style),
        );
        break;
      case 6:
        text = Padding(
          padding: const EdgeInsets.only(right: 22, top: 14),
          child: Text('Mar', style: style),
        );
        break;
      case 8:
        text = Padding(
          padding: const EdgeInsets.only(right: 22, top: 14),
          child: Text('Apr', style: style),
        );
        break;
      case 10:
        text = Padding(
            padding: const EdgeInsets.only(right: 36, top: 14),
            child: Text('May', style: style));
        break;
      case 11:
        text = Padding(
          padding: EdgeInsets.only(right: 5.w, top: 14),
          child: Text('Jun', style: style),
        );
        break;
      default:
        text = Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  Widget bottomTitleWidgets2(double value, TitleMeta meta) {
    TextStyle style = AppTextStyle.text12B700
        .copyWith(fontWeight: FontWeight.w400, color: AppStaticColor.gray);

    Widget text;
    switch (value) {
      case 2:
        text = Padding(
          padding: const EdgeInsets.only(top: 14),
          child: Text('Jul', style: style),
        );
        break;
      case 4:
        text = Padding(
          padding: const EdgeInsets.only(right: 22, top: 14),
          child: Text('Aug', style: style),
        );
        break;
      case 6:
        text = Padding(
          padding: const EdgeInsets.only(right: 22, top: 14),
          child: Text('Sep', style: style),
        );
        break;
      case 8:
        text = Padding(
          padding: const EdgeInsets.only(right: 22, top: 14),
          child: Text('Oct', style: style),
        );
        break;
      case 10:
        text = Padding(
            padding: const EdgeInsets.only(right: 36, top: 14),
            child: Text('Nov', style: style));
        break;
      case 11:
        text = Padding(
            padding: EdgeInsets.only(right: 5.w, top: 14),
            child: Text('Dec', style: style));
        break;
      default:
        text = Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    String text;
    switch (value.toInt()) {
      case 0:
        text = '0';
        break;
      case 1:
        text = '1k';
        break;
      case 2:
        text = '2k';
        break;
      case 3:
        text = '3k';
        break;
      case 4:
        text = '4k';
        break;
      default:
        return const SizedBox.shrink();
    }

    return Text(text,
        style: AppTextStyle.text12B700.copyWith(
          fontWeight: FontWeight.w400,
          color: AppStaticColor.gray,
        ),
        textAlign: TextAlign.left);
  }

  LineChartData mainData() {
    int midPoint = widget.dashboardDataModel.salesChartValues.length ~/ 2;
    List<double> firstHalf =
        widget.dashboardDataModel.salesChartValues.sublist(0, midPoint);
    List<double> secondHalf =
        widget.dashboardDataModel.salesChartValues.sublist(
      midPoint,
    );
    print("this is mid point: $midPoint");
    print('First Half: $firstHalf');
    print('Second Half: $secondHalf');

    double maxLimit = 4.0;
    // Find the mazimum value in the original list
    double firstListMaxValue = firstHalf.reduce((a, b) => a > b ? a : b);
    print(firstListMaxValue);

    double secondListMaxValue = secondHalf.reduce((a, b) => a > b ? a : b);
    print(secondListMaxValue);

    // Normalize the values so that the mazimum value is equal to maxLimit
    List<double> yValue1 = firstHalf
        .map((element) => (element / firstListMaxValue) * maxLimit)
        .toList();

    List<double> yValue2 =
        secondHalf.map((element) => (element / 5) * maxLimit).toList();

    final List<double> xValue1 = [
      1.5,
      3.5,
      5.6,
      7.7,
      9.5,
      12,
    ];
    final List<double> xValue2 = [
      1.5,
      3.5,
      5.6,
      7.7,
      9.5,
      12,
    ];

    // Generate spots using tooltipValues
    final List<FlSpot> spots = List.generate(
      firstHalf.length,
      (index) => FlSpot(xValue1[index], yValue1[index]),
    );
    final List<FlSpot> spots1 = List.generate(
      secondHalf.length,
      (index) => FlSpot(xValue2[index], yValue2[index]),
    );

    return LineChartData(
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipRoundedRadius: 8,
          fitInsideVertically: true,
          fitInsideHorizontally: true,
          getTooltipItems: (List<LineBarSpot> touchSpots) {
            return touchSpots.map((LineBarSpot touchedSpot) {
              List<double> tooltipValues =
                  ref.read(isLastSixMonth) ? secondHalf : firstHalf;
              const TextStyle textStyle = TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              );

              // Get the index of the touched spot
              final int index = touchedSpot.spotIndex.toInt();

              // Check if the index is within the range of tooltipValues list
              if (index >= 0 && index < tooltipValues.length) {
                final String tooltipValue =
                    '\$${tooltipValues[index].toString()}';
                return LineTooltipItem(
                  tooltipValue.toString(),
                  textStyle,
                );
              } else {
                return const LineTooltipItem('', textStyle);
              }
            }).toList();
          },
        ),
      ),
      gridData: FlGridData(
        drawVerticalLine: false,
        horizontalInterval: 0.99,
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: AppStaticColor.lightGray,
            strokeWidth: 1,
            dashArray: [4, 4],
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 45,
            getTitlesWidget: ref.watch(isLastSixMonth)
                ? bottomTitleWidgets2
                : bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 25,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      minX: 1.5,
      maxX: 12.2,
      minY: 0,
      maxY: 4,
      lineBarsData: [
        LineChartBarData(
          spots: ref.watch(isLastSixMonth) ? spots1 : spots,
          isCurved: true,
          color: AppStaticColor.primary,
          barWidth: 4,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: gradientColors
                  .map(
                    (color) => color.withOpacity(0.2),
                  )
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}

final isLastSixMonth = StateProvider<bool>((ref) => false);
