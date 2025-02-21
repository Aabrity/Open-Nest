import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
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
    implements UsecaseWithParams<List<CommentEntity>, GetCommentsByListingParams> {
  final ICommentRepository _commentRepository;

  GetCommentsByListingUsecase({required ICommentRepository commentRepository})
      : _commentRepository = commentRepository;

  @override
  Future<Either<Failure, List<CommentEntity>>> call(GetCommentsByListingParams params) {
    return _commentRepository.getListingComment(params.listingId);
  }
}
