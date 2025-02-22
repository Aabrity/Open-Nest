import 'package:dartz/dartz.dart';
import 'package:open_nest/core/error/failure.dart';
import 'package:open_nest/features/listing/data/data_source/local_datasource/listing_local_data_source.dart';
import 'package:open_nest/features/listing/domain/entity/listing_entity.dart';
import 'package:open_nest/features/listing/domain/repository/listing_repository.dart';

class ListingLocalRepository implements IListingRepository {
  final ListingLocalDataSource _listingLocalDataSource;

  ListingLocalRepository(
      {required ListingLocalDataSource listingLocalDataSource})
      : _listingLocalDataSource = listingLocalDataSource;

  @override
  Future<Either<Failure, void>> createListing(ListingEntity listing) {
    try {
      _listingLocalDataSource.createListing(listing);
      return Future.value(Right(null));
    } catch (e) {
      return Future.value(Left(LocalDatabaseFailure(message: e.toString())));
    }
  }

  @override
  Future<Either<Failure, void>> deleteListing(String id, String? token) {
    try {
      _listingLocalDataSource.deleteListing(id, token);
      return Future.value(Right(null));
    } catch (e) {
      return Future.value(Left(LocalDatabaseFailure(message: e.toString())));
    }
  }

  @override
  Future<Either<Failure, List<ListingEntity>>> getListing() {
    try {
      return _listingLocalDataSource.getListing().then(
        (value) {
          return Right(value);
        },
      );
    } catch (e) {
      return Future.value(Left(LocalDatabaseFailure(message: e.toString())));
    }
  }
  
  @override
  Future<Either<Failure, void>> updateListing(String id, ListingEntity updatedListing, String token) {
    // TODO: implement updateListing
    throw UnimplementedError();
  }
}
