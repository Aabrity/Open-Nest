import 'package:dartz/dartz.dart';
import 'package:open_nest/app/usecase/usecase.dart';
import 'package:open_nest/core/error/failure.dart';
import 'package:open_nest/features/comments/domain/entity/comment_entity.dart';
import 'package:open_nest/features/comments/domain/repository/comment_repository.dart';

class GetAllCommentUsecase
    implements UsecaseWithoutParams<List<CommentEntity>> {
  final ICommentRepository _commentRepository;

  GetAllCommentUsecase({required ICommentRepository commentRepository})
      : _commentRepository = commentRepository;

  @override
  Future<Either<Failure, List<CommentEntity>>> call() {
    return _commentRepository.getComment();
  }
}
