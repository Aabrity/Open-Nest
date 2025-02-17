// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_comment_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllCommentDTO _$GetAllCommentDTOFromJson(Map<String, dynamic> json) =>
    GetAllCommentDTO(
      success: json['success'] as bool,
      count: (json['count'] as num).toInt(),
      data: (json['data'] as List<dynamic>)
          .map((e) => CommentApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetAllCommentDTOToJson(GetAllCommentDTO instance) =>
    <String, dynamic>{
      'success': instance.success,
      'count': instance.count,
      'data': instance.data,
    };
