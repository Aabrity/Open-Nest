import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:open_nest/core/error/failure.dart';
import 'package:open_nest/features/listing/data/data_source/remote_datasource/listing_remote_datasource.dart';
import 'package:open_nest/features/listing/domain/entity/listing_entity.dart';
import 'package:open_nest/features/listing/domain/repository/listing_repository.dart';


class ListingRemoteRepository implements IListingRepository {
  final ListingRemoteDataSource listingRemoteDataSource;

  ListingRemoteRepository(this.listingRemoteDataSource);

  @override
  Future<Either<Failure, void>> createListing(ListingEntity listing) async {
    try {
      await listingRemoteDataSource.createListing(listing);
      return Right(null);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteListing(String id, String? token) async{
      try {
       listingRemoteDataSource.deleteListing(id, token);
      return Right(null);
    } catch (e) {
      return Left(
        ApiFailure(
          message: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<ListingEntity>>> getListing() async {
    try {
      final listings = await listingRemoteDataSource.getListing();
      debugPrint("Courses from Repository: $listings");
      return Right(listings);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, void>> updateListing(String id, ListingEntity updatedListing, String token) async {
    try {
      await listingRemoteDataSource.updateListing(id, updatedListing, token);
      return Right(null);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  
  @override
  Future<Either<Failure, List<ListingEntity>>> getUserListing(String userRef) async{
    try {
      final listings = await listingRemoteDataSource.getUserListing(userRef);
       debugPrint("Listings from Repository: $listings");
      return Right(listings);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }
}
