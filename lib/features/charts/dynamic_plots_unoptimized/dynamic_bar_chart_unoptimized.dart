import 'dart:async';
import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class DynamicBarChartUnoptimized extends StatefulWidget {
  const DynamicBarChartUnoptimized({super.key});

  @override
  State<DynamicBarChartUnoptimized> createState() => _DynamicBarChartUnoptimizedState();
}

class _DynamicBarChartUnoptimizedState extends State<DynamicBarChartUnoptimized> {
  final Random _random = Random();

  List<BarChartGroupData> _data = [];

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _data = List.generate(10, (index) {
          return BarChartGroupData(
            x: index,
            barRods: [
              BarChartRodData(toY: _random.nextDouble() * 10, color: Colors.greenAccent, width: 16),
            ],
          );
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        barGroups: _data,
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
