import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../common/extensions/build_context_extensions.dart';
import '../../common/extensions/navigation_on_string/navigation_on_string.dart';
import '../../common/widgets/app_scaffold/app_scaffold.dart';
import 'data_managment_screen/data_management_screen.dart';

class DataManagementSelectionScreen extends StatelessWidget {
  const DataManagementSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      screenTitle: context.localizations.data_dashboard_title,
      child: Column(
        children: [
          _buildDataButton(
            title: 'Basic Management',
            onTap: () => Modular.to.pushNamed(DataManagementScreen.route.relativePath),
          ),
        ],
      ),
    );
  }

  Widget _buildDataButton({
    required String title,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(title, style: const TextStyle(fontSize: 18)),
        trailing: const Icon(Icons.chevron_right, color: Colors.grey),
        onTap: onTap,
      ),
    );
  }
}
