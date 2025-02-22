import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:open_nest/app/usecase/usecase.dart';
import 'package:open_nest/core/error/failure.dart';
import 'package:open_nest/features/listing/domain/entity/listing_entity.dart';
import 'package:open_nest/features/listing/domain/repository/listing_repository.dart';

class GetAllListingUsecase
    implements UsecaseWithoutParams<List<ListingEntity>> {
  final IListingRepository _listingRepository;

  GetAllListingUsecase({required IListingRepository listingRepository})
      : _listingRepository = listingRepository;

  @override
  Future<Either<Failure, List<ListingEntity>>> call() async {
    // return _listingRepository.getListing();
    final result = await _listingRepository.getListing();

  result.fold(
    (failure) => debugPrint("UseCase Error: $failure"),
    (listings) => debugPrint("Data in UseCase: $listings"),  // Debugging here
  );

  return result;
  }
}





