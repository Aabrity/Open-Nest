import 'package:json_annotation/json_annotation.dart';
import 'package:open_nest/features/auth/data/model/auth_api_model.dart';
import 'package:open_nest/features/comments/data/model/comment_api_model.dart';


part 'get_user_DTO.g.dart';

@JsonSerializable()
class GetUserDTO {
  final bool success;
  final AuthApiModel data;

  GetUserDTO({
    required this.success,
    required this.data,
  });

  factory GetUserDTO.fromJson(Map<String, dynamic> json) =>
      _$GetUserDTOFromJson(json);

  Map<String, dynamic> toJson() => _$GetUserDTOToJson(this);
}
