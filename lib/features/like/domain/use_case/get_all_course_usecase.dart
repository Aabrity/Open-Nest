import 'package:dartz/dartz.dart';
import 'package:open_nest/app/usecase/usecase.dart';
import 'package:open_nest/core/error/failure.dart';
import 'package:open_nest/features/like/domain/entity/like_entity.dart';
import 'package:open_nest/features/like/domain/repository/like_repository.dart';


class GetAllLikeUsecase implements UsecaseWithoutParams<List<LikeEntity>> {
  final ILikeRepository _likeRepository;

  GetAllLikeUsecase({required ILikeRepository likeRepository})
      : _likeRepository = likeRepository;

  @override
  Future<Either<Failure, List<LikeEntity>>> call() {
    return _likeRepository.getLike();
  }
}
