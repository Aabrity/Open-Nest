import 'package:equatable/equatable.dart';
import 'package:open_nest/features/comments/domain/entity/comment_entity.dart';

class CommentState extends Equatable {
  final bool isLoading;
  final List<CommentEntity> comment;
  final String error;
  final String? listingId; 

  const CommentState({
    required this.isLoading,
    required this.comment,
    required this.error,
    this.listingId,
  });

  factory CommentState.initial() {
    return const CommentState(
      isLoading: false,
      comment: [],
      error: '',
      listingId: null,
    );
  }

  CommentState copyWith({
    bool? isLoading,
    List<CommentEntity>? comment,
    String? error,
    String? listingId,
  }) {
    return CommentState(
      isLoading: isLoading ?? this.isLoading,
      comment: comment ?? this.comment,
      error: error ?? this.error,
      listingId: listingId ?? this.listingId,
    );
  }

  @override
  List<Object?> get props => [isLoading, comment, error, listingId];
}
