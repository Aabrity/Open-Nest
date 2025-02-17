import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:open_nest/app/constants/hive_table_constant.dart';
import 'package:open_nest/features/like/domain/entity/like_entity.dart';
import 'package:uuid/uuid.dart';

part 'like_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.likeTableId)
class LikeHiveModel extends Equatable {
  @HiveField(0)
  final String likeId;

  @HiveField(1)
  final String listing;



  LikeHiveModel({
    String? likeId,
    required this.listing,
  }) : likeId = likeId ?? const Uuid().v4();

  // Initial Constructor
  const LikeHiveModel.initial()
      : likeId = '',
        listing = '';


  // From Entity
  factory LikeHiveModel.fromEntity(LikeEntity entity) {
    return LikeHiveModel(
      likeId: entity.likeId ?? const Uuid().v4(),
      listing: entity.listing,
    );
  }

  // To Entity
  LikeEntity toEntity() {
    return LikeEntity(
      likeId: likeId,
      listing: listing
    );
  }

  // To Entity List
  static List<LikeEntity> toEntityList(List<LikeHiveModel> hiveList) {
    return hiveList.map((data) => data.toEntity()).toList();
  }

  // From Entity List
  static List<LikeHiveModel> fromEntityList(List<LikeEntity> entityList) {
    return entityList.map((entity) => LikeHiveModel.fromEntity(entity)).toList();
  }

  @override
  List<Object?> get props => [likeId, listing];
}
