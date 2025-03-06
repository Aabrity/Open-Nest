import 'package:json_annotation/json_annotation.dart';
import 'package:open_nest/features/listing/data/model/listing_api_model.dart';


part 'get_all_listing_dto.g.dart';

@JsonSerializable()
class GetAllListingDTO {
  final bool success;
  final int count;
  final List<ListingApiModel> data;

  GetAllListingDTO({
    required this.success,
    required this.count,
    required this.data,
  });

  factory GetAllListingDTO.fromJson(Map<String, dynamic> json) =>
      _$GetAllListingDTOFromJson(json);

  Map<String, dynamic> toJson() => _$GetAllListingDTOToJson(this);
}
