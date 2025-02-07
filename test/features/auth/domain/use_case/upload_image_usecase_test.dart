
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:open_nest/core/error/failure.dart';
import 'package:open_nest/features/auth/domain/use_case/mock_Auth_Repository.dart';
import 'package:open_nest/features/auth/domain/use_case/upload_image_usecase.dart';

void main() {
  late MockAuthRepository repository;
  late UploadImageUsecase uploadImageUsecase;

  setUpAll(() {
    // Register fallback for File type
    registerFallbackValue(File('dummy.txt'));
  });

  setUp(() {
    repository = MockAuthRepository();
    uploadImageUsecase = UploadImageUsecase(repository);
  });

  final mockFile = File('C:\\Users\\User 1\\Desktop\\healthy o\\Open-Nest\\assets\\images\\house 2.png');
  const uploadedImageUrl = 'http://10.0.2.2:3000/uploads/house 2.png';

  group('UploadImageUsecase Tests', () {
    test('Uploads image successfully', () async {
      when(() => repository.uploadProfilePicture(any()))
          .thenAnswer((_) async => const Right(uploadedImageUrl));

      final result = await uploadImageUsecase(UploadImageParams(file: mockFile));

      expect(result, const Right(uploadedImageUrl));
      verify(() => repository.uploadProfilePicture(mockFile)).called(1);
    });

    test('Returns Failure when upload fails due to server error', () async {
      when(() => repository.uploadProfilePicture(any())).thenAnswer(
        (_) async => const Left(ApiFailure(message: "Server Error")),
      );

      final result = await uploadImageUsecase(UploadImageParams(file: mockFile));

      expect(result, const Left(ApiFailure(message: "Server Error")));
      verify(() => repository.uploadProfilePicture(mockFile)).called(1);
    });

    test('Returns Failure when file is invalid', () async {
      final invalidFile = File('');
      when(() => repository.uploadProfilePicture(any())).thenAnswer(
        (_) async => const Left(ApiFailure(message: "Invalid file")),
      );

      final result = await uploadImageUsecase(UploadImageParams(file: invalidFile));

      expect(result, const Left(ApiFailure(message: "Invalid file")));
      verify(() => repository.uploadProfilePicture(invalidFile)).called(1);
    });
  });
}
