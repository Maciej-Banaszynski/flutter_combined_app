import 'package:flutter/material.dart';

import '../../common/extensions/build_context_extensions.dart';
import '../../common/widgets/app_scaffold/app_scaffold.dart';

class AnimationsScreen extends StatelessWidget {
  const AnimationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      screenTitle: context.localizations.animations_dashboard_title,
      child: const Placeholder(),
    );
  }
}
