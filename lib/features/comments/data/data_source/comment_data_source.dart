import 'package:open_nest/features/comments/domain/entity/comment_entity.dart';


abstract interface class ICommentDataSource {
  Future<List<CommentEntity>> getComment();
  Future<void> createComment(CommentEntity comment);
  Future<void> deleteComment(String id, String? token);
  Future<List<CommentEntity>> getListingComment(String listingId);
}
