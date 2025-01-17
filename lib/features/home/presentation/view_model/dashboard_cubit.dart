import 'package:flutter_bloc/flutter_bloc.dart';
import 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit() : super(DashboardState(selectedNavIndex: 0));

  void selectNavIndex(int index) {
    // Emit a new state with the updated selected index
    emit(state.copyWith(selectedNavIndex: index));
  }
}
