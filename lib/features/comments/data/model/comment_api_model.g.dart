// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentApiModel _$CommentApiModelFromJson(Map<String, dynamic> json) =>
    CommentApiModel(
      id: json['_id'] as String?,
      listing: json['listing'] as String,
      comment: json['comment'] as String,
    );

Map<String, dynamic> _$CommentApiModelToJson(CommentApiModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'listing': instance.listing,
      'comment': instance.comment,
    };
