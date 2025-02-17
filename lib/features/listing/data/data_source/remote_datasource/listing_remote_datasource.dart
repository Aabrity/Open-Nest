import 'package:dio/dio.dart';
import 'package:open_nest/app/constants/api_endpoints.dart';
import 'package:open_nest/features/listing/data/data_source/listing_data_source.dart';
import 'package:open_nest/features/listing/data/dto/get_all_listing_dto.dart';
import 'package:open_nest/features/listing/data/model/listing_api_model.dart';
import 'package:open_nest/features/listing/domain/entity/listing_entity.dart';


class ListingRemoteDataSource implements IListingDataSource {
  final Dio _dio;

  ListingRemoteDataSource(this._dio);

  @override
  Future<void> createListing(ListingEntity listing) async {
    try {
      // Convert Listing Entity to Listing API Model
      var listingApiModel = ListingApiModel.fromEntity(listing);
      var response = await _dio.post(
        ApiEndpoints.createListing,
        data: listingApiModel.toJson(),
      );

      if (response.statusCode == 201) {
        return;
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> deleteListing(String id, String? token) async {
  try {
      var response = await _dio.delete(
        ApiEndpoints.deleteListing + id,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        return;
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<ListingEntity>> getListing() async {
    try {
      var response = await _dio.get(ApiEndpoints.getAllListing);
      if (response.statusCode == 200) {
        // Convert API response to DTO
        var listingDTO = GetAllListingDTO.fromJson(response.data);
        // Convert DTO to Entity
        return ListingApiModel.toEntityList(listingDTO.data);
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }
}
