import 'package:equatable/equatable.dart';
import 'package:open_nest/features/auth/domain/entity/auth_entity.dart';

class ListingEntity extends Equatable {
  final String? listingId;
  final String name;
  final String description;
  final String address;
  final int regularPrice;
  final int? discountedPrice;
  final int bathrooms;
  final int bedrooms;
  final bool furnished;
  final bool parking;
  final String type;
  final bool offer;
  final List<String> imageUrls;
  final String userRef;
  
 


  const ListingEntity({
  this.listingId,
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
 

  });
  
  @override
  
  List<Object?> get props =>  [listingId, name, description, address, regularPrice,discountedPrice,bathrooms,bedrooms,furnished,parking,type,offer,imageUrls, userRef];

 
}
