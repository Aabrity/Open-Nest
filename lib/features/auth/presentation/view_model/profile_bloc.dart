

// import 'package:dartz/dartz.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:open_nest/core/error/failure.dart';
// import 'package:open_nest/features/auth/domain/entity/auth_entity.dart';
// import 'package:open_nest/features/auth/domain/use_case/get_Current_user.dart';
// import 'package:open_nest/features/auth/domain/use_case/update_user.dart';
// import 'package:open_nest/features/auth/presentation/view_model/profile_event.dart';
// import 'package:open_nest/features/auth/presentation/view_model/profile_state.dart';

// class UserBloc extends Bloc<UserEvent, UserState> {
//   final FetchCurrentUserUseCase fetchCurrentUserUseCase;
//   final UpdateUserUsecase updateUserUsecase;

//   UserBloc({
//     required this.fetchCurrentUserUseCase,
//     required this.updateUserUsecase,
//   }) : super(UserInitial()) {
//     on<FetchUserEvent>(_onFetchUserEvent);
//     on<UpdateUserEvent>(_onUpdateUserEvent);
//   }

//   Future<void> _onFetchUserEvent(FetchUserEvent event, Emitter<UserState> emit) async {
//     emit(UserLoading());

//     final Either<Failure, AuthEntity> result = await fetchCurrentUserUseCase();

//     result.fold(
//       (failure) => emit(UserError(failure.message)),
//       (authEntity) => emit(
//         UserLoaded(
//           username: authEntity.username,
//           email: authEntity.email,
//           userId: authEntity.userId!,
//           avatarBase64: authEntity.avatar,
//           isAdmin: authEntity.isAdmin,
//           subscription: authEntity.subscription,
//         ),
//       ),
//     );
//   }

//   Future<void> _onUpdateUserEvent(UpdateUserEvent event, Emitter<UserState> emit) async {
//     emit(UserLoading());

//     final result = await updateUserUsecase(event.params);

//     result.fold(
//       (failure) => emit(UserError(failure.message)),
//       (_) => emit(UserUpdated()),
//     );
//   }
// }



// import 'package:dartz/dartz.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:open_nest/core/error/failure.dart';
// import 'package:open_nest/features/auth/domain/entity/auth_entity.dart';
// import 'package:open_nest/features/auth/domain/use_case/get_Current_user.dart';
// import 'package:open_nest/features/auth/domain/use_case/update_user.dart';
// import 'package:open_nest/features/auth/presentation/view_model/profile_event.dart';
// import 'package:open_nest/features/auth/presentation/view_model/profile_state.dart';

// class UserBloc extends Bloc<UserEvent, UserState> {
//   final FetchCurrentUserUseCase fetchCurrentUserUseCase;
//   final UpdateUserUsecase updateUserUsecase;

//   UserBloc({
//     required this.fetchCurrentUserUseCase,
//     required this.updateUserUsecase,
//   }) : super(UserInitial()) {
//     on<FetchUserEvent>(_onFetchUserEvent);
//     on<UpdateUserEvent>(_onUpdateUserEvent);
//   }

//   Future<void> _onFetchUserEvent(FetchUserEvent event, Emitter<UserState> emit) async {
//     emit(UserLoading());

//     final Either<Failure, AuthEntity> result = await fetchCurrentUserUseCase();

//     result.fold(
//       (failure) => emit(UserError(failure.message)),
//       (authEntity) => emit(
//         UserLoaded(
//           username: authEntity.username,
//           email: authEntity.email,
//           userId: authEntity.userId!,
//           avatarBase64: authEntity.avatar,
//           isAdmin: authEntity.isAdmin,
//           subscription: authEntity.subscription,
//         ),
//       ),
//     );
//   }

//   Future<void> _onUpdateUserEvent(UpdateUserEvent event, Emitter<UserState> emit) async {
//     emit(UserLoading());

//     final updateResult = await updateUserUsecase(event.params);

//     updateResult.fold(
//       (failure) => emit(UserError(failure.message)),
//       (_) async {
//         // After a successful update, fetch the latest user data
//         final fetchResult = await fetchCurrentUserUseCase();

//         fetchResult.fold(
//           (failure) => emit(UserError(failure.message)),
//           (authEntity) => emit(
//             UserLoaded(
//               username: authEntity.username,
//               email: authEntity.email,
//               userId: authEntity.userId!,
//               avatarBase64: authEntity.avatar,
//               isAdmin: authEntity.isAdmin,
//               subscription: authEntity.subscription,
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_nest/core/error/failure.dart';
import 'package:open_nest/features/auth/domain/entity/auth_entity.dart';
import 'package:open_nest/features/auth/domain/use_case/get_Current_user.dart';
import 'package:open_nest/features/auth/domain/use_case/update_user.dart';
import 'package:open_nest/features/auth/presentation/view_model/profile_event.dart';
import 'package:open_nest/features/auth/presentation/view_model/profile_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final FetchCurrentUserUseCase fetchCurrentUserUseCase;
  final UpdateUserUsecase updateUserUsecase;

  UserBloc({
    required this.fetchCurrentUserUseCase,
    required this.updateUserUsecase,
  }) : super(UserInitial()) {
    on<FetchUserEvent>(_onFetchUserEvent);
    on<UpdateUserEvent>(_onUpdateUserEvent);
  }

  Future<void> _onFetchUserEvent(FetchUserEvent event, Emitter<UserState> emit) async {
    emit(UserLoading());

    final Either<Failure, AuthEntity> result = await fetchCurrentUserUseCase();

    result.fold(
      (failure) => emit(UserError(failure.message)),
      (authEntity) => emit(
        UserLoaded(
          username: authEntity.username,
          email: authEntity.email,
          userId: authEntity.userId!,
          avatarBase64: authEntity.avatar,
          isAdmin: authEntity.isAdmin,
          subscription: authEntity.subscription,
        ),
      ),
    );
  }

  Future<void> _onUpdateUserEvent(UpdateUserEvent event, Emitter<UserState> emit) async {
  emit(UserLoading());

  final updateResult = await updateUserUsecase(event.params);

  await updateResult.fold(
    (failure) async {
      emit(UserError(failure.message));
    },
    (_) async {
      // After a successful update, fetch the latest user data
      final fetchResult = await fetchCurrentUserUseCase();

      await fetchResult.fold(
        (failure) async {
          emit(UserError(failure.message));
        },
        (authEntity) async {
          emit(
            UserLoaded(
              username: authEntity.username,
              email: authEntity.email,
              userId: authEntity.userId!,
              avatarBase64: authEntity.avatar,
              isAdmin: authEntity.isAdmin,
              subscription: authEntity.subscription,
            ),
          );
        },
      );
    },
  );
}}