part of 'comment_bloc.dart';

class CommentState extends Equatable {
  final bool isLoading;
  final List<CommentEntity> comment;
  final String error;

  const CommentState({
    required this.isLoading,
    required this.comment,
    required this.error,
  });

  factory CommentState.initial() {
    return CommentState(
      isLoading: false,
      comment: [],
      error: '',
    );
  }

  CommentState copyWith({
    bool? isLoading,
    List<CommentEntity>? comment,
    String? error,
  }) {
    return CommentState(
      isLoading: isLoading ?? this.isLoading,
      comment: comment ?? this.comment,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [isLoading, comment, error];
}
