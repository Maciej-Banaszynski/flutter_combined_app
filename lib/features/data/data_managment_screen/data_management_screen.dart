import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'cubit/data_management_cubit.dart';
import 'data_management_view.dart';

class DataManagementScreen extends StatelessWidget {
  const DataManagementScreen({super.key});

  static const String route = '/data_management';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => Modular.get<DataManagementCubit>(),
      child: const DataManagementView(),
    );
  }
}
