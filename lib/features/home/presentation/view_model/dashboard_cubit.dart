import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_nest/app/di/di.dart';
import 'package:open_nest/features/auth/presentation/view/login_view.dart';
import 'package:open_nest/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:open_nest/features/home/presentation/view_model/dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit() : super(DashboardState.initial());

    void onTabTapped(int index) {
    emit(state.copyWith(selectedIndex: index));
  }



   void logout(BuildContext context) {
    // Wait for 2 seconds
    Future.delayed(const Duration(seconds: 2), () async {
      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider.value(
              value: getIt<LoginBloc>(),
              child: LoginView(),
            ),
          ),
        );
      }
    });
  }
}