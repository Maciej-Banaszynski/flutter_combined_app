import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../common/metrics_manager/metrics_manager.dart';
import '../../../data/models/chart_data_point.dart';
import 'chart_data_size_picker.dart';

class FlBarChartView extends HookWidget {
  const FlBarChartView({
    super.key,
    required this.chartType,
  });

  final ChartType chartType;

  @override
  Widget build(BuildContext context) {
    final metricsManager = Modular.get<MetricsManager>();
    final data = useState<List<List<DataPoint>>>([]);
    final labels = useState<List<String>>([]);
    final dataSize = useState<DataSize>(DataSize.five);

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
        Text(chartType.barTitle),
        const SizedBox(height: 20),
        ChartDataSizePicker(
          dataSize: dataSize.value,
          dataSizeValues: DataSize.barChartValues,
          onValueChanged: (newDataSize) => dataSize.value = newDataSize,
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: 300,
          child: data.value.isEmpty || data.value.any((list) => list.isEmpty)
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: BarChart(
                    BarChartData(
                      barGroups: data.value
                          .asMap()
                          .entries
                          .map(
                            (entry) => BarChartGroupData(
                              x: entry.key,
                              barRods: entry.value
                                  .where((point) {
                                    final xMillis = point.x.millisecondsSinceEpoch;
                                    return xMillis >= 0 && point.y.isFinite;
                                  })
                                  .map(
                                    (point) => BarChartRodData(
                                      toY: point.y,
                                      color: [
                                        Colors.blueAccent,
                                        Colors.redAccent,
                                        Colors.lightGreen,
                                      ][entry.key],
                                    ),
                                  )
                                  .toList(),
                            ),
                          )
                          .toList(),
                      titlesData: const FlTitlesData(
                        leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true)),
                        rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true)),
                        topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      ),
                      borderData: FlBorderData(show: false),
                    ),
                  ),
                ),
        ),
        const SizedBox(height: 30),
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
        final singleData = ChartsManager.generateChartData(dataSize: dataSize, component: const Duration(hours: 1));
        data.value = [singleData];
        labels.value = ["Line 1"];
      case ChartType.multi:
        final line1 = ChartsManager.generateChartData(dataSize: dataSize, component: const Duration(hours: 1));
        final line2 = ChartsManager.generateChartData(dataSize: dataSize, component: const Duration(hours: 1));
        final line3 = ChartsManager.generateChartData(dataSize: dataSize, component: const Duration(hours: 1));
        data.value = [line1, line2, line3];
        labels.value = ["Line 1", "Line 2", "Line 3"];
    }
  }
}
