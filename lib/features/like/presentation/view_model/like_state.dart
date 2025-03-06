part of 'like_bloc.dart';

class LikeState extends Equatable {
  final bool isLoading;
  final List<LikeEntity> likes;
  final String error;
  final String? listingId; 
  final String? currentUserId;

  const LikeState({
    required this.isLoading,
    required this.likes,
    required this.error,
    this.listingId,
    this.currentUserId,
  });

  factory LikeState.initial() {
    return LikeState(
      isLoading: false,
      likes: [],
      error: '',
      listingId: null,
      currentUserId: null,
    );
  }

  LikeState copyWith({
    bool? isLoading,
    List<LikeEntity>? likes,
    String? error,
    String? listingId,
    String? currentUserId,
  }) {
    return LikeState(
      isLoading: isLoading ?? this.isLoading,
      likes: likes ?? this.likes,
      error: error ?? this.error,
      listingId: listingId ?? this.listingId,
      currentUserId: currentUserId ?? this.currentUserId,
    );
  }

  @override
  List<Object?> get props => [isLoading, likes, error, listingId, currentUserId];
}
