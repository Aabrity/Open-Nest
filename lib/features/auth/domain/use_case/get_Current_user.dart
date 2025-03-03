import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:open_nest/app/shared_prefs/token_shared_prefs.dart';
import 'package:open_nest/app/usecase/usecase.dart';
import 'package:open_nest/core/error/failure.dart';
import 'package:open_nest/features/auth/data/repository/auth_local_repository/auth_remote_repository.dart';
import 'package:open_nest/features/auth/domain/entity/auth_entity.dart';
import 'package:open_nest/features/auth/domain/repository/auth_repository.dart';

class FetchCurrentUserUseCase implements UsecaseWithoutParams<AuthEntity> {
  final IAuthRepository repository;
  final TokenSharedPrefs tokenSharedPrefs;

  FetchCurrentUserUseCase( {required this.repository,  required this.tokenSharedPrefs,});

@override
Future<Either<Failure, AuthEntity>> call() async {
  debugPrint('Fetching token from shared preferences...');
  final token = await tokenSharedPrefs.getToken();
  debugPrint('Token received: $token');

  debugPrint('Fetching user reference from shared preferences...');
  final userRef = await tokenSharedPrefs.getUserId();
  debugPrint('User reference received: $userRef');

  return userRef.fold((l) {
    debugPrint('Failed to get user reference: $l');
    return Left(l);
  }, (r) async {
    debugPrint('User reference successfully retrieved: $r');
    return token.fold(
      (failure) {
        debugPrint('Failed to get token: $failure');
        return Left(failure);
      },
      (tokenValue) async {
        debugPrint('Token successfully retrieved: $tokenValue');
        debugPrint('Fetching current user from repository...');
        final result = await repository.getCurrentUser(r, tokenValue);
        debugPrint('Current user fetch result: $result');
        return result;
      },
    );
  });
}
}
   