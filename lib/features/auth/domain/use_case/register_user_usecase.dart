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
<<<<<<< HEAD
  final String? avatar;
=======
  final String? image;
>>>>>>> 834fbfd (register and upload image using api)

  const RegisterUserParams( {
    required this.username,
    required this.email,
    required this.password,
    this.isAdmin = false,
    this.subscription = false,
<<<<<<< HEAD
    this.avatar,
=======
    this.image,
>>>>>>> 834fbfd (register and upload image using api)
  });

    // Initial Constructor
  const RegisterUserParams.initial( {
        required this.username,
        required this.email,
        required this.password,
        required this.isAdmin,
        required this.subscription,
        this.image,
  });
  @override
  List<Object?> get props => [username, email, password, isAdmin, subscription,image];
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
      image:params.image,
    );
    return repository.registerUser(authEntity);
  }
}
