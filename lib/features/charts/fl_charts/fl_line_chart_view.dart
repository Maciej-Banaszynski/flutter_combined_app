import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../common/metrics_manager/metrics_manager.dart';
import '../../../data/models/chart_data_point.dart';
import 'chart_data_size_picker.dart';

class FlLineChartView extends HookWidget {
  FlLineChartView({
    super.key,
    required this.chartType,
  });

  final ChartType chartType;

  final Stopwatch _stopwatch = Stopwatch();

  @override
  Widget build(BuildContext context) {
    final metricsManager = Modular.get<MetricsManager>();
    final data = useState<List<List<DataPoint>>>([]);
    final labels = useState<List<String>>([]);
    final dataSize = useState<DataSize>(DataSize.hundred);

    useEffect(() {
      _generateData(
        metricsManager: metricsManager,
        chartType: chartType,
        dataSize: dataSize.value,
        data: data,
        labels: labels,
      );
      return null;
    }, [dataSize.value]);

    return Column(
      children: [
        ChartDataSizePicker(
          dataSize: dataSize.value,
          dataSizeValues: DataSize.lineChartValues,
          onValueChanged: (newDataSize) => dataSize.value = newDataSize,
        ),
        SizedBox(
          height: 300,
          child: data.value.isEmpty || data.value.any((list) => list.isEmpty)
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: LineChart(
                    LineChartData(
                      lineBarsData: data.value
                          .asMap()
                          .entries
                          .map(
                            (entry) => LineChartBarData(
                              spots: entry.value
                                  .where((point) {
                                    final xMillis = point.x.millisecondsSinceEpoch;
                                    return xMillis >= 0 && point.y.isFinite;
                                  })
                                  .map(
                                    (point) => FlSpot(
                                      point.x.millisecondsSinceEpoch.toDouble(),
                                      point.y,
                                    ),
                                  )
                                  .toList(),
                              isCurved: true,
                              color: Colors.blueAccent.withOpacity(0.8 - (0.2 * entry.key)),
                              barWidth: 2,
                              belowBarData: BarAreaData(
                                show: true,
                                color: Colors.blueAccent.withOpacity(0.3),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
        ),
      ],
    );
  }

  Future<void> _generateData({
    required MetricsManager metricsManager,
    required ChartType chartType,
    required DataSize dataSize,
    required ValueNotifier<List<List<DataPoint>>> data,
    required ValueNotifier<List<String>> labels,
  }) async {
    switch (chartType) {
      case ChartType.single:
        await metricsManager.trackAction(
          "Generate ${dataSize.size} Data for single FLLineChart",
          () async {
            final singleData = ChartsManager.generateChartData(dataSize: dataSize, component: const Duration(hours: 1));

            data.value = [singleData];
            labels.value = ["Line 1"];

            // await _waitForRendering();
            _stopwatch.start();

            // Wait for widget to render
            await Future.delayed(const Duration(milliseconds: 50));
            WidgetsBinding.instance.addPostFrameCallback((_) async {
              _stopwatch.stop();
              print("Graph rendered in: ${_stopwatch.elapsedMilliseconds} ms");
            });
          },
        );
        break;

      case ChartType.multi:
        await metricsManager.trackAction(
          "Generate ${dataSize.size} Data for multiline FLLineChart",
          () async {
            final line1 = ChartsManager.generateChartData(dataSize: dataSize, component: const Duration(hours: 1));
            final line2 = ChartsManager.generateChartData(dataSize: dataSize, component: const Duration(hours: 1));
            final line3 = ChartsManager.generateChartData(dataSize: dataSize, component: const Duration(hours: 1));

            data.value = [line1, line2, line3];
            labels.value = ["Line 1", "Line 2", "Line 3"];

            await _waitForRendering();
          },
        );
        break;
    }
  }

  Future<void> _waitForRendering() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return Future<void>.sync(() {
      return WidgetsBinding.instance.addPostFrameCallback((_) {
        print("Rendered");
      });
    });
  }
}
