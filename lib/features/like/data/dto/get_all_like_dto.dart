import 'package:json_annotation/json_annotation.dart';
import 'package:open_nest/features/like/data/model/like_api_model.dart';


part 'get_all_like_dto.g.dart';

@JsonSerializable()
class GetAllLikeDTO {
  final bool success;
  final int count;
  final List<LikeApiModel> data;

  GetAllLikeDTO({
    required this.success,
    required this.count,
    required this.data,
  });

  factory GetAllLikeDTO.fromJson(Map<String, dynamic> json) =>
      _$GetAllLikeDTOFromJson(json);

  Map<String, dynamic> toJson() => _$GetAllLikeDTOToJson(this);
}
