import 'package:flutter/material.dart';

import '../../../common/widgets/app_scaffold/app_scaffold.dart';
import '../../../data/models/chart_data_point.dart';
import 'fl_bar_chart_view.dart';
import 'fl_line_chart_view.dart';

class FlChartsView extends StatelessWidget {
  const FlChartsView({super.key});

  static const String route = '/fl_charts_view';

  @override
  Widget build(BuildContext context) {
    return const AppScaffold(
      screenTitle: "FL Charts",
      child: SingleChildScrollView(
        child: Column(
          children: [
            FlLineChartView(chartType: ChartType.single),
            FlBarChartView(chartType: ChartType.single),
            FlLineChartView(chartType: ChartType.multi),
            FlBarChartView(chartType: ChartType.multi),
          ],
        ),
      ),
    );
  }
}
