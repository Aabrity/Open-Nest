import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:open_nest/features/auth/domain/entity/auth_entity.dart';

part 'auth_api_model.g.dart';

@JsonSerializable()
class AuthApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? id;
  final String username;
  final String email;
  final String? password;
  final String avatar;
  final bool isAdmin;
  final bool subscription;

  const AuthApiModel({
    this.id,
    required this.username,
    required this.email,
    required this.password,
    required this.avatar,
    this.isAdmin = false,
    this.subscription = false,
  });

  factory AuthApiModel.fromJson(Map<String, dynamic> json) =>
      _$AuthApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthApiModelToJson(this);

  // To Entity
  AuthEntity toEntity() {
    return AuthEntity(
      userId: id,
      username: username,
      email: email,
      password: password ?? '',
      avatar: avatar,
      isAdmin: isAdmin,
      subscription: subscription,
    );
  }

  // From Entity 
  factory AuthApiModel.fromEntity(AuthEntity entity) {
    return AuthApiModel(
      username: entity.username,  
      email: entity.email,
      password: entity.password,
      avatar: entity.avatar,
      isAdmin: entity.isAdmin,
      subscription: entity.subscription,
    );
  }

  
  // Convert List of CommentApiModel to List of CommentEntity
  static List<AuthEntity> toEntityList(List<AuthApiModel> models) {
    return models.map((model) => model.toEntity()).toList();
  }

  // Convert List of CommentEntity to List of CommentApiModel
  static List<AuthApiModel> fromEntityList(List<AuthEntity> entities) {
    return entities.map((entity) => AuthApiModel.fromEntity(entity)).toList();
  }

  @override
  List<Object?> get props =>
      [id, username, email, password, avatar, isAdmin, subscription];
}
