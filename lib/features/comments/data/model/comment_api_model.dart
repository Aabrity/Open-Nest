import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:open_nest/features/comments/domain/entity/comment_entity.dart';  

part 'comment_api_model.g.dart';

@JsonSerializable()
class CommentApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? id;
  final String listing; 
  final String comment;
  final String user;

  const CommentApiModel({
    this.id,
    required this.listing,
    required this.comment,
    required this.user,
  });

  factory CommentApiModel.fromJson(Map<String, dynamic> json) =>
      _$CommentApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$CommentApiModelToJson(this);

  // To Entity: Convert CommentApiModel to CommentEntity
  CommentEntity toEntity() {
    return CommentEntity(
      commentId: id, // id maps to commentId in CommentEntity
      listing: listing, // listing maps to listingId in CommentEntity
      comment: comment,
      user: user, // comment maps to commentText in CommentEntity
    );
  }

  // From Entity: Convert CommentEntity to CommentApiModel
  factory CommentApiModel.fromEntity(CommentEntity entity) {
    return CommentApiModel(
      id: entity.commentId, 
      listing: entity.listing, 
      comment: entity.comment,
      user: entity.user,
    );
  }

  // Convert List of CommentApiModel to List of CommentEntity
  static List<CommentEntity> toEntityList(List<CommentApiModel> models) {
    return models.map((model) => model.toEntity()).toList();
  }

  // Convert List of CommentEntity to List of CommentApiModel
  static List<CommentApiModel> fromEntityList(List<CommentEntity> entities) {
    return entities.map((entity) => CommentApiModel.fromEntity(entity)).toList();
  }

  @override
  List<Object?> get props => [id, listing, comment, user];
}
