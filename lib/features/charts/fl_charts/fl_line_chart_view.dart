import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../data/models/chart_data_point.dart';
import 'chart_data_size_picker.dart';

class FlLineChartView extends HookWidget {
  const FlLineChartView({
    super.key,
    required this.chartType,
  });

  final ChartType chartType;

  @override
  Widget build(BuildContext context) {
    // final metricsManager = Modular.get<MetricsManager>();
    final data = useState<List<List<DataPoint>>>([]);
    final labels = useState<List<String>>([]);
    final dataSize = useState<DataSize>(DataSize.fifty);

    useEffect(() {
      _generateData(
        // metricsManager: metricsManager,
        chartType: chartType,
        dataSize: dataSize.value,
        data: data,
        labels: labels,
      );
      return null;
    }, [dataSize.value]);

    return Column(
      children: [
        Text(chartType.lineTitle),
        const SizedBox(height: 20),
        ChartDataSizePicker(
          dataSize: dataSize.value,
          dataSizeValues: DataSize.lineChartValues,
          onValueChanged: (newDataSize) => dataSize.value = newDataSize,
        ),
        const SizedBox(height: 20),
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
                              color: [Colors.blueAccent, Colors.redAccent, Colors.lightGreen][entry.key],
                              dotData: const FlDotData(show: false),
                              barWidth: 2,
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
        ),
        const SizedBox(height: 30),
      ],
    );
  }

  Future<void> _generateData({
    // required MetricsManager metricsManager,
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
