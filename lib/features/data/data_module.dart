import 'package:flutter_modular/flutter_modular.dart';

import '../../app/app_route_paths.dart';
import '../../di/di_repositories_module.dart';
import 'data_management_selection_screen.dart';
import 'data_managment_screen/cubit/data_management_cubit.dart';
import 'data_managment_screen/data_management_screen.dart';

class DataModule extends Module {
  @override
  List<Module> get imports => [
        DiRepositoriesModule(),
      ];

  @override
  void binds(Injector i) {
    i.addLazySingleton<DataManagementCubit>(
      DataManagementCubit.new,
      config: BindConfig(onDispose: (cubit) => cubit.close()),
    );
    super.binds(i);
  }

  @override
  void routes(r) {
    r.child(
      AppRoutePaths.startPath,
      child: (context) => const DataManagementSelectionScreen(),
      transition: TransitionType.noTransition,
    );
    r.child(
      DataManagementScreen.route,
      child: (context) => const DataManagementScreen(),
      transition: TransitionType.noTransition,
    );
    super.routes(r);
  }
}
