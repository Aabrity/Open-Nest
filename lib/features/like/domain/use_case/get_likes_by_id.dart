// import 'package:dartz/dartz.dart';
// import 'package:equatable/equatable.dart';
// import 'package:flutter/material.dart';
// import 'package:open_nest/app/shared_prefs/token_shared_prefs.dart';
// import 'package:open_nest/app/usecase/usecase.dart';
// import 'package:open_nest/core/error/failure.dart';
// import 'package:open_nest/features/like/domain/entity/like_entity.dart';
// import 'package:open_nest/features/like/domain/repository/like_repository.dart';

// // Params class to hold the listing ID
// class GetLikesByListingParams extends Equatable {
//   final String listingId;

//   const GetLikesByListingParams({required this.listingId});

//   @override
//   List<Object?> get props => [listingId];
// }

// // Use case to get likes by listing ID
// class GetLikesByListingUsecase
//     implements UsecaseWithParams<List<LikeEntity>, GetLikesByListingParams> {
//   final ILikeRepository _likeRepository;
//   final TokenSharedPrefs _tokenSharedPrefs;

//   GetLikesByListingUsecase({
//     required ILikeRepository likeRepository,
//     required TokenSharedPrefs tokenSharedPrefs,
//   })  : _likeRepository = likeRepository,
//         _tokenSharedPrefs = tokenSharedPrefs;

//   @override
//   Future<Either<Failure, List<LikeEntity>>> call(GetLikesByListingParams params) async {
//     // Fetch the current user ID from SharedPreferences
//     final userRef = await _tokenSharedPrefs.getUserId();

//     return userRef.fold(
//       // If there's an error fetching the user ID, return the failure
//       (failure) => Left(failure),
//       // If the user ID is fetched successfully, proceed to fetch likes
//       (userId) async {
//         // Fetch likes for the listing
//         final result = await _likeRepository.getListingLike(params.listingId);

//         // Debugging: Print the result
//         debugPrint("Fetching likes for listingId: ${params.listingId}");
//         result.fold(
//           (failure) => debugPrint("UseCase Error: $failure"),
//           (likes) => debugPrint("Data in UseCase: $likes"),
//         );

//         // Return the result
//         return result;
//       },
//     );
//   }
// }

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:open_nest/app/shared_prefs/token_shared_prefs.dart';
import 'package:open_nest/app/usecase/usecase.dart';
import 'package:open_nest/core/error/failure.dart';
import 'package:open_nest/features/like/domain/entity/like_entity.dart';
import 'package:open_nest/features/like/domain/repository/like_repository.dart';

// Params class to hold the listing ID
class GetLikesByListingParams extends Equatable {
  final String listingId;

  const GetLikesByListingParams({required this.listingId});

  @override
  List<Object?> get props => [listingId];
}

// Use case to get likes by listing ID
class GetLikesByListingUsecase
    implements UsecaseWithParams<(List<LikeEntity>, String?), GetLikesByListingParams> {
  final ILikeRepository _likeRepository;
  final TokenSharedPrefs _tokenSharedPrefs;

  GetLikesByListingUsecase({
    required ILikeRepository likeRepository,
    required TokenSharedPrefs tokenSharedPrefs,
  })  : _likeRepository = likeRepository,
        _tokenSharedPrefs = tokenSharedPrefs;

  @override
  Future<Either<Failure, (List<LikeEntity>, String?)>> call(GetLikesByListingParams params) async {
    // Fetch the current user ID from SharedPreferences
    final userRef = await _tokenSharedPrefs.getUserId();

    return userRef.fold(
      // If there's an error fetching the user ID, return the failure
      (failure) => Left(failure),
      // If the user ID is fetched successfully, proceed to fetch likes
      (userId) async {
        // Fetch likes for the listing
        final result = await _likeRepository.getListingLike(params.listingId);

        // Debugging: Print the result
        debugPrint("Fetching likes for listingId: ${params.listingId}");
        result.fold(
          (failure) => debugPrint("UseCase Error: $failure"),
          (likes) => debugPrint("Data in UseCase: $likes"),
        );

        // Return the result along with the user ID
        return result.map((likes) => (likes, userId));
      },
    );
  }
}