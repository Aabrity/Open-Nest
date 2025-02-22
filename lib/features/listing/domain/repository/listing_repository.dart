import 'package:dartz/dartz.dart';
import 'package:open_nest/core/error/failure.dart';
import 'package:open_nest/features/listing/domain/entity/listing_entity.dart';


abstract interface class IListingRepository {
  Future<Either<Failure, List<ListingEntity>>> getListing();
  Future<Either<Failure, void>> createListing(ListingEntity listing);
  Future<Either<Failure, void>> deleteListing(String id, String? token);
   Future<Either<Failure, void>> updateListing(String id, ListingEntity updatedListing, String token);
}



