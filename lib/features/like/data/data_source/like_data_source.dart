import 'package:open_nest/features/like/domain/entity/like_entity.dart';


abstract interface class ILikeDataSource {
  Future<List<LikeEntity>> getLike();
  Future<void> createLike(LikeEntity listing);
  Future<void> deleteLike(String id, String? token);
}
