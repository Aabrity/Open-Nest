// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_user_DTO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetUserDTO _$GetUserDTOFromJson(Map<String, dynamic> json) => GetUserDTO(
      success: json['success'] as bool,
      data: AuthApiModel.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetUserDTOToJson(GetUserDTO instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
    };
