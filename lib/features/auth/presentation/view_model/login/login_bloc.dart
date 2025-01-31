import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_nest/core/common/snackbar/my_snackbar.dart';
import 'package:open_nest/features/auth/domain/use_case/login_usecase.dart';
import 'package:open_nest/features/auth/presentation/view_model/signup/register_bloc.dart';
import 'package:open_nest/features/home/presentation/view/dashboard_view.dart';
import 'package:open_nest/features/home/presentation/view_model/dashboard_cubit.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final RegisterBloc _registerBloc;
  final DashboardCubit _dashboardCubit;
  final LoginUseCase _loginUseCase;

  LoginBloc({
    required RegisterBloc registerBloc,
    required DashboardCubit dashboardCubit,
    required LoginUseCase loginUseCase,
  })  : _registerBloc = registerBloc,
        _dashboardCubit = dashboardCubit,
        _loginUseCase = loginUseCase,
        super(LoginState.initial()) {
    on<NavigateRegisterScreenEvent>(
      (event, emit) {
        Navigator.push(
          event.context,
          MaterialPageRoute(
            builder: (context) => MultiBlocProvider(
              providers: [
                BlocProvider.value(value: _registerBloc),
              ],
              child: event.destination,
            ),
          ),
        );
      },
    );

    on<NavigateHomeScreenEvent>(
      (event, emit) {
        Navigator.pushReplacement(
          event.context,
          MaterialPageRoute(
            builder: (context) => BlocProvider.value(
              value: _dashboardCubit,
              child: event.destination,
            ),
          ),
        );
      },
    );

    on<LoginStudentEvent>(
      (event, emit) async {
        emit(state.copyWith(isLoading: true));
        final result = await _loginUseCase(
          LoginParams(
            username: event.username,
            password: event.password,
          ),
        );

        result.fold(
          (failure) {
            emit(state.copyWith(isLoading: false, isSuccess: false));
            showMySnackBar(
              context: event.context,
              message: failure.message,
>>>>>>> 67b5966 (file updating for merge clean archi)
              color: Colors.red,
            );
          },
          (token) {
            emit(state.copyWith(isLoading: false, isSuccess: true));
            add(
              NavigateHomeScreenEvent(
                context: event.context,
                destination: const DashboardView(),
              ),
            );
            //_homeCubit.setToken(token);
          },
        );
      },
    );
  }
}
