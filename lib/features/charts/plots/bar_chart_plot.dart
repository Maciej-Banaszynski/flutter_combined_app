import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../common/widgets/app_scaffold/app_scaffold.dart';

class BarChartPlot extends HookWidget {
  const BarChartPlot({super.key});

  static const String route = '/bar_chart_plot';

  @override
  Widget build(BuildContext context) {
    final initialLoadStopwatch = useMemoized(() => Stopwatch()..start());
    final barGroups = useMemoized(() => List.generate(
          50,
          (i) => BarChartGroupData(
            x: i,
            barRods: [BarChartRodData(toY: Random().nextDouble() * 15 + 5)],
          ),
        ));

    useEffect(() {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        initialLoadStopwatch.stop();
        print('Bar chart initial load time: ${initialLoadStopwatch.elapsedMilliseconds} ms');
      });
      _trackFrameRenderTime('Bar chart');
      return null;
    }, []);

    return AppScaffold(
      screenTitle: 'Bar Chart',
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BarChart(
            BarChartData(
              barGroups: barGroups,
              titlesData: const FlTitlesData(
                leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              ),
              gridData: const FlGridData(show: false),
              borderData: FlBorderData(show: false),
              barTouchData: BarTouchData(enabled: false),
            ),
          ),
        ),
      ),
    );
  }

  void _trackFrameRenderTime(String chartName) {
    final frameStopwatch = Stopwatch()..start();
    SchedulerBinding.instance.addPersistentFrameCallback((_) {
      final elapsed = frameStopwatch.elapsedMicroseconds / 1000; // Convert to ms
      print('$chartName frame render time: ${elapsed.toStringAsFixed(2)} ms');
      frameStopwatch.reset();
    });
  }
}
