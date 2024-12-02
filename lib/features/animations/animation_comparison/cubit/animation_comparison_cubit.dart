import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:faker/faker.dart';
import 'package:flutter/foundation.dart';

import '../../../../data/models/user/user.dart';
import '../../../../data/repositories/user_repository/user_repository_interface.dart';
import 'animation_comparison_state.dart';

class AnimationComparisonCubit extends Cubit<AnimationComparisonState> {
  AnimationComparisonCubit(this._userRepository) : super(const AnimationComparisonState());
  final UserRepositoryInterface _userRepository;
  // final MetricsManager _metricsManager;

  Future<void> loadUsers(int count) async {
    try {
      final faker = Faker();
      for (int i = 0; i < count; i++) {
        final user = User(
          id: 0,
          firstName: faker.person.firstName(),
          lastName: faker.person.lastName(),
          birthDate: faker.date.dateTime(minYear: 1950, maxYear: 2000),
          address: faker.address.streetAddress(),
          phoneNumber: faker.phoneNumber.us(),
          position: faker.job.title(),
          company: faker.company.name(),
        );
        emit(state.copyWith(listOfUsers: state.listOfUsers + [user]));
      }
    } catch (e) {
      if (kDebugMode) print(e);
    }
  }

  void clearUsers() => emit(state.copyWith(listOfUsers: []));

  // Future<T?> trackAction<T>(String actionName, Future<T> Function() action) async =>
  // await _metricsManager.trackAction(actionName, action);
}
