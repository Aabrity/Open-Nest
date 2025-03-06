import 'package:dartz/dartz.dart';
import 'package:open_nest/app/shared_prefs/token_shared_prefs.dart';
import 'package:open_nest/app/usecase/usecase.dart';
import 'package:open_nest/core/error/failure.dart';
import 'package:open_nest/features/auth/data/repository/auth_local_repository/auth_remote_repository.dart';
import 'package:open_nest/features/auth/domain/entity/auth_entity.dart';
import 'package:open_nest/features/auth/domain/repository/auth_repository.dart';

class FetchUsernameByIdUseCase implements UsecaseWithParams<AuthEntity, String> {
  final IAuthRepository repository;
  final TokenSharedPrefs tokenSharedPrefs;

  FetchUsernameByIdUseCase({required this.repository, 
    required this.tokenSharedPrefs,
  });

  @override
  Future<Either<Failure, AuthEntity>> call(String id) async {
    final token = await tokenSharedPrefs.getToken();
    return token.fold(
      (failure) => Left(failure),
      (tokenValue) async {
        final result = await repository.getCurrentUser(id, tokenValue);
        return result;
      },
    );
  }
}