import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:open_nest/app/usecase/usecase.dart';
import 'package:open_nest/core/error/failure.dart';
import 'package:open_nest/features/auth/domain/repository/auth_repository.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
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
        (token) async {
          await tokenSharedPrefs.saveToken(token);
        final savedToken = await tokenSharedPrefs.getToken();
        print(savedToken);

        final Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
        final String? userId = decodedToken['id'];

        if (userId != null) {
          await tokenSharedPrefs.saveUserId(userId);
          debugPrint("User ID saved: $userId");
        } else {
          debugPrint("User ID not found in token!");
        }
        return Right(token);
        },
      );
    });

    
  }
}
