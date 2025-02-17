part of 'comment_bloc.dart';

sealed class CommentEvent extends Equatable {
  const CommentEvent();

  @override
  List<Object> get props => [];
}

class CommentLoad extends CommentEvent {}

class CreateComment extends CommentEvent {
  final String comment;

  const CreateComment({required this.comment});

  @override
  List<Object> get props => [comment];
}

class DeleteComment extends CommentEvent {
  final String id;

  const DeleteComment({required this.id});

  @override
  List<Object> get props => [id];
}
