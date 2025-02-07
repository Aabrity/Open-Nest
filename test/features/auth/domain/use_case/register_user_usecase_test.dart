
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:open_nest/core/error/failure.dart';
import 'package:open_nest/features/auth/domain/entity/auth_entity.dart';
import 'package:open_nest/features/auth/domain/use_case/Mock_Auth_Repository.dart';
import 'package:open_nest/features/auth/domain/use_case/register_user_usecase.dart';


void main() {
  late MockAuthRepository repository;
  late RegisterUseCase registerUsecase;

  setUp(() {
    repository = MockAuthRepository();
    registerUsecase = RegisterUseCase(repository);
    registerFallbackValue(const AuthEntity.empty());
  });

  const validRegisterParams = RegisterUserParams(
   username: 'newuser',
    email: 'newuser@example.com',
    password: 'newpassword123',
    avatar: 'avatar.png',
  );

  group('RegisterUsecase Tests', () {
    test('Returns Failure when any field is empty', () async {
      // Arrange
      const invalidParams = RegisterUserParams(
      username: 'newuser',
      email: 'newuser@example.com',
      password: 'newpassword123',
      avatar: 'avatar.png',
      );
      when(() => repository.registerUser(any())).thenAnswer((_) async =>
          const Left(ApiFailure(message: "All fields are required")));

      // Act
      final result = await registerUsecase(invalidParams);

      // Assert
      expect(
          result, const Left(ApiFailure(message: "All fields are required")));
      verify(() => repository.registerUser(any())).called(1);
    });

    test('Returns Failure when email format is invalid', () async {
      // Arrange
      const invalidEmailParams = RegisterUserParams(
      username: 'newuser',
      email: 'newuser@example.com',
      password: 'newpassword123',
      avatar: 'avatar.png',
      );
      when(() => repository.registerUser(any())).thenAnswer(
          (_) async => const Left(ApiFailure(message: "Invalid email format")));

      // Act
      final result = await registerUsecase(invalidEmailParams);

      // Assert
      expect(result, const Left(ApiFailure(message: "Invalid email format")));
      verify(() => repository.registerUser(any())).called(1);
    });

    test('Returns Failure when server returns an error', () async {
      // Arrange
      when(() => repository.registerUser(any())).thenAnswer((_) async =>
          const Left(ApiFailure(message: "Internal Server Error")));

      // Act
      final result = await registerUsecase(validRegisterParams);

      // Assert
      expect(result, const Left(ApiFailure(message: "Internal Server Error")));
      verify(() => repository.registerUser(any())).called(1);
    });

    test('Returns successfully when all fields are valid', () async {
      // Arrange
      when(() => repository.registerUser(any()))
          .thenAnswer((_) async => const Right(null));

      // Act
      final result = await registerUsecase(validRegisterParams);

      // Assert
      expect(result, const Right(null));
      verify(() => repository.registerUser(any())).called(1);
    });
  });
}
