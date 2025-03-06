// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_listing_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllListingDTO _$GetAllListingDTOFromJson(Map<String, dynamic> json) =>
    GetAllListingDTO(
      success: json['success'] as bool,
      count: (json['count'] as num).toInt(),
      data: (json['data'] as List<dynamic>)
          .map((e) => ListingApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetAllListingDTOToJson(GetAllListingDTO instance) =>
    <String, dynamic>{
      'success': instance.success,
      'count': instance.count,
      'data': instance.data,
    };
