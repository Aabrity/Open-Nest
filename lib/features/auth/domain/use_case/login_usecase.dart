import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:open_nest/app/usecase/usecase.dart';
import 'package:open_nest/core/error/failure.dart';
import 'package:open_nest/features/auth/domain/repository/auth_repository.dart';

import '../../../../app/shared_prefs/token_shared_prefs.dart';


class LoginParams extends Equatable {
  final String username;
  final String password;

  const LoginParams({
    required this.username,
    required this.password,
  });

  // Initial Constructor
  const LoginParams.initial()
      : username = '',
        password = '';

  @override
  List<Object> get props => [username, password];
}

class LoginUseCase implements UsecaseWithParams<String, LoginParams> {
  final IAuthRepository repository;
  final TokenSharedPrefs tokenSharedPrefs;

  LoginUseCase(this.repository, this.tokenSharedPrefs);

  @override
  Future<Either<Failure, String>> call(LoginParams params) async {
    // Save token in Shared Preferences
    return repository
        .loginUser(params.username, params.password)
        .then((value) {
      return value.fold(
        (failure) => Left(failure),
        (token) {
          tokenSharedPrefs.saveToken(token);
          tokenSharedPrefs.getToken().then((value) {
            print(value);
          });
          return Right(token);
        },
      );
    });
  //  Future<Either<Failure, String>> call(LoginParams params) async {
  //   // Perform login
  //   final result = await repository.loginUser(params.username, params.password);
    
  //   return result.fold(
  //     (failure) => Left(failure), // Return failure if login fails
  //     (token) async {
  //       // Save token in Shared Preferences
  //       await tokenSharedPrefs.saveToken(token);
        
  //       // Retrieve token from Shared Preferences to confirm it
  //       final savedToken = await tokenSharedPrefs.getToken();
  //       print(savedToken); // For debugging purposes
        
  //       return Right(savedToken);
  //       },
  //   );
    
  }
}
