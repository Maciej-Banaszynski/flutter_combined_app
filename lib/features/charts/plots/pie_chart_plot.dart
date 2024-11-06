import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../common/widgets/app_scaffold/app_scaffold.dart';

class PieChartPlot extends HookWidget {
  const PieChartPlot({super.key});

  static const String route = '/pie_chart_plot';

  @override
  Widget build(BuildContext context) {
    final initialLoadStopwatch = useMemoized(() => Stopwatch()..start());

    useEffect(() {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        initialLoadStopwatch.stop();
        print('Pie chart initial load time: ${initialLoadStopwatch.elapsedMilliseconds} ms');
      });
      _trackFrameRenderTime('Pie chart');
      return null;
    }, []);

    return AppScaffold(
      screenTitle: 'Pie Chart',
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: PieChart(
            PieChartData(
              sectionsSpace: 2,
              centerSpaceRadius: 50,
              sections: [
                PieChartSectionData(value: 40, color: Colors.red, radius: 100),
                PieChartSectionData(value: 30, color: Colors.green, radius: 100),
                PieChartSectionData(value: 15, color: Colors.blue, radius: 100),
                PieChartSectionData(value: 15, color: Colors.yellow, radius: 100),
              ],
              pieTouchData: PieTouchData(enabled: false),
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
