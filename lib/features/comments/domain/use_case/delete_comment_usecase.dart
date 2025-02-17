import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:open_nest/app/shared_prefs/token_shared_prefs.dart';
import 'package:open_nest/app/usecase/usecase.dart';
import 'package:open_nest/core/error/failure.dart';
import 'package:open_nest/features/comments/domain/repository/comment_repository.dart';

class DeleteCommentParams extends Equatable {
  final String id;

  const DeleteCommentParams({required this.id});

  const DeleteCommentParams.empty() : id = '_empty.string';

  @override
  List<Object?> get props => [id];
}

// Use case
class DeleteCommentUsecase
    implements UsecaseWithParams<void, DeleteCommentParams> {
  final ICommentRepository _commentRepository;
  final TokenSharedPrefs tokenSharedPrefs;

  DeleteCommentUsecase({required ICommentRepository commentRepository, required this.tokenSharedPrefs,})
      : _commentRepository = commentRepository;

  @override
  Future<Either<Failure, void>> call(DeleteCommentParams params) async {
     final token = await tokenSharedPrefs.getToken();
    return token.fold((l) {
      return Left(l);
    }, (r) async {
    return _commentRepository.deleteComment(params.id, r);
  });
  }
}
