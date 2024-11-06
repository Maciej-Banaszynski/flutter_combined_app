import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../common/widgets/app_scaffold/app_scaffold.dart';

class LineChartPlot extends HookWidget {
  const LineChartPlot({super.key});

  static const String route = '/line_chart_plot';

  @override
  Widget build(BuildContext context) {
    final initialLoadStopwatch = useMemoized(() => Stopwatch()..start());
    final spots = useMemoized(() => List.generate(
          10000,
          (i) => FlSpot(i.toDouble(), sin(i * 0.1) * 10 + Random().nextDouble() * 5),
        ));

    useEffect(() {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        initialLoadStopwatch.stop();
        print('Line chart initial load time: ${initialLoadStopwatch.elapsedMilliseconds} ms');
      });
      _trackFrameRenderTime('Line chart');
      return null;
    }, []);

    return AppScaffold(
      screenTitle: 'Line Chart',
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: 20000,
              child: LineChart(
                LineChartData(
                  lineBarsData: [
                    LineChartBarData(spots: spots, isCurved: true, belowBarData: BarAreaData(show: true)),
                  ],
                  titlesData: const FlTitlesData(
                    show: true,
                    rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  gridData: const FlGridData(show: false),
                  borderData: FlBorderData(show: false),
                  minX: 0,
                  maxX: 1000,
                  minY: -15,
                  maxY: 15,
                  lineTouchData: const LineTouchData(enabled: false),
                ),
              ),
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
