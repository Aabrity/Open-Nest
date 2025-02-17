import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:open_nest/features/like/domain/entity/like_entity.dart';

part 'like_api_model.g.dart';

@JsonSerializable()
class LikeApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? id;
  final String listing; 

  const LikeApiModel({
    this.id,
    required this.listing,
  });

  factory LikeApiModel.fromJson(Map<String, dynamic> json) =>
      _$LikeApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$LikeApiModelToJson(this);

  // To Entity: Convert LikeApiModel to LikeEntity
  LikeEntity toEntity() {
    return LikeEntity(
      likeId: id, 
      listing: listing, 
    );
  }

  // From Entity: Convert LikeEntity to LikeApiModel
  factory LikeApiModel.fromEntity(LikeEntity entity) {
    return LikeApiModel(
      id: entity.likeId,
      listing: entity.listing,
    );
  }

  // Convert API list to Entity List
  static List<LikeEntity> toEntityList(List<LikeApiModel> models) =>
      models.map((model) => model.toEntity()).toList();

  @override
  List<Object?> get props => [id, listing];
}
