import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:open_nest/app/shared_prefs/token_shared_prefs.dart';
import 'package:open_nest/app/usecase/usecase.dart';
import 'package:open_nest/core/error/failure.dart';
import 'package:open_nest/features/like/domain/repository/like_repository.dart';


class DeleteLikeParams extends Equatable {
  final String id;

  const DeleteLikeParams({required this.id});

  const DeleteLikeParams.empty() : id = '_empty.string';

  @override
  List<Object?> get props => [id];
}

// Use case
class DeleteLikeUsecase
    implements UsecaseWithParams<void, DeleteLikeParams> {
  final ILikeRepository _likeRepository;
  final TokenSharedPrefs tokenSharedPrefs;

  DeleteLikeUsecase({required ILikeRepository likeRepository, required this.tokenSharedPrefs,})
      : _likeRepository = likeRepository;

  @override
  Future<Either<Failure, void>> call(DeleteLikeParams params) async {
     final token = await tokenSharedPrefs.getToken();
    return token.fold((l) {
      return Left(l);
    }, (r) async {
    return _likeRepository.deleteLike(params.id, r);
  });
  }
}
