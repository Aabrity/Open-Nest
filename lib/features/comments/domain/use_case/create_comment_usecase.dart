import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:open_nest/app/shared_prefs/token_shared_prefs.dart';
import 'package:open_nest/app/usecase/usecase.dart';
import 'package:open_nest/core/error/failure.dart';
import 'package:open_nest/features/comments/domain/entity/comment_entity.dart';
import 'package:open_nest/features/comments/domain/repository/comment_repository.dart';

class CreateCommentParams extends Equatable {
  final String comment;
  final String listing;
  final String? user;

  const CreateCommentParams({
    required this.listing, 
     this.user, 
    required this.comment
    
  });

  // Empty constructor
  const CreateCommentParams.empty(this.listing, this.user) : comment = '_empty.string';

  @override
  List<Object?> get props => [comment,user,listing];
}

class CreateCommentUsecase
    implements UsecaseWithParams<void, CreateCommentParams> {
  final ICommentRepository _commentRepository;
  final TokenSharedPrefs tokenSharedPrefs;

  CreateCommentUsecase({required this.tokenSharedPrefs, required ICommentRepository commentRepository})
      : _commentRepository = commentRepository;

  @override
  Future<Either<Failure, void>> call(CreateCommentParams params) async {
    final userRef = await tokenSharedPrefs.getUserId();
       return userRef.fold((l) {
      return Left(l);
    }, (r) async {
    return _commentRepository.createComment(
      CommentEntity(comment: params.comment, listing: params.listing, user: r),
    );
  });
}
    }