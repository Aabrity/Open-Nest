// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_user_DTO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetUserDTO _$GetUserDTOFromJson(Map<String, dynamic> json) => GetUserDTO(
      success: json['success'] as bool,
      count: (json['count'] as num).toInt(),
      data: (json['data'] as List<dynamic>)
          .map((e) => CommentApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetUserDTOToJson(GetUserDTO instance) =>
    <String, dynamic>{
      'success': instance.success,
      'count': instance.count,
      'data': instance.data,
    };
