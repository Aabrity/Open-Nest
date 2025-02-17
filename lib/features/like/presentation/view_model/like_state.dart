part of 'like_bloc.dart';

class LikeState extends Equatable {
  final bool isLoading;
  final List<LikeEntity> likes;
  final String error;

  const LikeState({
    required this.isLoading,
    required this.likes,
    required this.error,
  });

  factory LikeState.initial() {
    return LikeState(
      isLoading: false,
      likes: [],
      error: '',
    );
  }

  LikeState copyWith({
    bool? isLoading,
    List<LikeEntity>? likes,
    String? error,
  }) {
    return LikeState(
      isLoading: isLoading ?? this.isLoading,
      likes: likes ?? this.likes,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [isLoading, likes, error];
}
