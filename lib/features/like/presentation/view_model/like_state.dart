part of 'like_bloc.dart';

class LikeState extends Equatable {
  final bool isLoading;
  final List<LikeEntity> likes;
  final String error;
  final String? listingId; 

  const LikeState({
    required this.isLoading,
    required this.likes,
    required this.error,
    this.listingId,
  });

  factory LikeState.initial() {
    return LikeState(
      isLoading: false,
      likes: [],
      error: '',
      listingId: null,
    );
  }

  LikeState copyWith({
    bool? isLoading,
    List<LikeEntity>? likes,
    String? error,
    String? listingId,
  }) {
    return LikeState(
      isLoading: isLoading ?? this.isLoading,
      likes: likes ?? this.likes,
      error: error ?? this.error,
      listingId: listingId ?? this.listingId,
    );
  }

  @override
  List<Object?> get props => [isLoading, likes, error, listingId];
}
