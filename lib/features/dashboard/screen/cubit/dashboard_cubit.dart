import 'package:flutter_bloc/flutter_bloc.dart';

import 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit() : super(DashboardState());

  void onSelectedIndexChanged(int selectedIndex) {
    emit(state.copyWith(selectedViewIndex: selectedIndex));
  }
}
