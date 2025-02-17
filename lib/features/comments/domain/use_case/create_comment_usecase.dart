import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:open_nest/app/usecase/usecase.dart';
import 'package:open_nest/core/error/failure.dart';
import 'package:open_nest/features/comments/domain/entity/comment_entity.dart';
import 'package:open_nest/features/comments/domain/repository/comment_repository.dart';

class CreateCommentParams extends Equatable {
  final String comment;

  const CreateCommentParams({required this.comment});

  // Empty constructor
  const CreateCommentParams.empty() : comment = '_empty.string';

  @override
  List<Object?> get props => [comment];
}

class CreateCommentUsecase
    implements UsecaseWithParams<void, CreateCommentParams> {
  final ICommentRepository _commentRepository;

  CreateCommentUsecase({required ICommentRepository commentRepository})
      : _commentRepository = commentRepository;

  @override
  Future<Either<Failure, void>> call(CreateCommentParams params) {
    return _commentRepository.createComment(
      CommentEntity(comment: params.comment, listing: ''),
    );
  }
}
