import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../common/widgets/app_scaffold/app_scaffold.dart';

class ScatterChartPlot extends HookWidget {
  const ScatterChartPlot({super.key});

  static const String route = '/scatter_chart_plot';

  @override
  Widget build(BuildContext context) {
    final initialLoadStopwatch = useMemoized(() => Stopwatch()..start());
    final scatterSpots = useMemoized(() => List.generate(
          300,
          (i) => ScatterSpot(
            Random().nextDouble() * 10,
            Random().nextDouble() * 10,
          ),
        ));

    useEffect(() {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        initialLoadStopwatch.stop();
        print('Scatter chart initial load time: ${initialLoadStopwatch.elapsedMilliseconds} ms');
      });
      _trackFrameRenderTime('Scatter chart');
      return null;
    }, []);

    return AppScaffold(
      screenTitle: 'Scatter Chart',
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ScatterChart(
            ScatterChartData(
              scatterSpots: scatterSpots,
              titlesData: const FlTitlesData(
                leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              ),
              gridData: const FlGridData(show: false),
              borderData: FlBorderData(show: false),
              scatterTouchData: ScatterTouchData(enabled: false),
              minX: 0,
              maxX: 10,
              minY: 0,
              maxY: 10,
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
