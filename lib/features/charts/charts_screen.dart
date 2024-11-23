import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../common/extensions/build_context_extensions.dart';
import '../../common/extensions/navigation_on_string/navigation_on_string.dart';
import '../../common/widgets/app_scaffold/app_scaffold.dart';
import 'fl_charts/fl_charts_view.dart';

class ChartsScreen extends StatelessWidget {
  const ChartsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      screenTitle: context.localizations.charts_dashboard_title,
      child: Column(
        children: [
          _buildChartButton(
            icon: Icons.stacked_line_chart,
            title: 'FL Charts',
            onTap: () => Modular.to.pushNamed(FlChartsView.route.relativePath),
          ),
          // _buildChartButton(
          //   icon: Icons.stacked_line_chart,
          //   title: 'Multiple Dynamic Charts',
          //   onTap: () => Modular.to.pushNamed(DynamicMultipleCharts.route.relativePath),
          // ),
          // _buildChartButton(
          //   icon: Icons.stacked_line_chart,
          //   title: 'Multiple Dynamic Charts Unoptimized',
          //   onTap: () => Modular.to.pushNamed(DynamicMultipleCharts.route.relativePath),
          // ),
          // _buildChartButton(
          //   icon: Icons.show_chart,
          //   title: 'Line Chart',
          //   onTap: () => Modular.to.pushNamed(LineChartPlot.route.relativePath),
          // ),
          // _buildChartButton(
          //   icon: Icons.bar_chart,
          //   title: 'Bar Chart',
          //   onTap: () => Modular.to.pushNamed(BarChartPlot.route.relativePath),
          // ),
          // _buildChartButton(
          //   icon: Icons.pie_chart,
          //   title: 'Pie Chart',
          //   onTap: () => Modular.to.pushNamed(PieChartPlot.route.relativePath),
          // ),
          // _buildChartButton(
          //   icon: Icons.scatter_plot,
          //   title: 'Scatter Plot',
          //   onTap: () => Modular.to.pushNamed(ScatterChartPlot.route.relativePath),
          // ),
        ],
      ),
    );
  }

  Widget _buildChartButton({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: Icon(icon, color: Colors.blueAccent),
        title: Text(title, style: const TextStyle(fontSize: 18)),
        trailing: const Icon(Icons.chevron_right, color: Colors.grey),
        onTap: onTap,
      ),
    );
  }
}
