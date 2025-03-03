import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:open_nest/features/auth/domain/entity/auth_entity.dart';
import 'package:open_nest/core/error/failure.dart';
import 'package:open_nest/features/auth/domain/repository/auth_repository.dart';
import 'package:open_nest/app/shared_prefs/token_shared_prefs.dart';
import 'package:open_nest/app/usecase/usecase.dart';
import 'package:open_nest/features/auth/domain/use_case/get_user_by_id_for_comment.dart';

class UserCubit extends Cubit<UserState> {
  final FetchUsernameByIdUseCase fetchUsernameByIdUseCase;

  UserCubit({required this.fetchUsernameByIdUseCase}) : super(UserInitial());

  Future<void> fetchUserById(String userId) async {
    emit(UserLoading());
    final result = await fetchUsernameByIdUseCase(userId);
    result.fold(
      (failure) => emit(UserError(failure)),
      (user) => emit(UserLoaded(user)),
    );
  }
}

// States for UserCubit
abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final AuthEntity user;
  UserLoaded(this.user);
}

class UserError extends UserState {
  final Failure failure;
  UserError(this.failure);
}