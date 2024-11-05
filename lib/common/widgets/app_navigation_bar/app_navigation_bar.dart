import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart' hide ModularWatchExtension;
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../app/app_route_paths.dart';
import '../../../features/dashboard/screen/cubit/dashboard_cubit.dart';
import '../../extensions/build_context_extensions.dart';
import '../../extensions/navigation_on_string/navigation_on_string.dart';

class AppNavigationBar extends StatelessWidget {
  const AppNavigationBar({
    super.key,
  });

  DashboardCubit _dashboardCubit(BuildContext context) => context.read<DashboardCubit>();

  @override
  Widget build(BuildContext context) {
    final selectedViewIndex = context.select((DashboardCubit cubit) => cubit.state.selectedViewIndex);
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          blurRadius: 30.5.r,
          blurStyle: BlurStyle.normal,
          color: Colors.black.withOpacity(0.05),
          offset: Offset(0, -5.h),
          spreadRadius: 2.r,
        ),
      ]),
      child: NavigationBar(
        selectedIndex: selectedViewIndex,
        onDestinationSelected: (selectedIndex) => _navigateToSelectedModule(context, selectedIndex: selectedIndex),
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.stacked_line_chart),
            label: context.localizations.charts_dashboard_title,
          ),
          NavigationDestination(
            icon: const Icon(Icons.animation_rounded),
            label: context.localizations.animations_dashboard_title,
          ),
          NavigationDestination(
            icon: const Icon(Icons.map_rounded),
            label: context.localizations.maps_dashboard_title,
          ),
          NavigationDestination(
            icon: const Icon(Icons.notifications),
            label: context.localizations.notification_dashboard_title,
          ),
          NavigationDestination(
            icon: const Icon(Icons.data_array),
            label: context.localizations.data_dashboard_title,
          ),
        ],
      ),
    );
  }

  void _navigateToSelectedModule(
    BuildContext context, {
    required int selectedIndex,
  }) {
    _dashboardCubit(context).onSelectedIndexChanged(selectedIndex);
    final navigateToPath = switch (selectedIndex) {
      1 => AppRoutePaths.animationsPath.toNavigation,
      2 => AppRoutePaths.mapsPath.toNavigation,
      3 => AppRoutePaths.notificationPath.toNavigation,
      4 => AppRoutePaths.dataPath.toNavigation,
      _ => AppRoutePaths.chartsPath.toNavigation,
    };
    Modular.to.navigate(navigateToPath);
  }
}
