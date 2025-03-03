part of 'user_listing_bloc.dart';

class UserListingState extends Equatable {
  final bool isLoading;
  final List<ListingEntity> listings;
  final String? error;
  final String? currentUserId;

  const UserListingState({
    required this.isLoading,
    required this.listings,
    this.error,
    this.currentUserId,
  });

  /// Initial state
  factory UserListingState.initial() {
    return const UserListingState(
      isLoading: false,
      listings: [],
      error: null,
      currentUserId: null,
    );
  }

  /// CopyWith method to easily create a new state with updated values
  UserListingState copyWith({
    bool? isLoading,
    List<ListingEntity>? listings,
    String? error,
    String? currentUserId,
  }) {
    return UserListingState(
      isLoading: isLoading ?? this.isLoading,
      listings: listings ?? this.listings,
      error: error ?? this.error,
      currentUserId: currentUserId ?? this.currentUserId,
    );
  }

  @override
  List<Object?> get props => [isLoading, listings, error, currentUserId];
}