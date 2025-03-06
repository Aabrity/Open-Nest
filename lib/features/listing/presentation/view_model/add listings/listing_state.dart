part of 'listing_bloc.dart';

class ListingState extends Equatable {
  final bool isLoading;
  final List<ListingEntity> listings;
  final String? error;
  final String? currentUserId;

  const ListingState({
    required this.isLoading,
    required this.listings,
    this.error,
     this.currentUserId,
  });

  factory ListingState.initial() {
    return ListingState(
      isLoading: false,
      listings: [],
      currentUserId: null,
     
    );
  }

  ListingState copyWith({
    bool? isLoading,
    List<ListingEntity>? listings,
    String? error,
    String? currentUserId,
  }) {
    return ListingState(
      isLoading: isLoading ?? this.isLoading,
      listings: listings ?? this.listings,
      error: error ,
      currentUserId: currentUserId ?? this.currentUserId,
    );
  }

  @override
  List<Object?> get props => [isLoading, listings, error, currentUserId];
}