import 'package:dartz/dartz.dart';
import 'package:open_nest/app/shared_prefs/token_shared_prefs.dart';
import 'package:open_nest/app/usecase/usecase.dart';
import 'package:open_nest/core/error/failure.dart';
import 'package:open_nest/features/auth/domain/entity/auth_entity.dart';
import 'package:open_nest/features/auth/domain/repository/auth_repository.dart';

class FetchCurrentUserUseCase implements UsecaseWithParams<AuthEntity, String> {
  final IAuthRepository repository;
  final TokenSharedPrefs tokenSharedPrefs;

  FetchCurrentUserUseCase({required this.repository,  required this.tokenSharedPrefs,});

  @override
  Future<Either<Failure, AuthEntity>> call(String token) async {
     final token = await tokenSharedPrefs.getToken();
    return token.fold((l) {
      return Left(l);
    }, (r) async {
    return await repository.getCurrentUser(r);
    });
  }
}