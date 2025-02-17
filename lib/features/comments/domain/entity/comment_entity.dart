import 'package:equatable/equatable.dart';
import 'package:open_nest/features/auth/domain/entity/auth_entity.dart';
import 'package:open_nest/features/listing/domain/entity/listing_entity.dart';

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
