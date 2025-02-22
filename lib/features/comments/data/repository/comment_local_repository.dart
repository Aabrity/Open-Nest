import 'package:dartz/dartz.dart';
import 'package:open_nest/core/error/failure.dart';
import 'package:open_nest/features/comments/data/data_source/local_datasource/course_local_data_source.dart';
import 'package:open_nest/features/comments/domain/entity/comment_entity.dart';
import 'package:open_nest/features/comments/domain/repository/comment_repository.dart';

class CommentLocalRepository implements ICommentRepository {
  final CommentLocalDataSource _commentLocalDataSource;

  CommentLocalRepository(
      {required CommentLocalDataSource commentLocalDataSource})
      : _commentLocalDataSource = commentLocalDataSource;

  @override
  Future<Either<Failure, void>> createComment(CommentEntity comment) {
    try {
      _commentLocalDataSource.createComment(comment);
      return Future.value(Right(null));
    } catch (e) {
      return Future.value(Left(LocalDatabaseFailure(message: e.toString())));
    }
  }

  @override
  Future<Either<Failure, void>> deleteComment(String id, String? token) {
    try {
      _commentLocalDataSource.deleteComment(id, token);
      return Future.value(Right(null));
    } catch (e) {
      return Future.value(Left(LocalDatabaseFailure(message: e.toString())));
    }
  }

  @override
  Future<Either<Failure, List<CommentEntity>>> getComment() {
    try {
      return _commentLocalDataSource.getComment().then(
        (value) {
          return Right(value);
        },
      );
    } catch (e) {
      return Future.value(Left(LocalDatabaseFailure(message: e.toString())));
    }
  }
  
  @override
  Future<Either<Failure, List<CommentEntity>>> getListingComment(String listing) {
    // TODO: implement getListingComment
    throw UnimplementedError();
  }
}
