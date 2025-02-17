import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:open_nest/features/auth/data/model/auth_api_model.dart';
import 'package:open_nest/features/listing/domain/entity/listing_entity.dart';

part 'listing_api_model.g.dart';

@JsonSerializable()
class ListingApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? listingId;
  final String name;
  final String description;
  final String address;
  final int regularPrice;
  final int discountedPrice;
  final int bathrooms;
  final int bedrooms;
  final bool furnished;
  final bool parking;
  final String type;
  final bool offer;
  final List<String> imageUrls;


  const ListingApiModel({
    this.listingId,
    required this.name,
    required this.description,
    required this.address,
    required this.regularPrice,
    required this.discountedPrice,
    required this.bathrooms,
    required this.bedrooms,
    required this.furnished,
    required this.parking,
    required this.type,
    required this.offer,
    required this.imageUrls,
  
  });

  factory ListingApiModel.fromJson(Map<String, dynamic> json) => _$ListingApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$ListingApiModelToJson(this);

  // To Entity
  ListingEntity toEntity() {
    return ListingEntity(
      listingId: listingId,
      name: name,
      description: description,
      address: address,
      regularPrice: regularPrice,
      discountedPrice: discountedPrice,
      bathrooms: bathrooms,
      bedrooms: bedrooms,
      furnished: furnished,
      parking: parking,
      type: type,
      offer: offer,
      imageUrls: imageUrls,
     
    );
  }

  // From Entity
  factory ListingApiModel.fromEntity(ListingEntity entity) {
    return ListingApiModel(
      listingId: entity.listingId,
      name: entity.name,
      description: entity.description,
      address: entity.address,
      regularPrice: entity.regularPrice,
      discountedPrice: entity.discountedPrice,
      bathrooms: entity.bathrooms,
      bedrooms: entity.bedrooms,
      furnished: entity.furnished,
      parking: entity.parking,
      type: entity.type,
      offer: entity.offer,
      imageUrls: entity.imageUrls,
    
    );
  }

  //convert API list to Entity List
  static List<ListingEntity> toEntityList(List<ListingApiModel> models) =>
    models.map((model) => model.toEntity()).toList();


  @override
  List<Object?> get props => [
        listingId,
        name,
        description,
        address,
        regularPrice,
        discountedPrice,
        bathrooms,
        bedrooms,
        furnished,
        parking,
        type,
        offer,
        imageUrls,
      
      ];
}
