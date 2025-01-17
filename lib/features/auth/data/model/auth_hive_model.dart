import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:open_nest/app/constants/hive_table_constant.dart';
import 'package:open_nest/features/auth/domain/entity/auth_entity.dart';
import 'package:uuid/uuid.dart';


part 'auth_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.userTableId) // Replace `0` with the actual constant from HiveTableConstant if needed.
class AuthHiveModel extends Equatable {
  @HiveField(0)
  final String? userId;

  @HiveField(1)
  final String username;

  @HiveField(2)
  final String email;

  @HiveField(3)
  final String password;

  @HiveField(4)
  final String? avatar;

  @HiveField(5)
  final bool isAdmin;

  @HiveField(6)
  final bool subscription;

  AuthHiveModel({
    String? userId,
    required this.username,
    required this.email,
    required this.password,
    this.avatar,
    this.isAdmin = false,
    this.subscription = false,
  }) : userId = userId ?? const Uuid().v4();

  // Initial Constructor
  const AuthHiveModel.initial()
      : userId = null,
        username = '',
        email = '',
        password = '',
        avatar = '',
        isAdmin = false,
        subscription = false;

  // From Entity
  factory AuthHiveModel.fromEntity(AuthEntity entity) {
    return AuthHiveModel(
      userId: entity.userId,
      username: entity.username,
      email: entity.email,
      password: entity.password,
      avatar: entity.avatar,
      isAdmin: entity.isAdmin,
      subscription: entity.subscription,
    );
  }

  // To Entity
  AuthEntity toEntity() {
    return AuthEntity(
      userId: userId,
      username: username,
      email: email,
      password: password,
      avatar: avatar,
      isAdmin: isAdmin,
      subscription: subscription,
    );
  }

  @override
  List<Object?> get props =>
      [userId, username, email, password, avatar, isAdmin, subscription];
}
