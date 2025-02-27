import 'package:equatable/equatable.dart';
import 'package:dartz/dartz.dart';
import 'package:open_nest/app/shared_prefs/token_shared_prefs.dart';
import 'package:open_nest/app/usecase/usecase.dart';
import 'package:open_nest/core/error/failure.dart';
import 'package:open_nest/features/auth/data/repository/auth_local_repository/auth_remote_repository.dart';
import 'package:open_nest/features/auth/domain/entity/auth_entity.dart';
import 'package:open_nest/features/auth/domain/repository/auth_repository.dart';

class UpdateUserParams extends Equatable {
  final String username;
  final String email;
  final String avatar;
  final String? password;

  const UpdateUserParams({
    required this.username,
    required this.email,
    required this.avatar,
    this.password,
  });

  @override
  List<Object?> get props => [username, email, avatar, password];
}

class UpdateUserUsecase implements UsecaseWithParams<void, UpdateUserParams> {
  final IAuthRepository _authRepository;
  final TokenSharedPrefs tokenSharedPrefs;

  UpdateUserUsecase({
    required this.tokenSharedPrefs,
    required IAuthRepository authRepository, 
  }) : _authRepository = authRepository;

  @override
  Future<Either<Failure, void>> call(UpdateUserParams params) async {
    final token = await tokenSharedPrefs.getToken();
    final userId = await tokenSharedPrefs.getUserId();

    return userId.fold(
      (l) => Left(l),
      (r) async {
        return token.fold(
          (failure) => Left(failure),
          (tokenValue) async => _authRepository.updateUser(
            r,
            AuthEntity(
              userId: r,
              username: params.username,
              email: params.email,
              password: params.password!,
              avatar: params.avatar,
              isAdmin: false, // Not updating admin status
              subscription: false, // Not updating subscription
            ),
            tokenValue,
          ),
        );
      },
    );
  }
}
