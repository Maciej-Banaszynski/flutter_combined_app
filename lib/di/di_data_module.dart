import 'package:flutter_modular/flutter_modular.dart';

import '../common/metrics_manager/metrics_manager.dart';
import '../data/drift/dao/user_dao/user_dao_interface.dart';
import '../data/drift/drift_db.dart';

class DIDataModule extends Module {
  @override
  void exportedBinds(i) {
    i.addLazySingleton<UserDaoInterface>(() => DriftDb.instance().userDao);
    i.addSingleton<MetricsManager>(MetricsManager.new);
    super.exportedBinds(i);
  }
}
