import 'package:flutter_modular/flutter_modular.dart';

import '../data/repositories/user_repository/user_repository.dart';
import '../data/repositories/user_repository/user_repository_interface.dart';
import 'di_data_module.dart';

class DiRepositoriesModule extends Module {
  @override
  List<Module> get imports => [
        DIDataModule(),
      ];

  @override
  void exportedBinds(i) {
    i.addLazySingleton<UserRepositoryInterface>(UserRepository.new);
    super.exportedBinds(i);
  }
}
