import 'dart:math';
import 'package:expense_tracker_advance/data/individual_bar.dart';

class BarData {
  final List<double> summary;

  BarData({
    this.summary = const [],
  });

  List<IndividualBar> barData = [];

  void initBarDataByWeek() {
    barData.clear();
    var i = 0;
    for (var priceDay in summary) {
      barData.add(
        IndividualBar(
          x: i,
          y: priceDay,
        ),
      );
      i++;
    }
  }

  void initBarDataByMonth() {
    barData.clear();
    var weekNumber = 0;
    var day = 1;

    for (var priceDay = 0; priceDay < summary.length; priceDay++) {
      if (day % 7 != 1) {
        barData.add(
          IndividualBar(
            x: -1,
            y: summary[priceDay],
          ),
        );
      } else {
        barData.add(
          IndividualBar(
            x: weekNumber,
            y: summary[priceDay],
          ),
        );
      }
      day++;
      if (day % 7 == 1) {
        weekNumber++;
      }
    }
  }

  double getMaxPrice() {
    return summary.reduce(max);
  }
}
