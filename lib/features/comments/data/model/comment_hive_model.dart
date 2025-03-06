import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:open_nest/app/constants/hive_table_constant.dart';

import 'package:open_nest/features/comments/domain/entity/comment_entity.dart';
import 'package:uuid/uuid.dart';

part 'comment_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.commentTableId)
class CommentHiveModel extends Equatable {
  @HiveField(0)
  final String commentId;

  @HiveField(1)
  final String listing;

  @HiveField(3)
  final String comment;

  @HiveField(2)
  final String user;



  CommentHiveModel({
    String? commentId,
    required this.listing,
    required this.comment,
    required this.user,
     DateTime? createdAt,
  }) : commentId = commentId ?? const Uuid().v4();
       

  // Initial Constructor
  const CommentHiveModel.initial(this.user)
      : commentId = '',
        listing = '',
        comment = '';
       
    

  // From Entity
  factory CommentHiveModel.fromEntity(CommentEntity entity) {
    return CommentHiveModel(
      commentId: entity.commentId ?? const Uuid().v4(),
      listing: entity.listing,
      comment: entity.comment,
      user: entity.user
      
    );
  }

  // To Entity
  CommentEntity toEntity() {
    return CommentEntity(
      commentId: commentId,
      listing: listing,
      comment: comment,
      user: user,
  
    );
  }

  // To Entity List
  static List<CommentEntity> toEntityList(List<CommentHiveModel> hiveList) {
    return hiveList.map((data) => data.toEntity()).toList();
  }

  // From Entity List
  static List<CommentHiveModel> fromEntityList(List<CommentEntity> entityList) {
    return entityList.map((entity) => CommentHiveModel.fromEntity(entity)).toList();
  }

  @override
  List<Object?> get props => [commentId, listing, comment, user];
}
