import 'package:flutter/material.dart';

import '../../common/extensions/build_context_extensions.dart';
import '../../common/widgets/app_scaffold/app_scaffold.dart';

class ChartsScreen extends StatelessWidget {
  const ChartsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      screenTitle: context.localizations.charts_dashboard_title,
      child: const SizedBox.shrink(),
    );
  }
}
