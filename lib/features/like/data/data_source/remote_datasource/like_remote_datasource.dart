import 'package:dio/dio.dart';
import 'package:open_nest/app/constants/api_endpoints.dart';
import 'package:open_nest/features/like/data/data_source/like_data_source.dart';
import 'package:open_nest/features/like/data/dto/get_all_like_dto.dart';
import 'package:open_nest/features/like/data/model/like_api_model.dart';
import 'package:open_nest/features/like/domain/entity/like_entity.dart';


class LikeRemoteDataSource implements ILikeDataSource {
  final Dio _dio;

  LikeRemoteDataSource(this._dio);

  @override
  Future<void> createLike(LikeEntity listing) async {
    try {
      // Convert Like Entity to Like API Model
      var likeApiModel = LikeApiModel.fromEntity(listing);
      var response = await _dio.post(
        ApiEndpoints.createLike,
        data: likeApiModel.toJson(),
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
  Future<void> deleteLike(String id, String? token) async {
     try {
      var response = await _dio.delete(
        ApiEndpoints.deleteLike + id,
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
  Future<List<LikeEntity>> getLike() async {
    try {
      var response = await _dio.get(ApiEndpoints.getAllLike);
      if (response.statusCode == 200) {
        // Convert API response to DTO
        var likeDTO = GetAllLikeDTO.fromJson(response.data);
        // Convert DTO to Entity
        return LikeApiModel.toEntityList(likeDTO.data);
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
