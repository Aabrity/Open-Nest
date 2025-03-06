import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:open_nest/core/error/failure.dart';
import 'package:open_nest/features/auth/domain/entity/auth_entity.dart';


abstract interface class IAuthRepository {
  Future<Either<Failure, void>> registerUser(AuthEntity user);

  Future<Either<Failure, String>> loginUser(
      String username, String password);

  Future<Either<Failure, String>> uploadProfilePicture(File file);
 Future<Either<Failure, void>> updateUser(String id, AuthEntity updatedUser, String token);
  Future<Either<Failure, AuthEntity>> getCurrentUser(String id, String? token);
}
