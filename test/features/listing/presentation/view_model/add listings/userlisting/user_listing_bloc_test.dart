import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:open_nest/core/error/failure.dart';
import 'package:open_nest/features/listing/presentation/view_model/add%20listings/userlisting/user_listing_bloc.dart';
import 'package:test/test.dart';
import 'package:open_nest/features/listing/domain/entity/listing_entity.dart';
import 'package:open_nest/features/listing/domain/use_case/get_listing_by_id_usecase.dart';
// import 'package:open_nest/features/listing/presentation/bloc/user_listing_bloc.dart';

// Mock the GetUserListingUsecase
class MockGetUserListingUsecase extends Mock implements GetUserListingUsecase {}

void main() {
  late MockGetUserListingUsecase mockGetUserListingUsecase;
  late UserListingBloc userListingBloc;

  setUp(() {
    mockGetUserListingUsecase = MockGetUserListingUsecase();
    userListingBloc = UserListingBloc(getUserListingUsecase: mockGetUserListingUsecase);
  });

  tearDown(() {
    userListingBloc.close();
  });

  // Test data
  const userId = 'user123';
  final listings = [
    ListingEntity( name: 'Listing 1', description: 'Description 1', address: 'boudha', regularPrice: 30000, bathrooms: 4, bedrooms: 3, furnished: true, parking: false, type: 'rent', offer: false, imageUrls: ["qwertyuio"], userRef: 'user1'),
    ListingEntity( name: 'Listing 2', description: 'Description 2', address: 'boudha', regularPrice: 30000, bathrooms: 4, bedrooms: 3, furnished: true, parking: false, type: 'rent', offer: false, imageUrls: ["qwertyuio"], userRef: 'user2'),
  ];

  group('UserListingBloc', () {
    blocTest<UserListingBloc, UserListingState>(
      'emits [loading, loaded] when LoadUserListing is added and use case succeeds',
      build: () {
        // Mock the use case to return a successful result
        when(() => mockGetUserListingUsecase()).thenAnswer((_) async => Right(listings));
        return userListingBloc;
      },
      act: (bloc) => bloc.add(LoadUserListing(userId)),
      expect: () => [
        UserListingState.initial().copyWith(isLoading: true), // Loading state
        UserListingState.initial().copyWith(
          isLoading: false,
          listings: listings,
          currentUserId: userId,
        ), // Loaded state
      ],
    );

    blocTest<UserListingBloc, UserListingState>(
      'emits [loading, error] when LoadUserListing is added and use case fails',
      build: () {
        // Mock the use case to return a failure
        when(() => mockGetUserListingUsecase()).thenAnswer(
          (_) async => Left(ApiFailure(message: 'Failed to load listings')),
        );
        return userListingBloc;
      },
      act: (bloc) => bloc.add(LoadUserListing(userId)),
      expect: () => [
        UserListingState.initial().copyWith(isLoading: true), // Loading state
        UserListingState.initial().copyWith(
          isLoading: false,
          error: 'Failed to load listings',
        ), // Error state
      ],
    );



        blocTest<UserListingBloc, UserListingState>(
      'emits [loading, error] failing of usecase due to loading error',
      build: () {
        // Mock the use case to return a failure
        when(() => mockGetUserListingUsecase()).thenAnswer(
          (_) async => Left(ApiFailure(message: 'Failed to load listings')),
        );
        return userListingBloc;
      },
      act: (bloc) => bloc.add(LoadUserListing(userId)),
      expect: () => [
        UserListingState.initial().copyWith(isLoading: true), // Loading state
        UserListingState.initial().copyWith(
          isLoading: false,
          error: 'Failed to load listings',
        ), // Error state
      ],
    );
  });
}