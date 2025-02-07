import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:open_nest/app/usecase/usecase.dart';
import 'package:open_nest/core/error/failure.dart';
import 'package:open_nest/features/auth/domain/entity/auth_entity.dart';
import 'package:open_nest/features/auth/domain/repository/auth_repository.dart';


class RegisterUserParams extends Equatable {
  final String username;
  final String email;
  final String password;
  final bool isAdmin;
  final bool subscription;
  final String avatar;

  const RegisterUserParams( {
    required this.username,
    required this.email,
    required this.password,
    this.isAdmin = false,
    this.subscription = false,
    required this.avatar,
  });

    // Initial Constructor
  const RegisterUserParams.initial( {
        required this.username,
        required this.email,
        required this.password,
        this.isAdmin=false,
        this.subscription = false,
        required this.avatar,
  });
  @override
  List<Object?> get props => [username, email, password, isAdmin, subscription, avatar];
}

class RegisterUseCase implements UsecaseWithParams<void, RegisterUserParams> {
  final IAuthRepository repository;

  RegisterUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(RegisterUserParams params) {
    final authEntity = AuthEntity(
      username: params.username,
      email: params.email,
      password: params.password,
      isAdmin: params.isAdmin,
      subscription: params.subscription,
      avatar:params.avatar,
    );
    return repository.registerUser(authEntity);
  }
}
