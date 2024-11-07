import 'dart:async';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../data/models/chart_data_point.dart';

class DynamicBarChart extends HookWidget {
  const DynamicBarChart({super.key});

  @override
  Widget build(BuildContext context) {
    final data = useState<List<ChartDataPoint>>(generateRandomData(6));

    useEffect(() {
      final timer = Timer.periodic(const Duration(seconds: 3), (timer) {
        data.value = generateRandomData(6);
      });
      return timer.cancel;
    }, []);

    return BarChart(
      BarChartData(
        barGroups: data.value.map((point) {
          return BarChartGroupData(
            x: point.x.toInt(),
            barRods: [
              BarChartRodData(toY: point.y, color: Colors.greenAccent, width: 16),
            ],
          );
        }).toList(),
        titlesData: const FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: true),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: true),
          ),
        ),
      ),
    );
  }
}
