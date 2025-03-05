import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:open_nest/core/error/failure.dart';
import 'package:open_nest/core/network/hive_service.dart';
import 'package:open_nest/features/auth/data/data_source/auth_data_source.dart';
import 'package:open_nest/features/auth/data/model/auth_hive_model.dart';
import 'package:open_nest/features/auth/domain/entity/auth_entity.dart';

class AuthLocalDataSource implements IAuthDataSource {
  final HiveService _hiveService;

  AuthLocalDataSource(this._hiveService);

  @override
  Future<AuthEntity> getCurrentUser(String id, String? token) {
    // Return Empty AuthEntity
    return Future.value(const AuthEntity(
       userId: "",
        username: "",
        email: "",
        password: "",
        avatar:"",
        isAdmin: false,
        subscription: false,
    ));
  }

  @override
  Future<String> loginUser(String username, String password) async {
    try {
      await _hiveService.login(username, password);
      return Future.value("Success");
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future<void> registerUser(AuthEntity user) async {
    try {
      // Convert AuthEntity to AuthHiveModel
      final authHiveModel = AuthHiveModel.fromEntity(user);

      await _hiveService.registerAuth(authHiveModel);
      return Future.value();
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future<String> uploadProfilePicture(File file) {
    throw UnimplementedError();
  }

  @override
   Future<Either<Failure, void>> updateUser(
      String id, AuthEntity updatedUser, String token) async {
    try {
      final existingUser = await _hiveService.getProfile(id);
      if (existingUser == null) {
        return Left(LocalDatabaseFailure(message: "User not found")); 
      }
      final updatedHiveModel = AuthHiveModel.fromEntity(updatedUser);
      await _hiveService.updateProfile(updatedHiveModel);
      return const Right(null);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString())); 
    }
  }
}
