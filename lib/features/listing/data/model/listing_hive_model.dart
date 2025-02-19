import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:open_nest/app/constants/hive_table_constant.dart';
import 'package:open_nest/features/auth/data/model/auth_hive_model.dart';
import 'package:open_nest/features/listing/domain/entity/listing_entity.dart';
import 'package:uuid/uuid.dart';

part 'listing_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.listingTableId)
class ListingHiveModel extends Equatable {
  @HiveField(0)
  final String listingId;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final String address;

  @HiveField(4)
  final int regularPrice;

  @HiveField(5)
  final int? discountedPrice;

  @HiveField(6)
  final int bathrooms;

  @HiveField(7)
  final int bedrooms;

  @HiveField(8)
  final bool furnished;

  @HiveField(9)
  final bool parking;

  @HiveField(10)
  final String type;

  @HiveField(11)
  final bool offer;

  @HiveField(12)
  final List<String> imageUrls;

  @HiveField(13)
  final String userRef; 

 

  ListingHiveModel({
    String? listingId,
    required this.name,
    required this.description,
    required this.address,
    required this.regularPrice,
    this.discountedPrice,
    required this.bathrooms,
    required this.bedrooms,
    required this.furnished,
    required this.parking,
    required this.type,
    required this.offer,
    required this.imageUrls,
    required this.userRef,
  }) : listingId = listingId ?? const Uuid().v4();

  // Initial Constructor
  const ListingHiveModel.initial()
      : listingId = '',
        name = '',
        description = '',
        address = '',
        regularPrice = 0,
        discountedPrice = 0,
        bathrooms = 0,
        bedrooms = 0,
        furnished = false,
        parking = false,
        type = '',
        offer = false,
        imageUrls = const [],
        userRef = '';

  // From Entity
  factory ListingHiveModel.fromEntity(ListingEntity entity) {
    return ListingHiveModel(
      listingId: entity.listingId ?? const Uuid().v4(),
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
      userRef: entity.userRef,
    );
  }

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
      userRef: userRef,
    );
  }

  // To Entity List
  static List<ListingEntity> toEntityList(List<ListingHiveModel> hiveList) {
    return hiveList.map((data) => data.toEntity()).toList();
  }

  // From Entity List
  static List<ListingHiveModel> fromEntityList(List<ListingEntity> entityList) {
    return entityList.map((entity) => ListingHiveModel.fromEntity(entity)).toList();
  }

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
        userRef,
      ];
}
