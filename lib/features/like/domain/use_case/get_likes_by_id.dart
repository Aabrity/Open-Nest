import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:open_nest/app/usecase/usecase.dart';
import 'package:open_nest/core/error/failure.dart';
import 'package:open_nest/features/comments/domain/entity/comment_entity.dart';
import 'package:open_nest/features/comments/domain/repository/comment_repository.dart';
import 'package:open_nest/features/like/domain/entity/like_entity.dart';
import 'package:open_nest/features/like/domain/repository/like_repository.dart';

// Params class to hold the listing ID
class GetLikesByListingParams extends Equatable {
  final String listingId;

  const GetLikesByListingParams({required this.listingId});

  @override
  List<Object?> get props => [listingId];
}

// Use case to get comments by listing ID
class GetLikesByListingUsecase
    implements UsecaseWithParams<List<LikeEntity>, GetLikesByListingParams> {
  final ILikeRepository _likeRepository;

  GetLikesByListingUsecase({required ILikeRepository likeRepository})
      : _likeRepository = likeRepository;

  @override
  Future<Either<Failure, List<LikeEntity>>> call(GetLikesByListingParams params) async {
    // return _commentRepository.getListingComment(params.listingId);
     final result = await _likeRepository.getListingLike(params.listingId);
     debugPrint("Fetching likes for listingId: ${params.listingId}");

  result.fold(
    (failure) => debugPrint("UseCase Error: $failure"),
    (likes) => debugPrint("Data in UseCase: $likes"),  // Debugging here
  );

  return result;
  }
}
