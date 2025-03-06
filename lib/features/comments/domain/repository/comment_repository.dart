import 'package:dartz/dartz.dart';
import 'package:open_nest/core/error/failure.dart';
import 'package:open_nest/features/comments/domain/entity/comment_entity.dart';


abstract interface class ICommentRepository {
 Future<Either<Failure, void>> createComment(CommentEntity comment);
  Future<Either<Failure, void>> deleteComment(String id, String? token);
   Future<Either<Failure, List<CommentEntity>>> getComment();
    Future<Either<Failure, List<CommentEntity>>> getListingComment(String listing);
}
