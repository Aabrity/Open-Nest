import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:open_nest/features/auth/presentation/view_model/login/login_bloc.dart';

class OnboardingCubit extends Cubit<int> {
  OnboardingCubit(LoginBloc loginBloc) : super(0); // Initially at page 0

  void goToNextPage() {
    emit(state + 1);
  }

  void goToPreviousPage() {
    emit(state - 1);
  }

  void goToPage(int index) {
    emit(index);
  }

  bool isLastPage() {
    return state == 4; // The last page is index 4
  }
}
