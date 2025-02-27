import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:open_nest/features/comments/domain/use_case/create_comment_usecase.dart';
import 'package:open_nest/features/comments/domain/use_case/delete_comment_usecase.dart';
import 'package:open_nest/features/comments/domain/use_case/get_all_comment_usecase.dart';
import 'package:open_nest/features/comments/domain/use_case/get_comments_by_id.dart';
import 'package:open_nest/features/comments/presentation/view_model/comment_state.dart';

part 'comment_event.dart';
// part 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final GetAllCommentUsecase _getAllCommentUsecase;
  final CreateCommentUsecase _createCommentUsecase;
  final DeleteCommentUsecase _deleteCommentUsecase;
  final GetCommentsByListingUsecase _getCommentsByListingUsecase;
  CommentBloc({
    required GetAllCommentUsecase getAllCommentUsecase,
    required CreateCommentUsecase createCommentUsecase,
    required DeleteCommentUsecase deleteCommentUsecase,
    required GetCommentsByListingUsecase
        getCommentsByListingUsecase, // Add this
  })  : _getAllCommentUsecase = getAllCommentUsecase,
        _createCommentUsecase = createCommentUsecase,
        _deleteCommentUsecase = deleteCommentUsecase,
        _getCommentsByListingUsecase = getCommentsByListingUsecase, // Add this
        super(CommentState.initial()) {
    on<CommentLoad>(_onCommentLoad);
    on<CreateComment>(_onCreateComment);
    on<DeleteComment>(_onDeleteComment);

    add(CommentLoad(listingId: '')); // Trigger initial load
  }
  Future<void> _onCommentLoad(
    CommentLoad event,
    Emitter<CommentState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    // Fetch comments for a specific listing
    final result = await _getCommentsByListingUsecase(
        GetCommentsByListingParams(listingId: event.listingId));
    result.fold(
      (failure) => emit(state.copyWith(
        isLoading: false,
        error: failure.message,
      )),
      (comments) => emit(state.copyWith(
        isLoading: false,
        comment: comments,
        listingId: event.listingId, // Update the listingId in the state
      )),
    );
  }

  Future<void> _onCreateComment(
    CreateComment event,
    Emitter<CommentState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final result = await _createCommentUsecase(
        CreateCommentParams(comment: event.comment, listing: event.listingId));
    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (_) {
        emit(state.copyWith(isLoading: false));
        add(CommentLoad(listingId: event.listingId));
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
        add(CommentLoad(listingId: event.listingId));
      },
    );
  }
}
