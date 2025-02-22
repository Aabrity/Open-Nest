import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:open_nest/app/constants/api_endpoints.dart';
import 'package:open_nest/core/error/failure.dart';
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
        var listingAddDTO = GetAllListingDTO.fromJson(response.data);
        // debugPrint("remote data: $listingAddDTO");
        debugPrint("remote data: ${response.data}");
        // Convert DTO to Entity 
        return ListingApiModel.toEntityList(listingAddDTO.data);
        
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
Future<Either<Failure, void>> updateListing(String id, ListingEntity updatedListing, String token) async {
  try {
    // Convert ListingEntity to API model
    var listingApiModel = ListingApiModel.fromEntity(updatedListing);

    // Send PUT request to update listing
    var response = await _dio.put(
      (ApiEndpoints.updateListing + id), // Ensure API endpoint is correct
      data: listingApiModel.toJson(),
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      ),
    );

    if (response.statusCode == 200) {
      return const Right(null); // Successful update
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
