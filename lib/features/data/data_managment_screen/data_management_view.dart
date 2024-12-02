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
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _TopSection(),
              SizedBox(height: 20),
              _ButtonsSection(),
            ],
          ),
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
              loading: (_) => const Center(child: CircularProgressIndicator()),
              loaded: (state) => Center(
                child: Text(
                  "Total users: ${state.users.length}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 20),
                ),
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
    final state = context.select((DataManagementCubit cubit) => cubit.state);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text("Select number of users to generate:"),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: GeneratedUsersCount.values.map((count) {
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: ElevatedButton(
                  onPressed: state is Loading ? null : () async => await _cubit(context).insertGeneratedUsers(count),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6.0),
                    child: Text("Load\n${count.displayName}", textAlign: TextAlign.center),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: ElevatedButton(
                  onPressed: () async => await _cubit(context).getOnlyLeadUsers(),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 6.0),
                    child: Text("Get only\nLeads", textAlign: TextAlign.center),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: ElevatedButton(
                  onPressed: () async => await _cubit(context).loadUsers(),
                  child: const Text("Get All", textAlign: TextAlign.center),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: ElevatedButton(
                  onPressed: () => _cubit(context).deleteAllUsers(),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 6.0),
                    child: Text("Delete\nAll Users", textAlign: TextAlign.center),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
