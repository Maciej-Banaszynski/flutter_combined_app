import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../data/models/user/user.dart';

part 'data_management_state.freezed.dart';

@freezed
class DataManagementState with _$DataManagementState {
  const factory DataManagementState.initial() = Initial;
  const factory DataManagementState.loading() = Loading;
  const factory DataManagementState.loaded(List<User> users) = Loaded;
  const factory DataManagementState.count(int count) = Count;
  const factory DataManagementState.error(String message) = Error;
}
