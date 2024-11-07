import 'dart:async';
import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class DynamicLineChartUnoptimized extends StatefulWidget {
  const DynamicLineChartUnoptimized({super.key});

  @override
  State<DynamicLineChartUnoptimized> createState() => _DynamicLineChartUnoptimizedState();
}

class _DynamicLineChartUnoptimizedState extends State<DynamicLineChartUnoptimized> {
  final Random _random = Random();

  List<FlSpot> _data = [];

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _data = List.generate(1000, (index) {
          return FlSpot(index.toDouble(), _random.nextDouble() * 10);
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        lineBarsData: [
          LineChartBarData(
            spots: _data,
            isCurved: true,
            color: Colors.blueAccent,
            barWidth: 2,
            belowBarData: BarAreaData(show: true, color: Colors.blueAccent.withOpacity(0.3)),
            dotData: const FlDotData(show: false),
          ),
        ],
      ),
    );
  }
}
