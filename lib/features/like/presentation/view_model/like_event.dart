part of 'like_bloc.dart';

sealed class LikeEvent extends Equatable {
  const LikeEvent();

  @override
  List<Object> get props => [];
}

class LikeLoad extends LikeEvent {}

class CreateLike extends LikeEvent {
  final String listing;

  const CreateLike({required this.listing});

  @override
  List<Object> get props => [listing];
}

class DeleteLike extends LikeEvent {
  final String id;

  const DeleteLike({required this.id});

  @override
  List<Object> get props => [id];
}
