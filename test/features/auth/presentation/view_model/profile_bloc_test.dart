import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:dartz/dartz.dart';
import 'package:open_nest/core/error/failure.dart';
import 'package:open_nest/features/auth/domain/entity/auth_entity.dart';
import 'package:open_nest/features/auth/domain/use_case/get_Current_user.dart';
import 'package:open_nest/features/auth/domain/use_case/update_user.dart';
import 'package:open_nest/features/auth/presentation/view_model/profile_event.dart';
import 'package:open_nest/features/auth/presentation/view_model/profile_state.dart';
import 'package:open_nest/features/auth/presentation/view_model/profile_bloc.dart';

// Mock the use cases
class MockFetchCurrentUserUseCase extends Mock implements FetchCurrentUserUseCase {}

class MockUpdateUserUsecase extends Mock implements UpdateUserUsecase {}

void main() {
  late MockFetchCurrentUserUseCase mockFetchCurrentUserUseCase;
  late MockUpdateUserUsecase mockUpdateUserUsecase;
  late UserBloc userBloc;

  setUp(() {
    mockFetchCurrentUserUseCase = MockFetchCurrentUserUseCase();
    mockUpdateUserUsecase = MockUpdateUserUsecase();
    userBloc = UserBloc(
      fetchCurrentUserUseCase: mockFetchCurrentUserUseCase,
      updateUserUsecase: mockUpdateUserUsecase,
    );
  });

  tearDown(() {
    userBloc.close();
  });

  // Test data
  const authEntity = AuthEntity(
    username: 'test_user',
    email: 'test@example.com',
    userId: '123',
    avatar: 'avatar_base64',
    isAdmin: false,
    subscription: false, password: 'password',
  );

  const updateUserParams = UpdateUserParams(
    username: 'updated_user',
    email: 'updated@example.com',
    avatar: 'updated_avatar_base64',
  );

  group('UserBloc - FetchUserEvent', () {
    blocTest<UserBloc, UserState>(
      'emits [UserLoading, UserLoaded] when FetchUserEvent is added and use case succeeds',
      build: () {
        when(() => mockFetchCurrentUserUseCase())
            .thenAnswer((_) async => const Right(authEntity));
        return userBloc;
      },
      act: (bloc) => bloc.add(const FetchUserEvent()),
      expect: () => [
        UserLoading(),
        const UserLoaded(
          username: 'test_user',
          email: 'test@example.com',
          userId: '123',
          avatarBase64: 'avatar_base64',
          isAdmin: false,
          subscription: false,
        ),
      ],
    );

    blocTest<UserBloc, UserState>(
      'emits [UserLoading, UserError] when FetchUserEvent is added and use case fails',
      build: () {
        when(() => mockFetchCurrentUserUseCase())
            .thenAnswer((_) async => Left(ApiFailure(message: 'Failed to fetch user')));
        return userBloc;
      },
      act: (bloc) => bloc.add(const FetchUserEvent()),
      expect: () => [
        UserLoading(),
        const UserError('Failed to fetch user'),
      ],
    );
  });


    blocTest<UserBloc, UserState>(
      'emits [UserLoading, UserLoaded] when FetchUserusecase succeeds',
      build: () {
        when(() => mockFetchCurrentUserUseCase())
            .thenAnswer((_) async => const Right(authEntity));
        return userBloc;
      },
      act: (bloc) => bloc.add(const FetchUserEvent()),
      expect: () => [
        UserLoading(),
        const UserLoaded(
          username: 'test_user',
          email: 'test@example.com',
          userId: '123',
          avatarBase64: 'avatar_base64',
          isAdmin: false,
          subscription: false,
        ),
      ],
    );

        blocTest<UserBloc, UserState>(
      'emits [UserLoading, UserError] when cant fetch data after complete update',
      build: () {
        when(() => mockUpdateUserUsecase(updateUserParams))
            .thenAnswer((_) async => const Right(null));
        when(() => mockFetchCurrentUserUseCase())
            .thenAnswer((_) async => Left(ApiFailure(message: 'Failed to fetch user')));
        return userBloc;
      },
      act: (bloc) => bloc.add(const UpdateUserEvent(updateUserParams)),
      expect: () => [
        UserLoading(),
        const UserError('Failed to fetch user'),
      ],
    );

  group('UserBloc - UpdateUserEvent', () {
    blocTest<UserBloc, UserState>(
      'emits [UserLoading, UserLoaded] when UpdateUserEvent is added and update succeeds',
      build: () {
        when(() => mockUpdateUserUsecase(updateUserParams))
            .thenAnswer((_) async => const Right(null));
        when(() => mockFetchCurrentUserUseCase())
            .thenAnswer((_) async => const Right(authEntity));
        return userBloc;
      },
      act: (bloc) => bloc.add(const UpdateUserEvent(updateUserParams)),
      expect: () => [
        UserLoading(),
        const UserLoaded(
          username: 'test_user',
          email: 'test@example.com',
          userId: '123',
          avatarBase64: 'avatar_base64',
          isAdmin: false,
          subscription: false,
        ),
      ],
    );

    blocTest<UserBloc, UserState>(
      'emits [UserLoading, UserError] when UpdateUserEvent is added and update fails',
      build: () {
        when(() => mockUpdateUserUsecase(updateUserParams))
            .thenAnswer((_) async => Left(ApiFailure(message: 'Failed to update user')));
        return userBloc;
      },
      act: (bloc) => bloc.add(const UpdateUserEvent(updateUserParams)),
      expect: () => [
        UserLoading(),
        const UserError('Failed to update user'),
      ],
    );

    blocTest<UserBloc, UserState>(
      'emits [UserLoading, UserError] when UpdateUserEvent is added, update succeeds, but fetch fails',
      build: () {
        when(() => mockUpdateUserUsecase(updateUserParams))
            .thenAnswer((_) async => const Right(null));
        when(() => mockFetchCurrentUserUseCase())
            .thenAnswer((_) async => Left(ApiFailure(message: 'Failed to fetch user')));
        return userBloc;
      },
      act: (bloc) => bloc.add(const UpdateUserEvent(updateUserParams)),
      expect: () => [
        UserLoading(),
        const UserError('Failed to fetch user'),
      ],
    );
  });
}