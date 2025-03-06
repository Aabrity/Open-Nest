import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:open_nest/core/error/failure.dart';
import 'package:open_nest/features/auth/domain/entity/auth_entity.dart';

abstract interface class IAuthDataSource {
  Future<String> loginUser(String username, String password);

  Future<void> registerUser(AuthEntity student);

  Future<AuthEntity> getCurrentUser(String id, String? token);

  Future<Either<Failure, void>> updateUser(String id, AuthEntity updatedUser, String token);

  Future<String> uploadProfilePicture(File file);
}
