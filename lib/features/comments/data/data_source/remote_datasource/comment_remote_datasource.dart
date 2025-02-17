import 'package:dio/dio.dart';
import 'package:open_nest/app/constants/api_endpoints.dart';
import 'package:open_nest/features/comments/data/data_source/comment_data_source.dart';
import 'package:open_nest/features/comments/data/dto/get_all_comment_dto.dart';
import 'package:open_nest/features/comments/data/model/comment_api_model.dart';
import 'package:open_nest/features/comments/domain/entity/comment_entity.dart';


class CommentRemoteDataSource implements ICommentDataSource {
  final Dio _dio;

  CommentRemoteDataSource(this._dio);

  @override
  Future<void> createComment(CommentEntity comment) async {
    try {
      // Convert Comment Entity to Comment API Model
      var commentApiModel = CommentApiModel.fromEntity(comment);
      var response = await _dio.post(
        ApiEndpoints.createComment,
        data: commentApiModel.toJson(),
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
  Future<void> deleteComment(String id, String? token) async{
     try {
      var response = await _dio.delete(
        ApiEndpoints.deleteComment + id,
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
  Future<List<CommentEntity>> getComment() async {
    try {
      var response = await _dio.get(ApiEndpoints.getAllComment);
      if (response.statusCode == 200) {
        // Convert API response to DTO
        var commentDTO = GetAllCommentDTO.fromJson(response.data);
        // Convert DTO to Entity
        return CommentApiModel.toEntityList(commentDTO.data);
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
