import 'package:flutter_modular/flutter_modular.dart';

import '../../app/app_route_paths.dart';
import '../../di/di_data_module.dart';
import '../animations/animations_module.dart';
import '../charts/charts_module.dart';
import '../data/data_module.dart';
import '../maps/maps_module.dart';
import '../notifications/notifications_screen.dart';
import 'screen/cubit/dashboard_cubit.dart';
import 'screen/dashboard_screen.dart';

class DashboardModule extends Module {
  @override
  List<Module> get imports => [
        DIDataModule(),
      ];

  @override
  void binds(i) {
    i.addLazySingleton<DashboardCubit>(
      DashboardCubit.new,
      config: BindConfig(onDispose: (cubit) => cubit.close()),
    );

    super.binds(i);
  }

  @override
  void routes(r) {
    r.child(
      AppRoutePaths.startPath,
      child: (context) => const DashboardScreen(),
      transition: TransitionType.noTransition,
      children: [
        ModuleRoute(
          AppRoutePaths.chartsPath,
          module: ChartsModule(),
        ),
        ModuleRoute(
          AppRoutePaths.animationsPath,
          module: AnimationsModule(),
        ),
        ModuleRoute(
          AppRoutePaths.mapsPath,
          module: MapsModule(),
        ),
        ModuleRoute(
          AppRoutePaths.dataPath,
          module: DataModule(),
        ),
        // ChildRoute(
        //   AppRoutePaths.chartsPath,
        //   child: (_) => const ChartsScreen(),
        // ),
        // ChildRoute(
        //   AppRoutePaths.animationsPath,
        //   child: (_) => const AnimationsScreen(),
        // ),
        // ChildRoute(
        //   AppRoutePaths.mapsPath,
        //   child: (_) => const MapsScreen(),
        // ),
        ChildRoute(
          AppRoutePaths.notificationPath,
          child: (_) => const NotificationsScreen(),
        ),
        // ChildRoute(
        //   AppRoutePaths.dataPath,
        //   child: (_) => DataScreen(),
        // ),
      ],
    );

    super.routes(r);
  }
}
