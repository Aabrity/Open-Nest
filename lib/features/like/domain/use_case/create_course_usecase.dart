import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:open_nest/app/usecase/usecase.dart';
import 'package:open_nest/core/error/failure.dart';
// import 'package:open_nest/features/comments/domain/use_case/create_comment_usecase.dart';
import 'package:open_nest/features/like/domain/entity/like_entity.dart';
import 'package:open_nest/features/like/domain/repository/like_repository.dart';

class CreateLikeParams extends Equatable {
  final String listing;

  const CreateLikeParams({required this.listing});

  // Empty constructor
  const CreateLikeParams.empty() : listing = '_empty.string';

  @override
  List<Object?> get props => [listing];
}

class CreateLikeUsecase implements UsecaseWithParams<void, CreateLikeParams> {
  final ILikeRepository _likeRepository;

  CreateLikeUsecase({required ILikeRepository likeRepository})
      : _likeRepository = likeRepository;

  @override
  Future<Either<Failure, void>> call(CreateLikeParams params) {
    return _likeRepository.createLike(
      LikeEntity(listing: params.listing),
    );
  }
}
