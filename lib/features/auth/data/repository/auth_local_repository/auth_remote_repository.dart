import 'dart:io';

import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../domain/entity/auth_entity.dart';
import '../../../domain/repository/auth_repository.dart';
import '../../data_source/remote_data_source/auth_remote_data_source.dart';

class AuthRemoteRepository implements IAuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;

  AuthRemoteRepository(this._authRemoteDataSource);

  @override
  Future<Either<Failure, void>> registerUser(AuthEntity user) async {
    try {
      await _authRemoteDataSource.registerUser(user);
      return Right(null);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }


  @override
  Future<Either<Failure, String>> loginUser(
      String username, String password) async {
      try {
      final token =
          await _authRemoteDataSource.loginUser(username, password);
      return Right(token);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> uploadProfilePicture(File file) async {
    try {
      final imageName = await _authRemoteDataSource.uploadProfilePicture(file);
      return Right(imageName);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, AuthEntity>> getCurrentUser(String id, String? token) async {
     try {
      final response =
          await _authRemoteDataSource.getCurrentUser(id, token);
      return Right(response);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, void>> updateUser(String id, AuthEntity updatedUser, String token) async {
    try {
      await _authRemoteDataSource.updateUser(id, updatedUser, token);
      return Right(null);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }
}
