import 'package:equatable/equatable.dart';
import 'package:open_nest/features/comments/domain/entity/comment_entity.dart';

class CommentState extends Equatable {
  final bool isLoading;
  final List<CommentEntity> comment;
  final String error;
  final String? listingId; 
  final String? currentUserId;

  const CommentState({
    required this.isLoading,
    required this.comment,
    required this.error,
    this.listingId,
    this.currentUserId,
  });

  factory CommentState.initial() {
    return const CommentState(
      isLoading: false,
      comment: [],
      error: '',
      listingId: null,
      currentUserId: null,
    );
  }

  CommentState copyWith({
    bool? isLoading,
    List<CommentEntity>? comment,
    String? error,
    String? listingId,
    String? currentUserId,
  }) {
    return CommentState(
      isLoading: isLoading ?? this.isLoading,
      comment: comment ?? this.comment,
      error: error ?? this.error,
      listingId: listingId ?? this.listingId,
      currentUserId: currentUserId ?? this.currentUserId,
    );
  }

  @override
  List<Object?> get props => [isLoading, comment, error, listingId, currentUserId];
}
