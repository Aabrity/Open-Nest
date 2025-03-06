// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'listing_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListingApiModel _$ListingApiModelFromJson(Map<String, dynamic> json) =>
    ListingApiModel(
      listingId: json['_id'] as String?,
      name: json['name'] as String,
      description: json['description'] as String,
      address: json['address'] as String,
      regularPrice: (json['regularPrice'] as num).toInt(),
      discountedPrice: (json['discountPrice'] as num?)?.toInt(),
      bathrooms: (json['bathrooms'] as num).toInt(),
      bedrooms: (json['bedrooms'] as num).toInt(),
      furnished: json['furnished'] as bool,
      parking: json['parking'] as bool,
      type: json['type'] as String,
      offer: json['offer'] as bool,
      imageUrls:
          (json['imageUrls'] as List<dynamic>).map((e) => e as String).toList(),
      userRef: json['userRef'] as String,
    );

Map<String, dynamic> _$ListingApiModelToJson(ListingApiModel instance) =>
    <String, dynamic>{
      '_id': instance.listingId,
      'name': instance.name,
      'description': instance.description,
      'address': instance.address,
      'regularPrice': instance.regularPrice,
      'discountPrice': instance.discountedPrice,
      'bathrooms': instance.bathrooms,
      'bedrooms': instance.bedrooms,
      'furnished': instance.furnished,
      'parking': instance.parking,
      'type': instance.type,
      'offer': instance.offer,
      'imageUrls': instance.imageUrls,
      'userRef': instance.userRef,
    };
