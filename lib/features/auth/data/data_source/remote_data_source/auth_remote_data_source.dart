import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:open_nest/core/error/failure.dart';
import 'package:open_nest/features/auth/data/dto/get_user_DTO.dart';
import 'package:open_nest/features/auth/data/model/auth_api_model.dart';
import '../../../../../app/constants/api_endpoints.dart';
import '../../../domain/entity/auth_entity.dart';
import '../auth_data_source.dart';

class AuthRemoteDataSource implements IAuthDataSource {
  final Dio _dio;

  AuthRemoteDataSource(this._dio);
  
  @override
  Future<void> registerUser(AuthEntity user) async {
    try {
      Response response = await _dio.post(
        ApiEndpoints.register,
        data: {
          "username": user.username,
          "email": user.email,
          "password": user.password,
          "avatar": user.avatar,
          "isAdmin": user.isAdmin,
          "subscription": user.subscription,
        },
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

  // @override
  // Future<AuthEntity> getCurrentUser( String id, String? token,) async {
  // try {
  //    var response = await _dio.get(ApiEndpoints.getMe + id, options: Options(
  //         headers: {
  //           'Authorization': 'Bearer $token',
  //         },
  //       ),);
     
  //     if (response.statusCode == 200) {
  //       // Convert API response to DTO
  //       var userDTO = GetUserDTO.fromJson(response.data);
  //       // var authApiModel = AuthApiModel.fromJson(userDTO.data); 
  //        debugPrint("remote data: ${response.data}");
  //       // Convert DTO to Entity
  //       var authy = userDTO.data;
  //       return AuthApiModel.toEntity();
  //     } else {
  //       throw Exception(response.statusMessage);
  //     }
  //   } on DioException catch (e) {
  //     throw Exception(e);
  //   } catch (e) {
  //     throw Exception(e);
  //   }
  // }

  @override
Future<AuthEntity> getCurrentUser(String id, String? token) async {
  try {
    var response = await _dio.get(
      ApiEndpoints.getMe + id,
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );

    if (response.statusCode == 200) {
      // debugPrint("remote data: ${response.data}");

      var userDTO = GetUserDTO.fromJson(response.data);
      // debugPrint("___________________________---------------remote data: $userDTO");
       var t = userDTO.data.toEntity();
      //  debugPrint("________________tttttttttttttttttttttttttttttttttt___________---------------remote data: $t");
      return t; // FIXED: using instance method
    } else {
      throw Exception('Failed to fetch user: ${response.statusMessage}');
    }
  } on DioException catch (e) {
    throw Exception('Dio error: ${e.message}');
  } catch (e) {
    throw Exception('Unexpected error: $e');
  }
}


  @override
  Future<String> loginUser(String username, String password) async {
    try {
      Response response = await _dio.post(
        ApiEndpoints.login,
        data: {
          "username": username,
          "password": password,
        },
      );

      if (response.statusCode == 200) {
        final str = response.data['token'];
        return str;
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
  Future<String> uploadProfilePicture(File file) async {
    try {
      String fileName = file.path.split('/').last;
      FormData formData = FormData.fromMap(
        {
          'profilePicture': await MultipartFile.fromFile(
            file.path,
            filename: fileName,
          ),
        },
      );

      Response response = await _dio.post(
        ApiEndpoints.uploadImage,
        data: formData,
      );

      if (response.statusCode == 200) {
        // Extract the image name from the response
        final str = response.data['data'];

        return str;
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
Future<Either<Failure, void>> updateUser(String id, AuthEntity updatedUser, String token) async {
  try {
    // Convert ListingEntity to API model
    var authApiModel = AuthApiModel.fromEntity(updatedUser);

    // Send PUT request to update listing
    var response = await _dio.put(
      (ApiEndpoints.updateUser + id), // Ensure API endpoint is correct
      data: authApiModel.toJson(),
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      ),
    );

    if (response.statusCode == 200) {
      return const Right(null); 
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
