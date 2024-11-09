import 'dart:async';

import 'package:bloc/bloc.dart';

import '../../../../data/repositories/user_repository/user_repository_interface.dart';
import 'data_management_state.dart';

class DataManagementCubit extends Cubit<DataManagementState> {
  DataManagementCubit(this._userRepository) : super(const DataManagementState.initial()) {
    loadUsers();
  }

  final UserRepositoryInterface _userRepository;

  Future<void> loadUsers() async {
    emit(const Loading());
    try {
      final users = await _userRepository.getAllUsers();
      emit(Loaded(users));
    } catch (e) {
      emit(Error("Failed to load users: $e"));
    }
  }

  Future<void> generateAndInsertUsers(int count) async {
    emit(const Loading());
    try {
      await _userRepository.generateAndInsertUsers(count);
      await loadUsers();
    } catch (e) {
      print(e);
      emit(Error("Failed to insert users: $e"));
    }
  }

  Future<void> deleteAllUsers() async {
    emit(const Loading());
    try {
      await _userRepository.deleteAllData();
      emit(const Loaded([]));
    } catch (e) {
      emit(Error("Failed to delete users: $e"));
    }
  }

  Future<void> batchUpdate() async {
    emit(const Loading());
    try {
      final users = await _userRepository.getAllUsers();
      for (final user in users) {
        await _userRepository.insertUser(user.copyWith(position: "Developer"));
      }
    } catch (e) {
      print(e);
    }
    await loadUsers();
  }
}
