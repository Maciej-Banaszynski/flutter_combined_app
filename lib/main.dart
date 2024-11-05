import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'app/app.dart';
import 'app/app_module.dart';

Future<void> main() async {
  runApp(
    ModularApp(
      module: AppModule(),
      child: const App(),
    ),
  );
}
