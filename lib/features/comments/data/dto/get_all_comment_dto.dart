import 'package:json_annotation/json_annotation.dart';
import 'package:open_nest/features/comments/data/model/comment_api_model.dart';


part 'get_all_comment_dto.g.dart';

@JsonSerializable()
class GetAllCommentDTO {
  final bool success;
  final int count;
  final List<CommentApiModel> data;

  GetAllCommentDTO({
    required this.success,
    required this.count,
    required this.data,
  });

  factory GetAllCommentDTO.fromJson(Map<String, dynamic> json) =>
      _$GetAllCommentDTOFromJson(json);

  Map<String, dynamic> toJson() => _$GetAllCommentDTOToJson(this);
}
