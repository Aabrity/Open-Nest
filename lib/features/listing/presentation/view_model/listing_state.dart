part of 'listing_bloc.dart';

class ListingState extends Equatable {
  final bool isLoading;
  final List<ListingEntity> listings;
  final String? error;

  const ListingState({
    required this.isLoading,
    required this.listings,
    this.error,
  });

  factory ListingState.initial() {
    return ListingState(
      isLoading: false,
      listings: [],
     
    );
  }

  ListingState copyWith({
    bool? isLoading,
    List<ListingEntity>? listings,
    String? error,
  }) {
    return ListingState(
      isLoading: isLoading ?? this.isLoading,
      listings: listings ?? this.listings,
      error: error 
    );
  }

  @override
  List<Object?> get props => [isLoading, listings, error];
}
