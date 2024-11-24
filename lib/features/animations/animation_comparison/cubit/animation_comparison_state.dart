import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../data/models/user/user.dart';

part 'animation_comparison_state.freezed.dart';

@freezed
class AnimationComparisonState with _$AnimationComparisonState {
  const factory AnimationComparisonState({
    @Default([]) List<User> listOfUsers,
  }) = _AnimationComparisonState;
}
