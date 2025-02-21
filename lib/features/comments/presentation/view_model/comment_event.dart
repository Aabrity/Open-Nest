part of 'comment_bloc.dart';

sealed class CommentEvent extends Equatable {
  const CommentEvent();

  @override
  List<Object> get props => [];
}

class CommentLoad extends CommentEvent {}

class CreateComment extends CommentEvent {
  final String comment;
  final String listingId;

  const CreateComment( {required this.listingId, required this.comment});

  @override
  List<Object> get props => [comment, listingId];
}

class DeleteComment extends CommentEvent {
  final String id;

  const DeleteComment({required this.id});

  @override
  List<Object> get props => [id];
}
class GetCommentsByListing extends CommentEvent {
  final String listingId;

  const GetCommentsByListing({required this.listingId});

  @override
  List<Object> get props => [listingId];
}
