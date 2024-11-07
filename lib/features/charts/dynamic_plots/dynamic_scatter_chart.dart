import 'dart:async';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../data/models/chart_data_point.dart';

class DynamicScatterChart extends HookWidget {
  const DynamicScatterChart({super.key});

  @override
  Widget build(BuildContext context) {
    final data = useState<List<ChartDataPoint>>(generateRandomData(20));

    useEffect(() {
      final timer = Timer.periodic(const Duration(seconds: 3), (timer) {
        data.value = generateRandomData(20);
      });
      return timer.cancel;
    }, []);

    return ScatterChart(
      ScatterChartData(
        scatterSpots: data.value.map((point) {
          return ScatterSpot(
            point.x,
            point.y,
          );
        }).toList(),
        titlesData: const FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: true),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: true),
          ),
        ),
        borderData: FlBorderData(show: true),
      ),
    );
  }
}
