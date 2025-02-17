import 'package:dartz/dartz.dart';
import 'package:open_nest/core/error/failure.dart';
import 'package:open_nest/features/like/data/data_source/remote_datasource/like_remote_datasource.dart';
import 'package:open_nest/features/like/domain/entity/like_entity.dart';
import 'package:open_nest/features/like/domain/repository/like_repository.dart';

class LikeRemoteRepository implements ILikeRepository {
  final LikeRemoteDataSource _likeRemoteDataSource;

  LikeRemoteRepository(this._likeRemoteDataSource);

  @override
  Future<Either<Failure, void>> createLike(LikeEntity like) async {
    try {
      await _likeRemoteDataSource.createLike(like);
      return Right(null);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteLike(String id, String? token) async {
   try {
      _likeRemoteDataSource.deleteLike(id, token);
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
  Future<Either<Failure, List<LikeEntity>>> getLike() async {
    try {
      final likes = await _likeRemoteDataSource.getLike();
      return Right(likes);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }
}
