import 'dart:async';
import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class DynamicScatterChartUnoptimized extends StatefulWidget {
  const DynamicScatterChartUnoptimized({super.key});

  @override
  State<DynamicScatterChartUnoptimized> createState() => _DynamicScatterChartUnoptimizedState();
}

class _DynamicScatterChartUnoptimizedState extends State<DynamicScatterChartUnoptimized> {
  final Random _random = Random();

  List<ScatterSpot> _data = [];

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _data = List.generate(100, (index) {
          return ScatterSpot(
            _random.nextDouble() * 10,
            _random.nextDouble() * 10,
          );
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScatterChart(
      ScatterChartData(
        scatterSpots: _data,
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
