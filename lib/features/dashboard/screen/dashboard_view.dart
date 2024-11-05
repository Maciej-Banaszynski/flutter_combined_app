import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart' hide ModularWatchExtension;

import '../../../common/widgets/app_navigation_bar/app_navigation_bar.dart';
import '../../../common/widgets/app_scaffold/app_scaffold.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppScaffold(
      topSafeArea: false,
      bottomNavigationBar: AppNavigationBar(),
      child: RouterOutlet(),
    );
  }
}
