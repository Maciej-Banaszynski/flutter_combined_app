import 'package:flutter/material.dart';

import '../../common/extensions/build_context_extensions.dart';
import '../../common/widgets/app_scaffold/app_scaffold.dart';

class DataScreen extends StatelessWidget {
  const DataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      screenTitle: context.localizations.data_dashboard_title,
      child: const Placeholder(),
    );
  }
}
