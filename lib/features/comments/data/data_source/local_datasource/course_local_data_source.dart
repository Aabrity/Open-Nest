import 'package:open_nest/core/error/failure.dart';
import 'package:open_nest/core/network/hive_service.dart';
import 'package:open_nest/features/comments/data/data_source/comment_data_source.dart';
import 'package:open_nest/features/comments/data/model/comment_hive_model.dart';
import 'package:open_nest/features/comments/domain/entity/comment_entity.dart';

class CommentLocalDataSource implements ICommentDataSource {
  final HiveService _hiveService;

  CommentLocalDataSource({required HiveService hiveService})
      : _hiveService = hiveService;

  @override
  Future<void> createComment(CommentEntity comment) async {
    try {
      // Convert course entity to comment model
      final commentHiveModel = CommentHiveModel.fromEntity(comment);
      _hiveService.addComment(commentHiveModel);
    } catch (e) {
      throw LocalDatabaseFailure(message: e.toString());
    }
  }

  @override
  Future<void> deleteComment(String id, String? token) async {
    try {
      _hiveService.deleteComment(id);
    } catch (e) {
      throw LocalDatabaseFailure(message: e.toString());
    }
  }

  @override
  Future<List<CommentEntity>> getComment() async {
    try {
      final commentHiveModelList = await _hiveService.getAllComment();
      return CommentHiveModel.toEntityList(commentHiveModelList);
    } catch (e) {
      throw LocalDatabaseFailure(message: e.toString());
    }
  }
}
