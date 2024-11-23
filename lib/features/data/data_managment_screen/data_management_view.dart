import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../common/widgets/app_scaffold/app_scaffold.dart';
import '../../../data/models/user/user.dart';
import 'cubit/data_management_cubit.dart';
import 'cubit/data_management_state.dart';

class DataManagementView extends HookWidget {
  const DataManagementView({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppScaffold(
      screenTitle: "Data",
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _TopSection(),
            _ButtonsSection(),
          ],
        ),
      ),
    );
  }
}

class _TopSection extends StatelessWidget {
  const _TopSection();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DataManagementCubit, DataManagementState>(
      builder: (context, state) {
        return state.mapOrNull(
              loading: (_) => const CircularProgressIndicator(),
              loaded: (state) => Text(
                "Total users: ${state.users.length}",
                style: const TextStyle(fontSize: 20),
              ),
              error: (state) => Text(
                "Error: ${state.message}",
                style: const TextStyle(color: Colors.red),
                maxLines: 3,
              ),
            ) ??
            const SizedBox.shrink();
      },
    );
  }
}

class _ButtonsSection extends StatelessWidget {
  const _ButtonsSection();

  DataManagementCubit _cubit(BuildContext context) => context.read<DataManagementCubit>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Select number of users to generate:"),
        ElevatedButton(
          onPressed: () async => await _cubit(context).insertGeneratedUsers(GeneratedUsersCount.thousand),
          child: const Text("1,000"),
        ),
        ElevatedButton(
          onPressed: () => _cubit(context).insertGeneratedUsers(GeneratedUsersCount.tenThousand),
          child: const Text("10,000"),
        ),
        ElevatedButton(
          onPressed: () => _cubit(context).insertGeneratedUsers(GeneratedUsersCount.thirtyThousand),
          child: const Text("30,000"),
        ),
        ElevatedButton(
          onPressed: () async => await _cubit(context).loadUsers(),
          child: const Text("Fetch Users by Company"),
        ),
        ElevatedButton(
          onPressed: () async => await _cubit(context).batchUpdate(),
          child: const Text("Update Users"),
        ),
        ElevatedButton(
          onPressed: () => _cubit(context).deleteAllUsers(),
          child: const Text("Delete All Users"),
        ),
      ],
    );
  }
}
