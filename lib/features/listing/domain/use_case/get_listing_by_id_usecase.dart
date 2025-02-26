import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:open_nest/app/shared_prefs/token_shared_prefs.dart';
import 'package:open_nest/app/usecase/usecase.dart';
import 'package:open_nest/core/error/failure.dart';
import 'package:open_nest/features/comments/domain/entity/comment_entity.dart';
import 'package:open_nest/features/comments/domain/repository/comment_repository.dart';
import 'package:open_nest/features/listing/domain/entity/listing_entity.dart';
import 'package:open_nest/features/listing/domain/repository/listing_repository.dart';



// Use case to get comments by listing ID
class GetUserListingUsecase
    implements UsecaseWithoutParams<List<ListingEntity>> {
  final IListingRepository _listingRepository;
  final TokenSharedPrefs tokenSharedPrefs;

  GetUserListingUsecase(  {required IListingRepository listingRepository, required this.tokenSharedPrefs,})
      : _listingRepository = listingRepository;

  @override
  Future<Either<Failure, List<ListingEntity>>> call() async {
    // return _commentRepository.getListingComment(params.listingId);
     final userId = await tokenSharedPrefs.getUserId();
      return userId.fold((l) {
      return Left(l);
    }, (r) async {
     final result = await _listingRepository.getUserListing(r);
     debugPrint("Fetching listings for listingId: $r");

  result.fold(
    (failure) => debugPrint("UseCase Error: $failure"),
    (listings) => debugPrint("Data in UseCase: $listings"),  // Debugging here
  );

  return result;
  });
}
    }