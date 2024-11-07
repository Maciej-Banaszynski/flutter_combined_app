import 'package:flutter/material.dart';

import '../../../common/widgets/app_scaffold/app_scaffold.dart';
import 'dynamic_bar_chart_unoptimized.dart';
import 'dynamic_line_chart_unoptimized.dart';
import 'dynamic_pie_chart_unoptimized.dart';
import 'dynamic_scatter_chart_unoptimized.dart';

class DynamicMultipleChartsUnoptimized extends StatelessWidget {
  const DynamicMultipleChartsUnoptimized({super.key});

  static const String route = '/dynamic_charts_unoptimized';

  @override
  Widget build(BuildContext context) {
    return const AppScaffold(
      screenTitle: 'Dynamic charts unoptimized',
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text('Line Chart', style: TextStyle(fontSize: 20)),
            SizedBox(height: 300, child: DynamicLineChartUnoptimized()),
            Text('Bar Chart', style: TextStyle(fontSize: 20)),
            SizedBox(height: 300, child: DynamicBarChartUnoptimized()),
            Text('Pie Chart', style: TextStyle(fontSize: 20)),
            SizedBox(height: 300, child: DynamicPieChartUnoptimized()),
            Text('Scatter Chart', style: TextStyle(fontSize: 20)),
            SizedBox(height: 300, child: DynamicScatterChartUnoptimized()),
          ],
        ),
      ),
    );
  }
}
