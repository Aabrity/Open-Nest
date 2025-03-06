// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_like_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllLikeDTO _$GetAllLikeDTOFromJson(Map<String, dynamic> json) =>
    GetAllLikeDTO(
      success: json['success'] as bool,
      count: (json['count'] as num).toInt(),
      data: (json['data'] as List<dynamic>)
          .map((e) => LikeApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetAllLikeDTOToJson(GetAllLikeDTO instance) =>
    <String, dynamic>{
      'success': instance.success,
      'count': instance.count,
      'data': instance.data,
    };
