import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:open_nest/app/shared_prefs/token_shared_prefs.dart';
import 'package:open_nest/app/usecase/usecase.dart';
import 'package:open_nest/core/error/failure.dart';
// import 'package:open_nest/features/comments/domain/use_case/create_comment_usecase.dart';
import 'package:open_nest/features/like/domain/entity/like_entity.dart';
import 'package:open_nest/features/like/domain/repository/like_repository.dart';

class CreateLikeParams extends Equatable {
  final String listing;
   final String? user;

  const CreateLikeParams({required this.listing, this.user});

  // Empty constructor
  const CreateLikeParams.empty(this.user) : listing = '_empty.string';

  @override
  List<Object?> get props => [listing, user];
}

class CreateLikeUsecase implements UsecaseWithParams<void, CreateLikeParams> {
  final ILikeRepository _likeRepository;
  final TokenSharedPrefs tokenSharedPrefs;

  CreateLikeUsecase({required this.tokenSharedPrefs, required ILikeRepository likeRepository})
      : _likeRepository = likeRepository;

  @override
  Future<Either<Failure, void>> call(CreateLikeParams params) async {
      final userRef = await tokenSharedPrefs.getUserId();
       return userRef.fold((l) {
      return Left(l);
    }, (r) async {
    return _likeRepository.createLike(
      LikeEntity(listing: params.listing, user: r),
    );
  });
}
    }