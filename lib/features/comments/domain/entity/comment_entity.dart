import 'package:equatable/equatable.dart';


class CommentEntity extends Equatable {
  final String? commentId;
  final String listing;
  final String comment;
 

  const CommentEntity({
    this.commentId,
    required this.listing,
    required this.comment,
 
  });

  @override
  List<Object?> get props => [commentId, listing, comment];
}
