// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthApiModel _$AuthApiModelFromJson(Map<String, dynamic> json) => AuthApiModel(
      id: json['_id'] as String?,
      username: json['username'] as String,
      email: json['email'] as String,
      password: json['password'] as String?,
      avatar: json['avatar'] as String,
      isAdmin: json['isAdmin'] as bool? ?? false,
      subscription: json['subscription'] as bool? ?? false,
    );

Map<String, dynamic> _$AuthApiModelToJson(AuthApiModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'username': instance.username,
      'email': instance.email,
      'password': instance.password,
      'avatar': instance.avatar,
      'isAdmin': instance.isAdmin,
      'subscription': instance.subscription,
    };
