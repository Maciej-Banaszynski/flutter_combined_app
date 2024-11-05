import 'package:flutter_modular/flutter_modular.dart';

class DIConfigModule extends Module {
  @override
  void exportedBinds(i) {
    // i.addLazySingleton<SharedPreferencesInterface>(SharedPrefs.new);

    super.exportedBinds(i);
  }
}
