import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:open_nest/app/shared_prefs/token_shared_prefs.dart';
import 'package:open_nest/app/usecase/usecase.dart';
import 'package:open_nest/core/error/failure.dart';
import 'package:open_nest/features/listing/data/repository/listing_remote_repository.dart';
import 'package:open_nest/features/listing/domain/entity/listing_entity.dart';
import 'package:open_nest/features/listing/domain/repository/listing_repository.dart';


class CreateListingParams extends Equatable {
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

  const CreateListingParams({ 
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
  this.userRef,});

  const CreateListingParams.initial({ 
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
  this.userRef});
  
  @override
  // TODO: implement props
  List<Object?> get props =>  [ name, description, address, regularPrice,discountedPrice,bathrooms,bedrooms,furnished,parking,type,offer,imageUrls];

  


}

class CreateListingUsecase
    implements UsecaseWithParams<void, CreateListingParams> {
  final IListingRepository _listingRepository;
  final TokenSharedPrefs tokenSharedPrefs;
  

  CreateListingUsecase( { required IListingRepository listingRepository, required this.tokenSharedPrefs })
      : _listingRepository = listingRepository;

  @override
  Future<Either<Failure, void>> call(CreateListingParams params) async {
   final userRef = await tokenSharedPrefs.getUserId();
       return userRef.fold((l) {
      return Left(l);
    }, (r) async {
    return _listingRepository.createListing(
      ListingEntity( name: params.name,
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
      userRef: r, )
    );
  });
}
    }  