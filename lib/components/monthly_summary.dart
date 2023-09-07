import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:habit_tracker/datetime/date_time.dart';

class MonthlySummary extends StatelessWidget {
  final String startDate;
  final Map<DateTime, int>? datasets;

  const MonthlySummary({
    Key? key,
    required this.startDate,
    required this.datasets,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 25, bottom: 25),
      child: HeatMap(
        startDate: createDateTimeObject(startDate),
        endDate: DateTime.now().add(const Duration(days: 0)),
        datasets: datasets,
        colorMode: ColorMode.color,
        showText: true,
        scrollable: true,
        colorsets: const {
          1: Colors.red,
          3: Colors.orange,
          5: Colors.yellow,
          7: Colors.green,
          9: Colors.blue,
          11: Colors.indigo,
          13: Colors.purple,
        },
        size: 30,
        onClick: (value) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value.toString())));
        },
      ),
    );
  }
}
