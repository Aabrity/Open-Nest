import 'package:bloc/bloc.dart';
import 'package:open_nest/features/home/presentation/view_model/dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit() : super(DashboardState(selectedNavIndex: 0));

  void selectNavIndex(int index) {
    emit(state.copyWith(selectedNavIndex: index));
  }

  void navigateToProfile() {
    emit(state.copyWith(navigateToProfile: true));
  }
}