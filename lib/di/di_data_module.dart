import 'package:flutter_modular/flutter_modular.dart';

class DIDataModule extends Module {
  @override
  void exportedBinds(i) {
    // i.addLazySingleton<BeaconEntryDaoInterface>(() => DriftDb.instance().beaconEntryDao);
  }
}
