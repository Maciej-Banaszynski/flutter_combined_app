import 'package:flutter_modular/flutter_modular.dart';

import '../../app/app_route_paths.dart';
import '../../di/di_data_module.dart';
import '../animations/animations_screen.dart';
import '../charts/charts_screen.dart';
import '../data/data_screen.dart';
import '../maps/maps_screen.dart';
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
    // i.addSingleton<ForegroundServiceInterface>(ForegroundServiceRepository.new);
    // i.addLazySingleton<BackgroundServiceInterface>(BackgroundServiceRepository.new);
    // i.addLazySingleton<BluetoothRepositoryInterface>(BluetoothRepository.new);
    // i.addLazySingleton<LocationRepositoryInterface>(LocationRepository.new);
    // i.addLazySingleton<ProfileCubit>(
    //   ProfileCubit.new,
    //   config: BindConfig(onDispose: (cubit) async => await cubit.close()),
    // );
    // i.addLazySingleton<HomeCubit>(
    //   HomeCubit.new,
    //   config: BindConfig(onDispose: (cubit) async => await cubit.close()),
    // );
    // i.addLazySingleton<CampaignsCubit>(
    //   CampaignsCubit.new,
    //   config: BindConfig(onDispose: (cubit) async => await cubit.close()),
    // );
    // i.addLazySingleton<BeaconsCubit>(
    //   BeaconsCubit.new,
    //   config: BindConfig(onDispose: (cubit) async => await cubit.close()),
    // );
    i.addLazySingleton<DashboardCubit>(
      DashboardCubit.new,
      config: BindConfig(onDispose: (cubit) => cubit.close()),
    );
    // i.add<TravelBookCubit>(
    //   TravelBookCubit.new,
    //   config: BindConfig(onDispose: (cubit) => cubit.close()),
    // );

    super.binds(i);
  }

  @override
  void routes(r) {
    r.child(
      AppRoutePaths.startPath,
      child: (context) => const DashboardScreen(),
      transition: TransitionType.noTransition,
      children: [
        ChildRoute(
          AppRoutePaths.chartsPath,
          child: (_) => const ChartsScreen(),
        ),
        ChildRoute(
          AppRoutePaths.animationsPath,
          child: (_) => const AnimationsScreen(),
        ),
        ChildRoute(
          AppRoutePaths.mapsPath,
          child: (_) => const MapsScreen(),
        ),
        ChildRoute(
          AppRoutePaths.notificationPath,
          child: (_) => const NotificationsScreen(),
        ),
        ChildRoute(
          AppRoutePaths.dataPath,
          child: (_) => const DataScreen(),
        ),
      ],
    );
    //
    // r.child(
    //   LogoutConfirmationScreen.route,
    //   child: (_) => const LogoutConfirmationScreen(),
    // );
    //
    // r.child(
    //   DeleteAccountScreen.route,
    //   child: (_) => const DeleteAccountScreen(),
    // );

    super.routes(r);
  }
}
