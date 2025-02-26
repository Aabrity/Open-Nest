import 'dart:io';

import 'package:open_nest/features/auth/domain/entity/auth_entity.dart';

abstract interface class IAuthDataSource {
  Future<String> loginUser(String username, String password);

  Future<void> registerUser(AuthEntity student);

  Future<AuthEntity> getCurrentUser(String token);

  Future<String> uploadProfilePicture(File file);
}
