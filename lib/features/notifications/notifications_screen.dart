import 'package:flutter/material.dart';

import '../../common/extensions/build_context_extensions.dart';
import '../../common/widgets/app_scaffold/app_scaffold.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      screenTitle: context.localizations.notification_dashboard_title,
      child: const Placeholder(),
    );
  }
}
