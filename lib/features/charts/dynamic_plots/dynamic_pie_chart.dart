import 'dart:async';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../data/models/chart_data_point.dart';

class DynamicPieChart extends HookWidget {
  const DynamicPieChart({super.key});

  @override
  Widget build(BuildContext context) {
    final data = useState<List<ChartDataPoint>>(generateRandomData(4));

    useEffect(() {
      final timer = Timer.periodic(const Duration(seconds: 3), (timer) {
        data.value = generateRandomData(4);
      });
      return timer.cancel;
    }, []);

    return PieChart(
      PieChartData(
        sections: data.value.map((point) {
          return PieChartSectionData(
            value: point.y,
            title: point.y.toStringAsFixed(1),
            color: Colors.primaries[point.x.toInt() % Colors.primaries.length],
            radius: 50,
          );
        }).toList(),
      ),
    );
  }
}
