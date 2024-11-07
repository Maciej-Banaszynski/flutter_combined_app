import 'package:flutter/material.dart';

import '../../../common/widgets/app_scaffold/app_scaffold.dart';
import 'dynamic_bar_chart.dart';
import 'dynamic_line_chart.dart';
import 'dynamic_pie_chart.dart';
import 'dynamic_scatter_chart.dart';

class DynamicMultipleCharts extends StatelessWidget {
  const DynamicMultipleCharts({super.key});

  static const String route = '/dynamic_charts';

  @override
  Widget build(BuildContext context) {
    return const AppScaffold(
      screenTitle: 'Dynamic charts',
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text('Line Chart', style: TextStyle(fontSize: 20)),
            SizedBox(height: 300, child: DynamicLineChart()),
            Text('Bar Chart', style: TextStyle(fontSize: 20)),
            SizedBox(height: 300, child: DynamicBarChart()),
            Text('Pie Chart', style: TextStyle(fontSize: 20)),
            SizedBox(height: 300, child: DynamicPieChart()),
            Text('Scatter Chart', style: TextStyle(fontSize: 20)),
            SizedBox(height: 300, child: DynamicScatterChart()),
          ],
        ),
      ),
    );
  }
}
