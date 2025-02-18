import 'package:equatable/equatable.dart';


class CommentEntity extends Equatable {
  final String? commentId;
  final String listing;
  final String comment;
  final String user;
 

  const CommentEntity({
    this.commentId,
    required this.listing,
    required this.comment,
    required this.user,
 
  });

  @override
  List<Object?> get props => [commentId, listing, comment, user];
}
