import 'package:open_nest/core/error/failure.dart';
import 'package:open_nest/core/network/hive_service.dart';
import 'package:open_nest/features/like/data/data_source/like_data_source.dart';
import 'package:open_nest/features/like/data/model/like_hive_model.dart';
import 'package:open_nest/features/like/domain/entity/like_entity.dart';

class LikeLocalDataSource implements ILikeDataSource {
  final HiveService _hiveService;

  LikeLocalDataSource({required HiveService hiveService})
      : _hiveService = hiveService;

  @override
  Future<void> createLike(LikeEntity like) async {
    try {
      // Convert like entity to like model
      final likeHiveModel = LikeHiveModel.fromEntity(like);
      _hiveService.addlike(likeHiveModel);
    } catch (e) {
      throw LocalDatabaseFailure(message: e.toString());
    }
  }

  @override
  Future<void> deleteLike(String id, String? token) async {
    try {
      _hiveService.deleteLike(id);
    } catch (e) {
      throw LocalDatabaseFailure(message: e.toString());
    }
  }

  @override
  Future<List<LikeEntity>> getLike() async {
    try {
      final likeHiveModelList = await _hiveService.getLike();
      return LikeHiveModel.toEntityList(likeHiveModelList);
    } catch (e) {
      throw LocalDatabaseFailure(message: e.toString());
    }
  }
}
