import 'package:dartz/dartz.dart';
import 'package:open_nest/core/error/failure.dart';
import 'package:open_nest/features/like/data/data_source/local_datasource/like_local_data_source.dart';
import 'package:open_nest/features/like/domain/entity/like_entity.dart';
import 'package:open_nest/features/like/domain/repository/like_repository.dart';

class LikeLocalRepository implements ILikeRepository {
  final LikeLocalDataSource _likeLocalDataSource;

  LikeLocalRepository({required LikeLocalDataSource likeLocalDataSource})
      : _likeLocalDataSource = likeLocalDataSource;

  @override
  Future<Either<Failure, void>> createLike(LikeEntity course) {
    try {
      _likeLocalDataSource.createLike(course);
      return Future.value(Right(null));
    } catch (e) {
      return Future.value(Left(LocalDatabaseFailure(message: e.toString())));
    }
  }

   @override
  Future<Either<Failure, void>> deleteLike(String id, String? token) {
    try {
      _likeLocalDataSource.deleteLike(id, token);
      return Future.value(Right(null));
    } catch (e) {
      return Future.value(Left(LocalDatabaseFailure(message: e.toString())));
    }
  }

  @override
  Future<Either<Failure, List<LikeEntity>>> getLike() {
    try {
      return _likeLocalDataSource.getLike().then(
        (value) {
          return Right(value);
        },
      );
    } catch (e) {
      return Future.value(Left(LocalDatabaseFailure(message: e.toString())));
    }
  }
}
