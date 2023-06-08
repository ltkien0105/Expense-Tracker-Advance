import 'package:expense_tracker_advance/data/bar_data.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class BarGraph extends StatelessWidget {
  final List<double> summary;

  const BarGraph({
    super.key,
    this.summary = const [],
  });

  @override
  Widget build(BuildContext context) {
    late BarData myBarData;
    late double maxPrice;
    late Widget Function(double value, TitleMeta meta) getBottomTitles;

    if (summary.length == 7) {
      myBarData = BarData(summary: summary);
      myBarData.initBarDataByWeek();
      maxPrice = myBarData.getMaxPrice();
      getBottomTitles = getBottomTitlesByWeek;
    } else {
      myBarData = BarData(summary: summary);
      myBarData.initBarDataByMonth();
      maxPrice = myBarData.getMaxPrice();
      getBottomTitles = getBottomTitlesByMonth;
    }

    return BarChart(
      BarChartData(
        maxY: maxPrice,
        minY: 0,
        gridData: FlGridData(show: false),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          rightTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: false,
            ),
          ),
          topTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: false,
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: getBottomTitles,
            ),
          ),
        ),
        barGroups: myBarData.barData
            .map(
              (data) => BarChartGroupData(
                x: data.x,
                barRods: [
                  BarChartRodData(
                    borderRadius: BorderRadius.circular(6),
                    color: Colors.black,
                    toY: data.y,
                    width: 10,
                  ),
                ],
              ),
            )
            .toList(),
      ),
      swapAnimationDuration: const Duration(milliseconds: 500),
    );
  }
}

Widget getBottomTitlesByWeek(double value, TitleMeta meta) {
  const style = TextStyle(
    color: Colors.grey,
    fontWeight: FontWeight.bold,
    fontSize: 14,
  );

  Widget text;
  switch (value.toInt()) {
    case 0:
      text = const Text(
        'Mon',
        style: style,
      );
      break;
    case 1:
      text = const Text(
        'Tue',
        style: style,
      );
      break;
    case 2:
      text = const Text(
        'Wed',
        style: style,
      );
      break;
    case 3:
      text = const Text(
        'Thu',
        style: style,
      );
      break;
    case 4:
      text = const Text(
        'Fri',
        style: style,
      );
      break;
    case 5:
      text = const Text(
        'Sat',
        style: style,
      );
      break;
    case 6:
      text = const Text(
        'Sun',
        style: style,
      );
      break;
    default:
      text = const Text(
        '',
        style: style,
      );
      break;
  }
  return SideTitleWidget(axisSide: meta.axisSide, child: text);
}

Widget getBottomTitlesByMonth(double value, TitleMeta meta) {
  const style = TextStyle(
    color: Colors.grey,
    fontWeight: FontWeight.bold,
    fontSize: 13,
  );

  Widget text;
  switch (value.toInt()) {
    case 0:
      text = const Text(
        '1',
        style: style,
      );
      break;
    case 1:
      text = const Text(
        '8',
        style: style,
      );
      break;
    case 2:
      text = const Text(
        '15',
        style: style,
      );
      break;
    case 3:
      text = const Text(
        '22',
        style: style,
      );
      break;
    case 4:
      text = const Text(
        '29',
        style: style,
      );
      break;
    default:
      text = const Text(
        '',
        style: style,
      );
      break;
  }
  return SideTitleWidget(axisSide: meta.axisSide, child: text);
}
