import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:open_nest/features/comments/domain/entity/comment_entity.dart';
import 'package:open_nest/features/comments/domain/use_case/create_comment_usecase.dart';
import 'package:open_nest/features/comments/domain/use_case/delete_comment_usecase.dart';
import 'package:open_nest/features/comments/domain/use_case/get_all_comment_usecase.dart';

part 'comment_event.dart';
part 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final GetAllCommentUsecase _getAllCommentUsecase;
  final CreateCommentUsecase _createCommentUsecase;
  final DeleteCommentUsecase _deleteCommentUsecase;
  CommentBloc({
    required GetAllCommentUsecase getAllCommentUsecase,
    required CreateCommentUsecase createCommentUsecase,
    required DeleteCommentUsecase deleteCommentUsecase,
  })  : _getAllCommentUsecase = getAllCommentUsecase,
        _createCommentUsecase = createCommentUsecase,
        _deleteCommentUsecase = deleteCommentUsecase,
        super(CommentState.initial()) {
    on<CommentLoad>(_onCommentLoad);
    on<CreateComment>(_onCreateComment);
    on<DeleteComment>(_onDeleteComment);

    add(CommentLoad());
  }

  Future<void> _onCommentLoad(
    CommentLoad event,
    Emitter<CommentState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final result = await _getAllCommentUsecase();
    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (comment) => emit(state.copyWith(isLoading: false, comment: comment)),
    );
  }

  Future<void> _onCreateComment(
    CreateComment event,
    Emitter<CommentState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final result = await _createCommentUsecase(
        CreateCommentParams(comment: event.comment));
    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (_) {
        emit(state.copyWith(isLoading: false));
        add(CommentLoad());
      },
    );
  }

  Future<void> _onDeleteComment(
    DeleteComment event,
    Emitter<CommentState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final result =
        await _deleteCommentUsecase(DeleteCommentParams(id: event.id));
    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (_) {
        emit(state.copyWith(isLoading: false));
        add(CommentLoad());
      },
    );
  }
}
