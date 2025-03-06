import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:open_nest/app/shared_prefs/token_shared_prefs.dart';
import 'package:open_nest/app/usecase/usecase.dart';
import 'package:open_nest/core/error/failure.dart';
import 'package:open_nest/features/comments/domain/entity/comment_entity.dart';
import 'package:open_nest/features/comments/domain/repository/comment_repository.dart';

// Params class to hold the listing ID
class GetCommentsByListingParams extends Equatable {
  final String listingId;

  const GetCommentsByListingParams({required this.listingId});

  @override
  List<Object?> get props => [listingId];
}

// Use case to get comments by listing ID
class GetCommentsByListingUsecase
    implements UsecaseWithParams<(List<CommentEntity>, String?), GetCommentsByListingParams> {
  final ICommentRepository _commentRepository;
  final TokenSharedPrefs _tokenSharedPrefs;

  GetCommentsByListingUsecase({
    required ICommentRepository commentRepository,
    required TokenSharedPrefs tokenSharedPrefs,
  })  : _commentRepository = commentRepository,
        _tokenSharedPrefs = tokenSharedPrefs;

  @override
  Future<Either<Failure, (List<CommentEntity>, String?)>> call(GetCommentsByListingParams params) async {
    // Fetch the current user ID from SharedPreferences
    final userRef = await _tokenSharedPrefs.getUserId();

    return userRef.fold(
      // If there's an error fetching the user ID, return the failure
      (failure) => Left(failure),
      // If the user ID is fetched successfully, proceed to fetch comments
      (userId) async {
        // Fetch comments for the listing
        final result = await _commentRepository.getListingComment(params.listingId);

        // Debugging: Print the result
        debugPrint("Fetching comments for listingId: ${params.listingId}");
        result.fold(
          (failure) => debugPrint("UseCase Error: $failure"),
          (comments) => debugPrint("Data in UseCase: $comments"),
        );

        // Return the result along with the user ID
        return result.map((comments) => (comments, userId));
      },
    );
  }
}
