import 'package:dartz/dartz.dart';
import 'package:open_nest/core/error/failure.dart';
import 'package:open_nest/features/comments/data/data_source/remote_datasource/comment_remote_datasource.dart';
import 'package:open_nest/features/comments/domain/entity/comment_entity.dart';
import 'package:open_nest/features/comments/domain/repository/comment_repository.dart';


class CommentRemoteRepository implements ICommentRepository {
  final CommentRemoteDataSource _commentRemoteDataSource;

  CommentRemoteRepository(this._commentRemoteDataSource);

  @override
  Future<Either<Failure, void>> createComment(CommentEntity comment) async {
    try {
      await _commentRemoteDataSource.createComment(comment);
      return Right(null);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

@override
  Future<Either<Failure, void>> deleteComment(String id, String? token) async {
    try {
      _commentRemoteDataSource.deleteComment(id, token);
      return Right(null);
    } catch (e) {
      return Left(
        ApiFailure(
          message: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<CommentEntity>>> getComment() async {
    try {
      final comments = await _commentRemoteDataSource.getComment();
      return Right(comments);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }
}
