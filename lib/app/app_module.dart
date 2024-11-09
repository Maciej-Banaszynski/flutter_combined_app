import 'package:flutter_modular/flutter_modular.dart';

import '../di/di_data_module.dart';
import '../di/di_repositories_module.dart';
import '../features/dashboard/dashboard_module.dart';
import 'app_route_paths.dart';

class AppModule extends Module {
  @override
  List<Module> get imports => [
        // DIConfigModule(),
        // DINetworkModule(),
        DIDataModule(),
        DiRepositoriesModule(),
      ];

  @override
  void routes(r) {
    r.module(AppRoutePaths.startPath, module: DashboardModule());
  }
}
