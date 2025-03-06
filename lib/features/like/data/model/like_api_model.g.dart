// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'like_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LikeApiModel _$LikeApiModelFromJson(Map<String, dynamic> json) => LikeApiModel(
      id: json['_id'] as String?,
      listing: json['listing'] as String,
      user: json['user'] as String,
    );

Map<String, dynamic> _$LikeApiModelToJson(LikeApiModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'listing': instance.listing,
      'user': instance.user,
    };
