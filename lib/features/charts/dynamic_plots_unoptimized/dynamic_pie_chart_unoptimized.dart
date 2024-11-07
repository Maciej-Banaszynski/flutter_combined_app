import 'dart:async';
import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class DynamicPieChartUnoptimized extends StatefulWidget {
  const DynamicPieChartUnoptimized({super.key});

  @override
  State<DynamicPieChartUnoptimized> createState() => _DynamicPieChartUnoptimizedState();
}

class _DynamicPieChartUnoptimizedState extends State<DynamicPieChartUnoptimized> {
  final Random _random = Random();

  List<PieChartSectionData> _data = [];

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _data = List.generate(4, (index) {
          return PieChartSectionData(
            value: _random.nextDouble() * 10,
            title: '${_random.nextDouble() * 10}',
            color: Colors.primaries[index % Colors.primaries.length],
            radius: 50,
          );
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return PieChart(
      PieChartData(sections: _data),
    );
  }
}
