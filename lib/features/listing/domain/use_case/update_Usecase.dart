import 'package:equatable/equatable.dart';
import 'package:open_nest/features/listing/domain/entity/listing_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:open_nest/app/shared_prefs/token_shared_prefs.dart';
import 'package:open_nest/app/usecase/usecase.dart';
import 'package:open_nest/core/error/failure.dart';
// import 'package:open_nest/features/listing/domain/entity/listing_entity.dart';
import 'package:open_nest/features/listing/domain/repository/listing_repository.dart';


class UpdateListingParams extends Equatable {
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
  final String? userRef;

  const UpdateListingParams({
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
    this.userRef ,
  });
  

  @override
  List<Object?> get props => [
       id, name, description, address, regularPrice, discountedPrice, bathrooms,
        bedrooms, furnished, parking, type, offer, imageUrls
      ];
}

class UpdateListingUsecase implements UsecaseWithParams<void, UpdateListingParams> {
  final IListingRepository _listingRepository;
  final TokenSharedPrefs tokenSharedPrefs;

  UpdateListingUsecase({required this.tokenSharedPrefs,required IListingRepository listingRepository})
      : _listingRepository = listingRepository;

  @override
  Future<Either<Failure, void>> call(UpdateListingParams params) async {
     final token = await tokenSharedPrefs.getToken();
     final userRef = await tokenSharedPrefs.getUserId();
       return userRef.fold((l) {
      return Left(l);
    }, (r) async {
    return token.fold(
      (failure) => Left(failure),
      (tokenValue) async => _listingRepository.updateListing(
      params.id, 
      ListingEntity(
        listingId: params.id,
        name: params.name,
        description: params.description,
        address: params.address,
        regularPrice: params.regularPrice,
        discountedPrice: params.discountedPrice,
        bathrooms: params.bathrooms,
        bedrooms: params.bedrooms,
        furnished: params.furnished,
        parking: params.parking,
        type: params.type,
        offer: params.offer,
        imageUrls: params.imageUrls,
        userRef: r, // Update this if necessary
      ),tokenValue
    ));
  });
}
}