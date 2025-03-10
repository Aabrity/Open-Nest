import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:open_nest/core/error/failure.dart';
import 'package:open_nest/features/auth/domain/use_case/login_usecase.dart';
import 'package:open_nest/features/auth/domain/use_case/mock_Auth_Repository.dart';
import 'package:open_nest/features/auth/domain/use_case/mock_token_shared_prefs.dart';

void main() {
  late MockAuthRepository repository;
  late MockTokenSharedPrefs tokenSharedPrefs;
  late LoginUseCase loginUseCase;

  setUp(() {
    repository = MockAuthRepository();
    tokenSharedPrefs = MockTokenSharedPrefs();
    loginUseCase = LoginUseCase(repository, tokenSharedPrefs);
  });

  const loginParams = LoginParams(username: 'testuser', password: 'password123');
  const generatedToken = 'mock_jwt_token';

  group('LoginUseCase Tests', () {
    test('Returns Failure when credentials are incorrect', () async {
      when(() => repository.loginUser(any(), any())).thenAnswer(
        (_) async => const Left(ApiFailure(message: "Invalid user credentials")),
      );

      final result = await loginUseCase(loginParams);

      expect(result, const Left(ApiFailure(message: "Invalid user credentials")));
      verify(() => repository.loginUser(any(), any())).called(1);
      verifyNever(() => tokenSharedPrefs.saveToken(any()));
    });

    test('Returns Failure when username is empty', () async {
      const emptyUsernameParams = LoginParams(username: '', password: 'password123');
      when(() => repository.loginUser(any(), any())).thenAnswer(
        (_) async => const Left(ApiFailure(message: "Username cannot be empty")),
      );

      final result = await loginUseCase(emptyUsernameParams);

      expect(result, const Left(ApiFailure(message: "Username cannot be empty")));
      verify(() => repository.loginUser(any(), any())).called(1);
      verifyNever(() => tokenSharedPrefs.saveToken(any()));
    });

    test('Returns Failure when password is empty', () async {
      const emptyPasswordParams = LoginParams(username: 'testuser', password: '');
      when(() => repository.loginUser(any(), any())).thenAnswer(
        (_) async => const Left(ApiFailure(message: "Password cannot be empty")),
      );

      final result = await loginUseCase(emptyPasswordParams);

      expect(result, const Left(ApiFailure(message: "Password cannot be empty")));
      verify(() => repository.loginUser(any(), any())).called(1);
      verifyNever(() => tokenSharedPrefs.saveToken(any()));
    });

    test('Returns Failure when there is a server error', () async {
      when(() => repository.loginUser(any(), any())).thenAnswer(
        (_) async => const Left(ApiFailure(message: "Internal Server Error")),
      );

      final result = await loginUseCase(loginParams);

      expect(result, const Left(ApiFailure(message: "Internal Server Error")));
      verify(() => repository.loginUser(any(), any())).called(1);
      verifyNever(() => tokenSharedPrefs.saveToken(any()));
    });

  
    test('Returns successfully and returns token', () async {
  // Use a valid JWT token
  const generatedmockToken = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c';

  // Mock the repository and shared preferences
  when(() => repository.loginUser(any(), any()))
      .thenAnswer((_) async => const Right(generatedmockToken));
  when(() => tokenSharedPrefs.saveToken(any()))
      .thenAnswer((_) async => Right(null));
  when(() => tokenSharedPrefs.getToken())
      .thenAnswer((_) async => const Right(generatedmockToken));

  // Call the use case
  final result = await loginUseCase(loginParams);

  // Verify the result and interactions
  expect(result, const Right(generatedmockToken));
  verify(() => repository.loginUser(
      loginParams.username, loginParams.password)).called(1);
  verify(() => tokenSharedPrefs.saveToken(generatedmockToken)).called(1);
  verify(() => tokenSharedPrefs.getToken()).called(1);
});
  });
}
