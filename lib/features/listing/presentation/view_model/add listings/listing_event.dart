part of 'listing_bloc.dart';

sealed class ListingEvent extends Equatable {
  const ListingEvent();

  @override
  List<Object> get props => [];
}

class ListingLoad extends ListingEvent {
  
}

class ListingLoadAll extends ListingEvent {}


class CreateListing extends ListingEvent {
  final BuildContext context;
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

  const CreateListing({
    required this.context,
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
    required this.imageUrls,});

  @override
  List<Object> get props => [ name,
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
        imageUrls,];
}

class DeleteListing extends ListingEvent {
  final String id;

  const DeleteListing({required this.id});

  @override
  List<Object> get props => [id];
}


class UpdateListing extends ListingEvent {
   final BuildContext context;
  final String id;
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

  const UpdateListing({
    required this.context,
    required this.id,
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

  @override
  List<Object> get props => [id, name, description, address, regularPrice, discountedPrice, bathrooms, bedrooms, furnished, parking, type, offer, imageUrls];
}