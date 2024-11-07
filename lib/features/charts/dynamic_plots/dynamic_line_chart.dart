import 'dart:async';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../data/models/chart_data_point.dart';

class DynamicLineChart extends HookWidget {
  const DynamicLineChart({super.key});

  @override
  Widget build(BuildContext context) {
    final data = useState<List<ChartDataPoint>>(generateRandomData(10));

    useEffect(() {
      final timer = Timer.periodic(const Duration(seconds: 3), (timer) {
        data.value = generateRandomData(10);
      });
      return timer.cancel;
    }, []);

    return LineChart(
      LineChartData(
        lineBarsData: [
          LineChartBarData(
            spots: data.value.map((point) => FlSpot(point.x, point.y)).toList(),
            isCurved: true,
            color: Colors.blueAccent,
            barWidth: 2,
            belowBarData: BarAreaData(show: true, color: Colors.blueAccent.withOpacity(0.3)),
          ),
        ],
      ),
    );
  }
}
