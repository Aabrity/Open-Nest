import 'package:dartz/dartz.dart';
import 'package:open_nest/core/error/failure.dart';
import 'package:open_nest/features/like/domain/entity/like_entity.dart';


abstract interface class ILikeRepository {
   Future<Either<Failure, List<LikeEntity>>> getLike();
  Future<Either<Failure, void>> createLike(LikeEntity like);
  Future<Either<Failure, void>> deleteLike(String id, String token);
      Future<Either<Failure, List<LikeEntity>>> getListingLike(String listing);
}
